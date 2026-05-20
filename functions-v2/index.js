const { onDocumentCreated, onDocumentUpdated } = require("firebase-functions/v2/firestore");
const { onSchedule } = require("firebase-functions/v2/scheduler");
const { defineSecret } = require("firebase-functions/params");
const admin = require("firebase-admin");

admin.initializeApp();

const geminiApiKey = defineSecret("GEMINI_API_KEY");
const GEMINI_MODEL = process.env.GEMINI_MODEL || "gemini-3-flash-preview";

exports.onChatMessageCreated = onDocumentCreated("chat_rooms/{roomId}/messages/{messageId}", async (event) => {
    const snapshot = event.data;
    if (!snapshot) {
        console.log("No data associated with the event");
        return;
    }

    const messageData = snapshot.data();
    const { roomId, messageId } = event.params;
    const senderId = messageData.senderId;

    // 1. Get Chat Room Info
    const roomRef = admin.firestore().collection("chat_rooms").doc(roomId);
    const roomDoc = await roomRef.get();

    if (!roomDoc.exists) {
        console.error(`Chat room ${roomId} not found`);
        return;
    }

    const roomData = roomDoc.data();
    const participants = roomData.participants || [];

    // 2. Identify Recipient
    const recipientId = participants.find(uid => uid !== senderId);

    if (!recipientId) {
        console.log("No recipient found in participants");
        return;
    }

    // 3. Check Blocking Status
    const blockedByRecipientDoc = await admin.firestore()
        .collection("users").doc(recipientId)
        .collection("blocked_users").doc(senderId).get();
    
    const blockedBySenderDoc = await admin.firestore()
        .collection("users").doc(senderId)
        .collection("blocked_users").doc(recipientId).get();

    if (blockedByRecipientDoc.exists || blockedBySenderDoc.exists) {
        console.log(`Notification skipped: User ${senderId} or ${recipientId} is blocked`);
        return;
    }

    // 4. Create Notification Document
    const notificationId = `${roomId}_${messageId}_chat`;
    const messagePreview = messageData.text 
        ? (messageData.text.length > 50 ? messageData.text.substring(0, 47) + "..." : messageData.text)
        : "Mengirim foto"; // Fallback for image messages

    const senderName = senderId === roomData.sellerId ? "Seller" : "Buyer"; // Simplified, ideally get from user profile

    const notificationData = {
        id: notificationId,
        recipientId: recipientId,
        senderId: senderId,
        type: "marketplace_chat_message",
        titleKey: "fcm.chat.newMessage.title",
        bodyKey: "fcm.chat.newMessage.body",
        titleParams: {},
        bodyParams: {
            name: senderName,
            message: messagePreview
        },
        chatRoomId: roomId,
        dealId: roomData.dealId,
        productId: roomData.productId,
        route: `/chat/${roomId}`,
        isRead: false,
        priority: "normal",
        countryCode: roomData.countryCode || "ID",
        createdAt: admin.firestore.FieldValue.serverTimestamp()
    };

    await admin.firestore().collection("notifications").doc(notificationId).set(notificationData);

    // 5. Send FCM Push
    const tokensSnapshot = await admin.firestore()
        .collection("users").doc(recipientId)
        .collection("fcm_tokens")
        .where("isActive", "==", true)
        .get();

    if (tokensSnapshot.empty) {
        console.log(`No active FCM tokens for user ${recipientId}`);
        return;
    }

    const tokens = tokensSnapshot.docs.map(doc => doc.id);
    
    const payload = {
        notification: {
            title: "Pesan Baru",
            body: `${senderName}: ${messagePreview}`
        },
        data: {
            type: "marketplace_chat_message",
            route: `/chat/${roomId}`,
            chatRoomId: roomId,
            dealId: roomData.dealId || "",
            productId: roomData.productId || "",
            notificationId: notificationId
        },
        tokens: tokens
    };

    try {
        const response = await admin.messaging().sendEachForMulticast(payload);
        console.log(`Successfully sent ${response.successCount} messages`);

        // Handle failure results (e.g. invalid tokens)
        if (response.failureCount > 0) {
            const failedTokens = [];
            response.responses.forEach((resp, idx) => {
                if (!resp.success) {
                    const error = resp.error;
                    if (error.code === "messaging/registration-token-not-registered" ||
                        error.code === "messaging/invalid-registration-token") {
                        failedTokens.push(tokens[idx]);
                    }
                }
            });

            if (failedTokens.length > 0) {
                const batch = admin.firestore().batch();
                failedTokens.forEach(token => {
                    const tokenRef = admin.firestore()
                        .collection("users").doc(recipientId)
                        .collection("fcm_tokens").doc(token);
                    batch.update(tokenRef, { isActive: false, updatedAt: admin.firestore.FieldValue.serverTimestamp() });
                });
                await batch.commit();
                console.log(`Deactivated ${failedTokens.length} invalid tokens`);
            }
        }
    } catch (error) {
        console.error("Error sending FCM:", error);
    }
});

/**
 * Jobs: On New Applicant Created
 */
exports.onJobApplicantCreated = onDocumentCreated("job_posts/{jobId}/applicants/{applicantId}", async (event) => {
    const snapshot = event.data;
    if (!snapshot) return;

    const applicantData = snapshot.data();
    const { jobId, applicantId } = event.params;

    // 1. Get Job Info
    const jobDoc = await admin.firestore().collection("job_posts").doc(jobId).get();
    if (!jobDoc.exists) return;

    const jobData = jobDoc.data();
    const ownerId = jobData.ownerId;

    // Don't notify if owner is applying
    if (ownerId === applicantId) return;

    const notificationId = `${jobId}_${applicantId}_application_received`;

    const notificationData = {
        id: notificationId,
        recipientId: ownerId,
        senderId: applicantId,
        type: "job_application_received",
        titleKey: "fcm.jobs.applicationReceived.title",
        bodyKey: "fcm.jobs.applicationReceived.body",
        titleParams: {},
        bodyParams: {
            applicantName: applicantData.applicantName || "Seorang pengguna",
            jobTitle: jobData.title
        },
        jobId: jobId,
        applicantId: applicantId,
        route: `/jobs/${jobId}/applicants`,
        isRead: false,
        priority: "normal",
        countryCode: jobData.countryCode || "ID",
        createdAt: admin.firestore.FieldValue.serverTimestamp()
    };

    await admin.firestore().collection("notifications").doc(notificationId).set(notificationData, { merge: true });

    // 2. Send FCM Push
    const fcmPayload = {
        notification: {
            title: "Pelamar baru",
            body: `${applicantData.applicantName || "Seorang pengguna"} melamar ke ${jobData.title}`
        },
        data: {
            type: "job_application_received",
            route: `/jobs/${jobId}/applicants`,
            jobId: jobId,
            applicantId: applicantId,
            notificationId: notificationId
        }
    };

    await sendPushToUser(ownerId, fcmPayload);
});

/**
 * Jobs: On Applicant Status Updated
 */
exports.onJobApplicantStatusUpdated = onDocumentUpdated("job_posts/{jobId}/applicants/{applicantId}", async (event) => {
    const beforeData = event.data.before.data();
    const afterData = event.data.after.data();
    const { jobId, applicantId } = event.params;

    if (beforeData.status === afterData.status) return;

    const newStatus = afterData.status;

    // 1. Get Job Info
    const jobDoc = await admin.firestore().collection("job_posts").doc(jobId).get();
    if (!jobDoc.exists) return;

    const jobData = jobDoc.data();
    const ownerId = jobData.ownerId;

    const notificationId = `${jobId}_${applicantId}_status_${newStatus}`;

    const statusLabels = {
        'newApplicant': 'Baru',
        'contacted': 'Dihubungi',
        'shortlisted': 'Shortlist',
        'rejected': 'Ditolak',
        'hired': 'Diterima'
    };
    const statusText = statusLabels[newStatus] || newStatus;

    const notificationData = {
        id: notificationId,
        recipientId: applicantId,
        senderId: ownerId,
        type: "job_applicant_status_updated",
        titleKey: "fcm.jobs.statusUpdated.title",
        bodyKey: "fcm.jobs.statusUpdated.body",
        titleParams: {},
        bodyParams: {
            jobTitle: jobData.title,
            status: statusText
        },
        jobId: jobId,
        applicantId: applicantId,
        route: `/jobs/${jobId}`,
        isRead: false,
        priority: "normal",
        countryCode: jobData.countryCode || "ID",
        createdAt: admin.firestore.FieldValue.serverTimestamp()
    };

    await admin.firestore().collection("notifications").doc(notificationId).set(notificationData, { merge: true });

    // 2. Send FCM Push
    const fcmPayload = {
        notification: {
            title: "Status lamaran diperbarui",
            body: `Lamaran kamu untuk ${jobData.title}: ${statusText}`
        },
        data: {
            type: "job_applicant_status_updated",
            route: `/jobs/${jobId}`,
            jobId: jobId,
            applicantId: applicantId,
            notificationId: notificationId
        }
    };

    await sendPushToUser(applicantId, fcmPayload);
});

/**
 * Shared Helper: Send Push to User
 */
async function sendPushToUser(userId, payload) {
    const tokensSnapshot = await admin.firestore()
        .collection("users").doc(userId)
        .collection("fcm_tokens")
        .where("isActive", "==", true)
        .get();

    if (tokensSnapshot.empty) {
        console.log(`No active FCM tokens for user ${userId}`);
        return;
    }

    const tokens = tokensSnapshot.docs.map(doc => doc.id);
    
    const multicastPayload = {
        ...payload,
        tokens: tokens
    };

    try {
        const response = await admin.messaging().sendEachForMulticast(multicastPayload);
        console.log(`Successfully sent ${response.successCount} messages to ${userId}`);

        if (response.failureCount > 0) {
            const failedTokens = [];
            response.responses.forEach((resp, idx) => {
                if (!resp.success) {
                    const error = resp.error;
                    if (error.code === "messaging/registration-token-not-registered" ||
                        error.code === "messaging/invalid-registration-token") {
                        failedTokens.push(tokens[idx]);
                    }
                }
            });

            if (failedTokens.length > 0) {
                const batch = admin.firestore().batch();
                failedTokens.forEach(token => {
                    const tokenRef = admin.firestore()
                        .collection("users").doc(userId)
                        .collection("fcm_tokens").doc(token);
                    batch.update(tokenRef, { isActive: false, updatedAt: admin.firestore.FieldValue.serverTimestamp() });
                });
                await batch.commit();
                console.log(`Deactivated ${failedTokens.length} invalid tokens for ${userId}`);
            }
        }
    } catch (error) {
        console.error(`Error sending FCM to ${userId}:`, error);
    }
}

const { onCall, onRequest, HttpsError } = require("firebase-functions/v2/https");
const axios = require("axios");

/**
 * Smart Feed: Interaction Logging
 */
const ALLOWED_FEED_INTERACTION_TYPES = ["impression", "card_tap", "detail_open", "cta_tap", "semantic_intent"];
const FORBIDDEN_FEED_INTERACTION_FIELDS = [
    "intent", "searchQuery", "query", "email", "phone", 
    "exactAddress", "paymentId", "auditId", "fcmToken", 
    "prompt", "userId", "ownerId"
];

const ALLOWED_SOURCE_TYPES = [
    "job",
    "marketplaceProduct",
    "localNews",
    "store",
    "community"
];

const FORBIDDEN_TOP_LEVEL_FIELDS = [
    "searchQuery",
    "query",
    "email",
    "phone",
    "phoneNumber",
    "nik",
    "ktp",
    "exactGeoPoint"
];

function classifyFeedInteractionAbuse(payload) {
    let isSuspicious = false;
    let reason = null;
    let severity = "none";

    const pos = parseInt(payload.position);
    if (!isNaN(pos) && (pos < 0 || pos > 500)) {
        isSuspicious = true;
        reason = "suspicious_position";
        severity = "medium";
    }

    if (payload.dwellMs && parseInt(payload.dwellMs) > 60000) {
        isSuspicious = true;
        reason = "dwell_too_long";
        severity = "high";
    }

    return { isSuspicious, reason, severity };
}

function sanitizeFeedInteractionMetadata(metadata) {
    const cleanedMetadata = {};
    if (metadata && typeof metadata === 'object') {
        Object.keys(metadata).forEach(key => {
            if (!FORBIDDEN_FEED_INTERACTION_FIELDS.includes(key)) {
                cleanedMetadata[key] = metadata[key];
            }
        });
    }
    return cleanedMetadata;
}

function clampInteractionPosition(position) {
    const pos = parseInt(position);
    if (isNaN(pos)) return 0;
    return Math.max(0, Math.min(pos, 100));
}

function isAllowedFeedInteractionType(eventType) {
    return ALLOWED_FEED_INTERACTION_TYPES.includes(eventType);
}

function sanitizeFeedInteractionPayload(data, uid) {
    FORBIDDEN_TOP_LEVEL_FIELDS.forEach(field => {
        if (data[field] !== undefined) {
            throw new HttpsError("invalid-argument", `Forbidden top-level field: ${field}`);
        }
    });

    const {
        eventType,
        feedItemId,
        sourceId,
        sourceType,
        route,
        position,
        isPromoted,
        hasSemanticIntent,
        intentLengthBucket,
        countryCode,
        locationParts,
        clientCreatedAt,
        metadata = {},
        sessionId,
        impressionMode,
        visibleRatio,
        dwellMs
    } = data;

    if (!eventType || !isAllowedFeedInteractionType(eventType)) {
        throw new HttpsError("invalid-argument", `Invalid event type: ${eventType}`);
    }

    if (!ALLOWED_SOURCE_TYPES.includes(sourceType)) {
        throw new HttpsError("invalid-argument", `Invalid source type: ${sourceType}`);
    }

    if (!feedItemId || !sourceId || !sourceType) {
        throw new HttpsError("invalid-argument", "Missing required fields: feedItemId, sourceId, sourceType");
    }

    if (eventType === "impression") {
        if (impressionMode === "viewport") {
            const ratio = parseFloat(visibleRatio);
            const dwell = parseInt(dwellMs);
            if (isNaN(ratio) || ratio < 0.5) {
                throw new HttpsError("invalid-argument", "Viewport impression must have visibleRatio >= 0.5");
            }
            if (isNaN(dwell) || dwell < 800 || dwell > 60000) {
                throw new HttpsError("invalid-argument", "Viewport impression must have 800 <= dwellMs <= 60000");
            }
        }
    }

    const ALLOWED_BUCKETS = ["none", "short", "medium", "long"];
    const bucket = ALLOWED_BUCKETS.includes(intentLengthBucket) ? intentLengthBucket : "none";

    const abuseCheckData = classifyFeedInteractionAbuse(data);
    const abuseCheck = {
        ...abuseCheckData,
        checkedAt: admin.firestore.FieldValue.serverTimestamp()
    };

    return {
        userId: uid,
        sessionId: sessionId || "unknown",
        eventType,
        feedItemId,
        sourceId,
        sourceType,
        route: route || "unknown",
        position: clampInteractionPosition(position),
        isPromoted: !!isPromoted,
        hasSemanticIntent: !!hasSemanticIntent,
        intentLengthBucket: bucket,
        countryCode: countryCode || "ID",
        locationParts: locationParts || {},
        clientCreatedAt: clientCreatedAt || null,
        impressionMode: impressionMode || "approximate",
        visibleRatio: parseFloat(visibleRatio) || null,
        dwellMs: parseInt(dwellMs) || null,
        metadata: sanitizeFeedInteractionMetadata(metadata),
        abuseCheck: abuseCheck,
        createdAt: admin.firestore.FieldValue.serverTimestamp()
    };
}

// Boost Packages Policy
const BOOST_PACKAGES = {
    'job_boost_1_day': { amount: 15000, durationDays: 1, title: 'Boost 1 hari' },
    'job_boost_3_days': { amount: 40000, durationDays: 3, title: 'Boost 3 hari' },
    'job_boost_7_days': { amount: 90000, durationDays: 7, title: 'Boost 7 hari' }
};

/**
 * Smart Feed: Engagement Aggregation
 */
const ENGAGEMENT_WEIGHTS = {
    impression: 0.1,
    card_tap: 2.0,
    detail_open: 3.0,
    cta_tap: 5.0,
    semantic_intent_bonus: 0.5
};

function calculateEngagementScore(counts) {
    const rawScore =
        (counts.impression || 0) * ENGAGEMENT_WEIGHTS.impression +
        (counts.card_tap || 0) * ENGAGEMENT_WEIGHTS.card_tap +
        (counts.detail_open || 0) * ENGAGEMENT_WEIGHTS.detail_open +
        (counts.cta_tap || 0) * ENGAGEMENT_WEIGHTS.cta_tap +
        (counts.semantic_intent || 0) * ENGAGEMENT_WEIGHTS.semantic_intent_bonus;

    return Math.min(30.0, rawScore);
}

const INTERACTION_CAPS = {
    impression: 1,
    card_tap: 3,
    detail_open: 2,
    cta_tap: 2,
    semantic_intent: 3
};

function buildEngagementSummaryId(sourceType, sourceId) {
    return `${sourceType}_${sourceId}`;
}

function isValidEngagementInteraction(data) {
    return Boolean(data.sourceType && data.sourceId && data.eventType);
}

function groupFeedInteractions(interactions) {
    const groups = {};
    interactions.forEach(doc => {
        const data = doc.data();
        if (!isValidEngagementInteraction(data)) return;

        if (data.abuseCheck && (data.abuseCheck.severity === "medium" || data.abuseCheck.severity === "high")) {
            return; // Skip suspicious interactions from aggregation
        }

        const key = buildEngagementSummaryId(data.sourceType, data.sourceId);
        if (!groups[key]) {
            groups[key] = {
                sourceType: data.sourceType,
                sourceId: data.sourceId,
                feedItemId: data.feedItemId,
                counts: { impression: 0, card_tap: 0, detail_open: 0, cta_tap: 0, semantic_intent: 0 },
                sessions: new Set(),
                lastInteractionAt: data.createdAt,
                sessionCounts: {}
            };
        }

        const group = groups[key];
        const sessId = data.sessionId || "unknown";

        if (!group.sessionCounts[sessId]) {
            group.sessionCounts[sessId] = {
                impression: 0,
                card_tap: 0,
                detail_open: 0,
                cta_tap: 0,
                semantic_intent: 0
            };
        }

        const sessCounts = group.sessionCounts[sessId];
        const eventType = data.eventType;
        let capped = false;

        if (ENGAGEMENT_WEIGHTS[eventType]) {
            const cap = INTERACTION_CAPS[eventType] || 1;
            if (sessCounts[eventType] < cap) {
                sessCounts[eventType]++;
                group.counts[eventType]++;
            } else {
                capped = true;
            }
        }

        if (data.hasSemanticIntent) {
            const cap = INTERACTION_CAPS.semantic_intent || 3;
            if (sessCounts.semantic_intent < cap) {
                sessCounts.semantic_intent++;
                group.counts.semantic_intent++;
            }
        }

        if (sessId !== "unknown" && !capped) {
            group.sessions.add(sessId);
        }
        
        if (!capped && data.createdAt && (!group.lastInteractionAt || data.createdAt > group.lastInteractionAt)) {
            group.lastInteractionAt = data.createdAt;
        }
    });
    return groups;
}
/**
 * Monetization: Create Job Boost Payment Intent
 */
exports.createJobBoostPayment = onCall(async (request) => {
    const { jobId, packageId, provider = "xendit" } = request.data;
    const auth = request.auth;

    if (!auth) {
        throw new HttpsError("unauthenticated", "Authentication required");
    }

    const userId = auth.uid;

    // 1. Get Job Info
    const jobDoc = await admin.firestore().collection("job_posts").doc(jobId).get();
    if (!jobDoc.exists) {
        throw new HttpsError("not-found", "Job post not found");
    }

    const jobData = jobDoc.data();

    // 2. Security Validations
    if (jobData.ownerId !== userId) {
        throw new HttpsError("permission-denied", "Only the owner can boost this job");
    }

    if (jobData.status !== "open" || jobData.isDeleted) {
        throw new HttpsError("failed-precondition", "Job is not in an active state");
    }

    // 3. Package Validation
    const pkg = BOOST_PACKAGES[packageId];
    if (!pkg) {
        throw new HttpsError("invalid-argument", "Invalid boost package selected");
    }

    // 4. Duplicate Check (Active Boost)
    if (jobData.boostActiveUntil && jobData.boostActiveUntil.toDate() > new Date()) {
        throw new HttpsError("already-exists", "This job already has an active boost");
    }

    // 4.1. Check for existing Pending Payment (Reuse existing invoice if possible)
    const existingPayments = await admin.firestore().collection("payments")
        .where("relatedDomain", "==", "jobs")
        .where("relatedId", "==", jobId)
        .where("buyerId", "==", userId)
        .where("productType", "==", "jobBoost")
        .where("status", "in", ["created", "pending"])
        .get();

    // Filter by packageId manually to avoid complex indexing for now
    const existingPayment = existingPayments.docs.find(doc => doc.data().metadata?.packageId === packageId);
    if (existingPayment) {
        const data = existingPayment.data();
        if (data.providerInvoiceUrl) {
            console.log(`Reusing existing pending payment: ${data.id}`);
            return {
                paymentId: data.id,
                invoiceUrl: data.providerInvoiceUrl,
                providerInvoiceId: data.providerInvoiceId,
                status: data.status,
                reused: true
            };
        }
    }

    // 5. Create Payment Document
    const paymentId = admin.firestore().collection("payments").doc().id;
    const now = admin.firestore.FieldValue.serverTimestamp();

    const paymentData = {
        id: paymentId,
        provider: provider,
        providerMode: "sandbox", // TODO: Switch to production based on config
        productType: "jobBoost",
        relatedDomain: "jobs",
        relatedId: jobId,
        buyerId: userId,
        ownerId: userId,
        sellerId: null,
        amount: pkg.amount,
        currency: "IDR",
        status: "created",
        externalId: paymentId,
        metadata: {
            packageId: packageId,
            durationDays: pkg.durationDays,
            jobTitle: jobData.title
        },
        createdAt: now,
        updatedAt: now
    };

    // 6. Provider Invoice Creation
    const xenditSecretKey = process.env.XENDIT_SECRET_KEY;
    const isMockMode = process.env.PAYMENT_MOCK_MODE === "true";

    if (provider === "xendit") {
        if (!xenditSecretKey && !isMockMode) {
            console.error("XENDIT_SECRET_KEY is missing and PAYMENT_MOCK_MODE is not true");
            throw new HttpsError("failed-precondition", "Payment provider configuration missing");
        }

        if (isMockMode) {
            console.log("Creating MOCK Xendit Invoice");
            paymentData.providerInvoiceId = `mock_inv_${paymentId}`;
            paymentData.providerInvoiceUrl = `https://checkout-staging.xendit.co/v2/mock_inv_${paymentId}`;
            paymentData.rawProviderStatus = "PENDING_MOCK";
            paymentData.status = "pending";
        } else {
            try {
                const authHeader = Buffer.from(`${xenditSecretKey}:`).toString('base64');
                const response = await axios.post('https://api.xendit.co/v2/invoices', {
                    external_id: paymentId,
                    amount: pkg.amount,
                    currency: "IDR",
                    description: `Job Boost - ${jobData.title}`,
                    payer_email: auth.token.email || null,
                    success_redirect_url: `mozzy://payments/${paymentId}`,
                    failure_redirect_url: `mozzy://payments/${paymentId}`,
                    metadata: {
                        jobId,
                        packageId,
                        productType: "jobBoost",
                        durationDays: pkg.durationDays
                    }                }, {
                    headers: {
                        'Authorization': `Basic ${authHeader}`,
                        'Content-Type': 'application/json'
                    }
                });

                const invoice = response.data;
                paymentData.providerInvoiceId = invoice.id;
                paymentData.providerInvoiceUrl = invoice.invoice_url;
                paymentData.rawProviderStatus = invoice.status;
                paymentData.status = "pending";
                
                if (invoice.expiry_date) {
                    paymentData.expiresAt = admin.firestore.Timestamp.fromDate(new Date(invoice.expiry_date));
                }
            } catch (error) {
                console.error("Xendit API Error:", error.response?.data || error.message);
                throw new HttpsError("internal", "Failed to communicate with payment provider");
            }
        }
    } else {
        throw new HttpsError("unimplemented", "Selected provider is not yet supported");
    }

    // 7. Persist and Return
    await admin.firestore().collection("payments").doc(paymentId).set(paymentData);

    return {
        paymentId: paymentId,
        invoiceUrl: paymentData.providerInvoiceUrl,
        providerInvoiceId: paymentData.providerInvoiceId,
        status: "pending"
    };
});

/**
 * Monetization: Xendit Webhook Reconciliation
 */
exports.xenditWebhook = onRequest(async (req, res) => {
    if (req.method !== "POST") {
        return res.status(405).send("Method Not Allowed");
    }

    const payload = req.body;
    const callbackToken = req.headers["x-callback-token"];
    const expectedToken = process.env.XENDIT_WEBHOOK_VERIFICATION_TOKEN;
    const isMockMode = process.env.PAYMENT_MOCK_MODE === "true";

    // 1. Verification
    if (!isMockMode) {
        if (!expectedToken) {
            console.error("XENDIT_WEBHOOK_VERIFICATION_TOKEN is missing");
            return res.status(500).send("Server Configuration Error");
        }
        if (callbackToken !== expectedToken) {
            console.warn("Invalid Xendit callback token received");
            return res.status(401).send("Unauthorized");
        }
    }

    const { external_id: paymentId, status: xenditStatus, id: xenditInvoiceId } = payload;

    if (!paymentId) {
        console.warn("Xendit Webhook missing external_id");
        return res.status(400).send("Missing external_id");
    }

    try {
        const paymentRef = admin.firestore().collection("payments").doc(paymentId);
        
        await admin.firestore().runTransaction(async (transaction) => {
            const paymentDoc = await transaction.get(paymentRef);
            
            if (!paymentDoc.exists) {
                console.warn(`Payment document not found for external_id: ${paymentId}`);
                return; 
            }

            const paymentData = paymentDoc.data();
            
            // Check provider
            if (paymentData.provider !== "xendit") {
                console.warn(`Provider mismatch for payment ${paymentId}: expected xendit, got ${paymentData.provider}`);
                return;
            }

            // Status Precedence & Idempotency
            const currentStatus = paymentData.status;
            const newStatus = mapXenditInvoiceStatus(xenditStatus);

            if (shouldSkipUpdate(currentStatus, newStatus)) {
                console.log(`Skipping status update for ${paymentId}: ${currentStatus} -> ${newStatus}`);
                return;
            }

            // Amount Validation
            if (payload.amount && payload.amount !== paymentData.amount) {
                console.warn(`Amount mismatch for payment ${paymentId}: payload ${payload.amount}, doc ${paymentData.amount}`);
                if (newStatus === "paid") {
                    console.error(`Fraud suspected: amount mismatch on PAID status for ${paymentId}`);
                    return;
                }
            }

            const updateData = {
                status: newStatus,
                rawProviderStatus: xenditStatus,
                webhookLastReceivedAt: admin.firestore.FieldValue.serverTimestamp(),
                updatedAt: admin.firestore.FieldValue.serverTimestamp(),
                providerInvoiceId: xenditInvoiceId || paymentData.providerInvoiceId,
                providerInvoiceUrl: payload.invoice_url || paymentData.providerInvoiceUrl,
            };

            if (payload.paid_at) {
                updateData.paidAt = admin.firestore.Timestamp.fromDate(new Date(payload.paid_at));
            }
            if (payload.expiry_date) {
                updateData.expiresAt = admin.firestore.Timestamp.fromDate(new Date(payload.expiry_date));
            }

            transaction.update(paymentRef, updateData);
            
            // Audit Log: payment_status_changed
            const auditData = buildAuditLogData({
                type: "payment_status_changed",
                relatedDomain: "payments",
                relatedId: paymentId,
                paymentId,
                actorType: "webhook",
                actorId: "xendit",
                beforeStatus: currentStatus,
                afterStatus: newStatus,
                amount: paymentData.amount,
                currency: paymentData.currency,
                metadata: {
                    provider: "xendit",
                    rawProviderStatus: xenditStatus,
                    providerInvoiceId: xenditInvoiceId
                }
            });
            const auditId = buildAuditLogId("payment_status_changed", paymentId, paymentId);
            const auditRef = admin.firestore().collection("monetization_audit_logs").doc(auditId);
            transaction.set(auditRef, { ...auditData, id: auditId });

            console.log(`Updated payment ${paymentId} status to ${newStatus} (${xenditStatus})`);
        });

        return res.status(200).send("Webhook processed");
    } catch (error) {
        console.error("Error processing Xendit Webhook:", error);
        return res.status(500).send("Internal Server Error");
    }
});

/**
 * Xendit Status Mapping Helper
 */
function mapXenditInvoiceStatus(status) {
    switch (status) {
        case "PAID":
        case "SETTLED":
            return "paid";
        case "EXPIRED":
            return "expired";
        case "FAILED":
            return "failed";
        case "PENDING":
        case "ACTIVE":
            return "pending";
        default:
            return "pending";
    }
}

/**
 * Status Transition Logic
 * Prevents downgrading from final statuses
 */
function shouldSkipUpdate(current, next) {
    if (current === next) return true;
    
    const statusRank = {
        'created': 0,
        'pending': 1,
        'paid': 2,
        'failed': 2,
        'expired': 2,
        'cancelled': 2,
        'refunded': 3
    };

    const currentRank = statusRank[current] || 0;
    const nextRank = statusRank[next] || 0;

    // Allow expired -> paid (rare but possible in some PG flows)
    if (current === "expired" && next === "paid") return false;

    // Prevent downgrade
    if (nextRank < currentRank) return true;

    // If same rank and current is already a final status, skip
    const isCurrentFinal = currentRank >= 2;
    if (nextRank === currentRank && isCurrentFinal) return true;

    return false;
}

function resolveBoostDurationDays(packageId, metadataDurationDays) {
    if (metadataDurationDays && typeof metadataDurationDays === 'number' && metadataDurationDays > 0) {
        return metadataDurationDays;
    }
    if (packageId === 'job_boost_1_day') return 1;
    if (packageId === 'job_boost_3_days') return 3;
    if (packageId === 'job_boost_7_days') return 7;
    return 1; // Default fallback
}

function calculateBoostActiveUntil(startTimestampOrDate, durationDays) {
    const start = (startTimestampOrDate && typeof startTimestampOrDate.toDate === 'function')
        ? startTimestampOrDate.toDate()
        : (startTimestampOrDate instanceof Date ? startTimestampOrDate : new Date());
    
    const until = new Date(start);
    until.setDate(until.getDate() + durationDays);
    return admin.firestore.Timestamp.fromDate(until);
}

function shouldActivateJobBoost(beforeData, afterData) {
    if (!beforeData || !afterData) return false;
    
    // Status Transition: non-paid to paid
    const isPaidNow = afterData.status === "paid";
    const wasAlreadyPaid = beforeData.status === "paid";
    if (wasAlreadyPaid || !isPaidNow) return false;

    // Product check
    if (afterData.productType !== "jobBoost" || afterData.relatedDomain !== "jobs") return false;

    // Idempotency check
    if (afterData.metadata && afterData.metadata.boostActivated) return false;

    return true;
}

function buildJobBoostUpdate(paymentId, paymentData, paidAtOrNow) {
    const packageId = paymentData.metadata?.packageId;
    const durationDays = resolveBoostDurationDays(packageId, paymentData.metadata?.durationDays);
    const boostStartedAt = paidAtOrNow || paymentData.paidAt || admin.firestore.Timestamp.now();
    const boostActiveUntil = calculateBoostActiveUntil(boostStartedAt, durationDays);

    return {
        boostStatus: "active",
        boostPaymentId: paymentId,
        boostPackageId: packageId || "manual",
        boostStartedAt: boostStartedAt,
        boostActiveUntil: boostActiveUntil,
        boostDurationDays: durationDays,
        boostSignalScore: 100.0,
        lastBoostedAt: boostStartedAt,
        updatedAt: admin.firestore.Timestamp.now()
    };
}

function isBoostExpiredForScheduler(jobData, nowTimestamp) {
    if (jobData.boostStatus !== "active") return false;
    if (!jobData.boostActiveUntil) return false;
    
    const activeUntil = jobData.boostActiveUntil.toDate();
    const now = nowTimestamp.toDate();
    
    return activeUntil <= now;
}

function buildBoostExpiredUpdate() {
    return {
        boostStatus: "expired",
        boostSignalScore: 0.0,
        updatedAt: admin.firestore.Timestamp.now()
    };
}

function buildAuditLogData({
    type,
    relatedDomain,
    relatedId,
    paymentId = null,
    jobId = null,
    actorType,
    actorId = null,
    beforeStatus = null,
    afterStatus = null,
    amount = null,
    currency = null,
    metadata = {}
}) {
    return {
        type,
        relatedDomain,
        relatedId,
        paymentId,
        jobId,
        actorType,
        actorId,
        beforeStatus,
        afterStatus,
        amount,
        currency,
        metadata,
        createdAt: admin.firestore.Timestamp.now()
    };
}

function buildAuditLogId(type, relatedId, paymentId = null) {
    if (type === "job_boost_activated" && paymentId) {
        return `job_boost_activated_${paymentId}`;
    }
    if (type === "job_boost_expired" && relatedId) {
        return `job_boost_expired_${relatedId}_${Date.now()}`;
    }
    if (type === "payment_status_changed" && paymentId) {
        // We use a timestamp for status changes as one payment can change status multiple times
        return `payment_status_changed_${paymentId}_${Date.now()}`;
    }
    return `audit_${relatedId}_${Date.now()}`;
}

// Export helpers for testing
exports._testHelpers = {
    mapXenditInvoiceStatus,
    shouldSkipUpdate,
    resolveBoostDurationDays,
    calculateBoostActiveUntil,
    shouldActivateJobBoost,
    buildJobBoostUpdate,
    isBoostExpiredForScheduler,
    buildBoostExpiredUpdate,
    buildAuditLogData,
    buildAuditLogId,
    mockGeminiRanking,
    buildGeminiRankingPrompt,
    clampSemanticScore,
    normalizeSemanticIntent,
    sanitizeSemanticRankingItems,
    parseGeminiRankingResponse,
    getGeminiModel: () => process.env.GEMINI_MODEL || "gemini-3-flash-preview",
    ALLOWED_FEED_INTERACTION_TYPES,
    FORBIDDEN_FEED_INTERACTION_FIELDS,
    sanitizeFeedInteractionMetadata,
    clampInteractionPosition,
    isAllowedFeedInteractionType,
    sanitizeFeedInteractionPayload,
    calculateEngagementScore,
    buildEngagementSummaryId,
    isValidEngagementInteraction,
    groupFeedInteractions,
    shouldTriggerAiVerification,
    runMarketplaceAiVerification,
    runMockGeminiVerification
};

/**
 * Monetization: Activate Job Boost on Payment Success
 */
exports.onPaymentPaidActivateJobBoost = onDocumentUpdated("payments/{paymentId}", async (event) => {
    const beforeData = event.data.before.data();
    const afterData = event.data.after.data();

    // 1. Check if activation is needed
    if (!shouldActivateJobBoost(beforeData, afterData)) {
        return;
    }

    const paymentId = event.params.paymentId;
    const jobId = afterData.relatedId;
    const userId = afterData.buyerId;

    if (!jobId) {
        console.error(`Missing relatedId for jobBoost payment ${paymentId}`);
        return;
    }

    try {
        const jobRef = admin.firestore().collection("job_posts").doc(jobId);
        const paymentRef = admin.firestore().collection("payments").doc(paymentId);

        await admin.firestore().runTransaction(async (transaction) => {
            const jobDoc = await transaction.get(jobRef);
            if (!jobDoc.exists) {
                console.warn(`Job post ${jobId} not found for boost activation`);
                return;
            }

            const jobData = jobDoc.data();

            // 2. Verification
            if (jobData.ownerId !== userId) {
                console.error(`User mismatch for boost activation: payment buyer ${userId}, job owner ${jobData.ownerId}`);
                return;
            }

            if (jobData.status !== "open" || jobData.isDeleted) {
                console.warn(`Job ${jobId} is not in a boostable state`);
                return;
            }

            // 3. Update Job Post
            const jobUpdate = buildJobBoostUpdate(paymentId, afterData);
            transaction.update(jobRef, jobUpdate);

            // 4. Mark Payment as Activated
            transaction.update(paymentRef, {
                'metadata.boostActivated': true,
                'metadata.boostActivatedAt': admin.firestore.FieldValue.serverTimestamp(),
                updatedAt: admin.firestore.FieldValue.serverTimestamp()
            });

            // 5. Audit Log: job_boost_activated
            const auditData = buildAuditLogData({
                type: "job_boost_activated",
                relatedDomain: "jobs",
                relatedId: jobId,
                paymentId,
                jobId,
                actorType: "system",
                actorId: "onPaymentPaidActivateJobBoost",
                beforeStatus: jobData.boostStatus || "none",
                afterStatus: "active",
                amount: afterData.amount,
                currency: afterData.currency,
                metadata: {
                    packageId: afterData.metadata?.packageId,
                    durationDays: jobUpdate.boostDurationDays,
                    boostActiveUntil: jobUpdate.boostActiveUntil
                }
            });
            const auditId = buildAuditLogId("job_boost_activated", jobId, paymentId);
            const auditRef = admin.firestore().collection("monetization_audit_logs").doc(auditId);
            transaction.set(auditRef, { ...auditData, id: auditId });

            console.log(`Successfully activated job boost for job ${jobId}`);
        });
    } catch (error) {
        console.error(`Error activating job boost for ${paymentId}:`, error);
    }
});

/**
 * Monetization: Job Boost Expiry Scheduler
 * Runs every hour to check for expired boosts
 */
exports.expireJobBoosts = onSchedule("every 1 hours", async (event) => {
    const now = admin.firestore.Timestamp.now();

    const expiredJobsQuery = await admin.firestore().collection("job_posts")
        .where("boostStatus", "==", "active")
        .where("boostActiveUntil", "<=", now)
        .limit(250)
        .get();

    if (expiredJobsQuery.empty) {
        console.log("No expired job boosts found");
        return;
    }

    console.log(`Found ${expiredJobsQuery.size} expired job boosts`);

    const batch = admin.firestore().batch();
    const auditLogs = [];

    expiredJobsQuery.docs.forEach(doc => {
        const jobData = doc.data();
        const jobId = doc.id;

        batch.update(doc.ref, buildBoostExpiredUpdate());

        // Prepare audit log
        const auditData = buildAuditLogData({
            type: "job_boost_expired",
            relatedDomain: "jobs",
            relatedId: jobId,
            jobId: jobId,
            paymentId: jobData.boostPaymentId || null,
            actorType: "scheduler",
            actorId: "expireJobBoosts",
            beforeStatus: "active",
            afterStatus: "expired",
            metadata: {
                boostActiveUntil: jobData.boostActiveUntil,
                boostPaymentId: jobData.boostPaymentId
            }
        });
        const auditId = buildAuditLogId("job_boost_expired", jobId);
        const auditRef = admin.firestore().collection("monetization_audit_logs").doc(auditId);
        
        batch.set(auditRef, { ...auditData, id: auditId });
    });

    try {
        await batch.commit();
        console.log(`Successfully expired ${expiredJobsQuery.size} job boosts`);
    } catch (error) {
        console.error("Error committing boost expiry batch:", error);
    }
});

/**
 * Smart Feed: Rank Feed Items with Gemini AI
 */
exports.rankSmartFeedWithGemini = onCall({ secrets: [geminiApiKey] }, async (request) => {
    const { intent, languageCode = "id", items } = request.data;
    const auth = request.auth;

    if (!auth) {
        throw new HttpsError("unauthenticated", "Authentication required");
    }

    if (!intent || typeof intent !== "string") {
        throw new HttpsError("invalid-argument", "Intent is required");
    }

    if (!items || !Array.isArray(items)) {
        throw new HttpsError("invalid-argument", "Items must be an array");
    }

    // 1. Validation & Truncation
    const normalizedIntent = normalizeSemanticIntent(intent);
    const sanitizedItems = sanitizeSemanticRankingItems(items);

    const isMockMode = process.env.AI_MOCK_MODE === "true";
    const apiKey = geminiApiKey.value();

    if (isMockMode) {
        console.log("Using Mock Mode for Gemini Semantic Ranking");
        const results = mockGeminiRanking(normalizedIntent, sanitizedItems);
        return { results, provider: "gemini", mode: "mock" };
    }

    if (!apiKey && !isMockMode) {
        console.error("GEMINI_API_KEY is missing and AI_MOCK_MODE is not true");
        throw new HttpsError("failed-precondition", "AI service configuration missing");
    }

    // 2. Call Gemini API
    try {
        const results = await callGeminiForRanking(normalizedIntent, sanitizedItems, languageCode, apiKey);
        return { results, provider: "gemini", mode: "live" };
    } catch (error) {
        console.error("Gemini API Error:", error.message);
        throw new HttpsError("internal", `Failed to process semantic ranking: ${error.message}`);
    }
});

/**
 * Helper: Normalize Intent
 */
function normalizeSemanticIntent(intent) {
    if (!intent || typeof intent !== "string") return "";
    return intent.trim().substring(0, 100);
}

/**
 * Helper: Sanitize Items
 */
function sanitizeSemanticRankingItems(items) {
    if (!items || !Array.isArray(items)) return [];
    return items.slice(0, 30).map(item => {
        // Enforce allowlist: only keep safe fields
        return {
            feedItemId: item.feedItemId,
            sourceId: item.sourceId,
            type: item.type,
            title: item.title,
            publicSummary: item.publicSummary,
            category: item.category,
            locationHint: item.locationHint,
            isPromoted: item.isPromoted,
            isTrusted: item.isTrusted,
            ageBucket: item.ageBucket,
            languageCode: item.languageCode
        };
    });
}

/**
 * Helper: Clamp Score
 */
function clampSemanticScore(score) {
    const s = parseFloat(score);
    if (isNaN(s)) return 0;
    return Math.max(0, Math.min(s, 30.0));
}

/**
 * Mock helper for Gemini Semantic Ranking
 */
function mockGeminiRanking(intent, items) {
    const intentLower = intent.toLowerCase();
    return items.map(item => {
        let score = 0;
        let reason = "Neutral match";

        const titleMatch = item.title?.toLowerCase().includes(intentLower);
        const summaryMatch = item.publicSummary?.toLowerCase().includes(intentLower);

        if (titleMatch || summaryMatch) {
            score += 15.0;
            reason = "Keyword match in title/summary";
        }

        // Domain boost
        if ((intentLower.includes("job") || intentLower.includes("kerja") || intentLower.includes("loker") || intentLower.includes("lowongan")) && item.type === "job") {
            score += 10.0;
            reason += " + Job domain relevance";
        } else if ((intentLower.includes("jual") || intentLower.includes("beli") || intentLower.includes("barang") || intentLower.includes("bekas")) && item.type === "marketplaceProduct") {
            score += 10.0;
            reason += " + Marketplace domain relevance";
        }

        return {
            feedItemId: item.feedItemId,
            score: clampSemanticScore(score),
            reason: reason.trim()
        };
    });
}

/**
 * Gemini API Caller
 */
async function callGeminiForRanking(intent, items, languageCode, apiKey) {
    const prompt = buildGeminiRankingPrompt(intent, items, languageCode);
    const modelName = process.env.GEMINI_MODEL || "gemini-3-flash-preview";
    
    const response = await axios.post(
        `https://generativelanguage.googleapis.com/v1beta/models/${modelName}:generateContent?key=${apiKey}`,
        {
            contents: [{ parts: [{ text: prompt }] }],
            generationConfig: {
                responseMimeType: "application/json",
            }
        },
        {
            headers: { 'Content-Type': 'application/json' },
            timeout: 8000 // 8 second timeout
        }
    );

    const content = response.data?.candidates?.[0]?.content?.parts?.[0]?.text;
    if (!content) {
        throw new Error("Empty response from Gemini");
    }

    return parseGeminiRankingResponse(content, items);
}

/**
 * Helper: Parse Gemini Response
 */
function parseGeminiRankingResponse(content, items) {
    try {
        const parsed = JSON.parse(content);
        const results = parsed.results || [];
        
        return items.map(inputItem => {
            const result = results.find(r => r.feedItemId === inputItem.feedItemId);
            return {
                feedItemId: inputItem.feedItemId,
                score: clampSemanticScore(result?.score || 0),
                reason: result?.reason || "No specific reason provided"
            };
        });
    } catch (e) {
        console.error("Failed to parse Gemini response:", content);
        throw new Error("Invalid response format from Gemini");
    }
}

/**
 * Helper: Build Prompt
 */
function buildGeminiRankingPrompt(intent, items, languageCode) {
    return `You are a ranking assistant for a hyperlocal super-app called Mozzy.
Your task is to rank the provided feed items based on their relevance to the user's search intent.

User Intent: "${intent}"
Language: ${languageCode}

Ranking Rules:
1. Assign a score between 0 and 30 for each item.
2. 30 means extremely relevant, 0 means not relevant at all.
3. Be objective. Use the provided fields (title, summary, category, location) only.
4. Do not mention user personal data.
5. Return the results in a structured JSON format.

Items to rank:
${JSON.stringify(items, null, 2)}

Expected JSON Output Format:
{
  "results": [
    {
      "feedItemId": "item_id_here",
      "score": 25.5,
      "reason": "Brief reason for this score"
    }
  ]
}

Only return the JSON object.`;
}

exports.logFeedInteraction = onCall(async (request) => {
    const { data, auth } = request;

    if (!auth) {
        throw new HttpsError("unauthenticated", "Authentication required");
    }

    const interactionData = sanitizeFeedInteractionPayload(data, auth.uid);

    try {
        await admin.firestore().collection("feed_interactions").add(interactionData);
        return { ok: true };
    } catch (error) {
        console.error("Error logging feed interaction:", error);
        throw new HttpsError("internal", "Failed to log interaction");
    }
});

exports.aggregateFeedEngagement = onSchedule("every 1 hours", async (event) => {
    const firestore = admin.firestore();
    const now = new Date();
    const sevenDaysAgo = new Date(now.getTime() - (7 * 24 * 60 * 60 * 1000));

    try {
        const snapshot = await firestore.collection("feed_interactions")
            .where("createdAt", ">=", admin.firestore.Timestamp.fromDate(sevenDaysAgo))
            .get();

        if (snapshot.empty) {
            console.log("No interactions to aggregate in the last 7 days");
            return;
        }

        const groups = groupFeedInteractions(snapshot.docs);
        const batch = firestore.batch();

        Object.keys(groups).forEach(summaryId => {
            const group = groups[summaryId];
            const score = calculateEngagementScore(group.counts);
            
            const summaryData = {
                id: summaryId,
                sourceType: group.sourceType,
                sourceId: group.sourceId,
                feedItemId: group.feedItemId,
                impressionCount: group.counts.impression,
                cardTapCount: group.counts.card_tap,
                detailOpenCount: group.counts.detail_open,
                ctaTapCount: group.counts.cta_tap,
                semanticIntentCount: group.counts.semantic_intent,
                totalInteractions: Object.values(group.counts).reduce((a, b) => a + b, 0),
                uniqueSessionCount: group.sessions.size,
                engagementScore: score,
                lastInteractionAt: group.lastInteractionAt,
                lastAggregatedAt: admin.firestore.FieldValue.serverTimestamp(),
                window: "all_time" // Placeholder for MVP
            };

            const summaryRef = firestore.collection("feed_engagement_summaries").doc(summaryId);
            batch.set(summaryRef, summaryData, { merge: true });
        });

        await batch.commit();
        console.log(`Successfully aggregated ${Object.keys(groups).length} engagement summaries`);
    } catch (error) {
        console.error("Error in aggregateFeedEngagement:", error);
    }
});

// -----------------------------------------------------------------------------
// P6-S03 Moderation: onReportCreated
// -----------------------------------------------------------------------------
exports.onReportCreated = onDocumentCreated("reports/{reportId}", async (event) => {
    const snapshot = event.data;
    if (!snapshot) return;

    const report = snapshot.data();
    const targetType = report.targetType;
    const targetId = report.targetId;
    const status = report.status;

    if (status !== 'pending') return;
    if (!targetType || !targetId) return;

    let targetRef;
    const db = admin.firestore();
    
    // Simplification for Beta 1: assume countryCode is ID
    switch (targetType) {
        case 'news':
            targetRef = db.doc('countries/ID/domains/local_news/posts/' + targetId);
            break;
        case 'marketplace':
            targetRef = db.doc('countries/ID/domains/marketplace/products/' + targetId);
            break;
        case 'jobs':
            targetRef = db.doc('job_posts/' + targetId);
            break;
        default:
            console.log('Unsupported targetType: ' + targetType);
            return;
    }

    try {
        await db.runTransaction(async (transaction) => {
            const targetDoc = await transaction.get(targetRef);
            if (!targetDoc.exists) {
                console.log('Target document not found: ' + targetRef.path);
                return;
            }

            const data = targetDoc.data();
            const currentReportCount = data.reportCount || 0;
            const newReportCount = currentReportCount + 1;
            
            const updates = {
                reportCount: newReportCount,
                lastReportedAt: admin.firestore.FieldValue.serverTimestamp()
            };

            const mStatus = data.moderationStatus || 'visible';
            if (newReportCount >= 3 && mStatus === 'visible') {
                updates.moderationStatus = 'underReview';
            }

            transaction.update(targetRef, updates);
        });
        console.log('Successfully processed report ' + event.params.reportId);
    } catch (e) {
        console.error('Failed to process report ' + event.params.reportId + ':', e);
    }
});

// -----------------------------------------------------------------------------
// P6-S06 Account Deletion: requestAccountDeletion
// -----------------------------------------------------------------------------
exports.requestAccountDeletion = onCall(async (request) => {
    const { data, auth } = request;
    if (!auth) {
        throw new HttpsError("unauthenticated", "Authentication required");
    }

    const uid = auth.uid;
    const reason = data.reason ? data.reason.substring(0, 500) : null;
    const appVersion = data.appVersion || "unknown";
    const platform = data.platform || "unknown";
    const countryCode = data.countryCode || "ID";

    const db = admin.firestore();
    const requestRef = db.collection("account_deletion_requests").doc(uid);

    try {
        await requestRef.set({
            userId: uid,
            status: "requested",
            reason: reason,
            appVersion: appVersion,
            platform: platform,
            countryCode: countryCode,
            requestedAt: admin.firestore.FieldValue.serverTimestamp(),
            processedAt: null,
            errorMessage: null
        });
        return { success: true };
    } catch (e) {
        console.error("Failed to create deletion request:", e);
        throw new HttpsError("internal", "Failed to create deletion request");
    }
});

// -----------------------------------------------------------------------------
// P6-S06 Account Deletion: onAccountDeletionRequested
// -----------------------------------------------------------------------------
exports.onAccountDeletionRequested = onDocumentCreated("account_deletion_requests/{uid}", async (event) => {
    const snapshot = event.data;
    if (!snapshot) return;

    const uid = event.params.uid;
    const db = admin.firestore();
    const requestRef = db.collection("account_deletion_requests").doc(uid);

    try {
        await requestRef.update({ status: "processing" });

        const batch = db.batch();

        // 1. users/{uid} anonymization
        const userRef = db.collection("users").doc(uid);
        batch.update(userRef, {
            isDeleted: true,
            deletedAt: admin.firestore.FieldValue.serverTimestamp(),
            displayName: "Deleted User",
            nickname: "Deleted User",
            photoUrl: null,
            phoneNumber: null,
            email: null,
            fcmTokens: []
        });

        // 2. UGC Anonymization (Job Posts)
        const jobsSnapshot = await db.collection("job_posts").where("ownerId", "==", uid).get();
        jobsSnapshot.docs.forEach(doc => {
            batch.update(doc.ref, {
                isDeleted: true,
                moderationStatus: "removed",
                deletedAt: admin.firestore.FieldValue.serverTimestamp(),
                deletedReason: "account_deleted",
                ownerDisplayName: "Deleted User",
                ownerPhotoUrl: null
            });
        });

        // 3. UGC Anonymization (Marketplace Products)
        const productsSnapshot = await db.collectionGroup("products").where("sellerId", "==", uid).get();
        productsSnapshot.docs.forEach(doc => {
            batch.update(doc.ref, {
                isDeleted: true,
                moderationStatus: "removed",
                deletedAt: admin.firestore.FieldValue.serverTimestamp(),
                deletedReason: "account_deleted"
            });
        });

        // 4. UGC Anonymization (Local News Posts)
        const postsSnapshot = await db.collectionGroup("posts").where("userId", "==", uid).get();
        postsSnapshot.docs.forEach(doc => {
            batch.update(doc.ref, {
                isDeleted: true,
                moderationStatus: "removed",
                deletedAt: admin.firestore.FieldValue.serverTimestamp(),
                deletedReason: "account_deleted"
            });
        });

        // 5. Feedback cleanup
        const feedbackSnapshot = await db.collection("feedback").where("userId", "==", uid).get();
        feedbackSnapshot.docs.forEach(doc => {
            batch.update(doc.ref, {
                contactValue: null,
                status: "dismissed",
                adminNote: "User account deleted",
                updatedAt: admin.firestore.FieldValue.serverTimestamp()
            });
        });

        // 6. Reports cleanup
        const reportsSnapshot = await db.collection("reports").where("reporterId", "==", uid).get();
        reportsSnapshot.docs.forEach(doc => {
            batch.update(doc.ref, {
                reporterDeleted: true
            });
        });

        await batch.commit();

        // 7. Delete Firebase Auth User
        try {
            await admin.auth().deleteUser(uid);
            console.log(`Successfully deleted Auth user ${uid}`);
        } catch (authError) {
            console.error(`Failed to delete Auth user ${uid}:`, authError);
            // Even if auth delete fails (e.g. user already deleted), we mark as completed
        }

        await requestRef.update({
            status: "completed",
            processedAt: admin.firestore.FieldValue.serverTimestamp()
        });

    } catch (e) {
        console.error(`Failed to process account deletion for ${uid}:`, e);
        await requestRef.update({
            status: "failed",
            errorMessage: e.message,
            processedAt: admin.firestore.FieldValue.serverTimestamp()
        });
    }
});

/**
 * Monetization: Generic Create Xendit Invoice
 */
exports.createXenditInvoice = onCall(async (request) => {
    const { purpose, userId, amountIdr, description, sourceType, sourceId, method, metadata = {} } = request.data;
    const auth = request.auth;

    if (!auth) {
        throw new HttpsError("unauthenticated", "Authentication required");
    }

    if (auth.uid !== userId) {
        throw new HttpsError("permission-denied", "User ID mismatch");
    }

    if (!Number.isInteger(amountIdr) || amountIdr <= 0 || amountIdr > 20000000) {
        throw new HttpsError("invalid-argument", "Invalid payment amount");
    }

    const ALLOWED_PURPOSES = ["aiVerification", "boostPost", "boostProduct", "boostJob", "subscriptionMozzyPlus", "businessPlus"];
    if (!ALLOWED_PURPOSES.includes(purpose)) {
        throw new HttpsError("invalid-argument", "Invalid payment purpose");
    }

    // 1. Create Payment Document
    const paymentId = admin.firestore().collection("payments").doc().id;
    const now = admin.firestore.FieldValue.serverTimestamp();
    const externalId = paymentId;

    const paymentData = {
        id: paymentId,
        paymentId: paymentId,
        externalId: externalId,
        provider: "xendit",
        providerMode: process.env.PAYMENT_MOCK_MODE === "true" ? "mock" : "sandbox",
        purpose,
        userId,
        buyerId: userId,
        ownerId: userId,
        sellerId: null,
        amount: amountIdr,
        amountIdr,
        currency: "IDR",
        status: "created",
        sourceType: sourceType || null,
        sourceId: sourceId || null,
        method: method || "invoice",
        metadata: sanitizeMetadata(metadata),
        createdAt: now,
        updatedAt: now
    };

    // 2. Provider Invoice Creation
    const xenditSecretKey = process.env.XENDIT_SECRET_KEY;
    const isMockMode = process.env.PAYMENT_MOCK_MODE === "true";

    if (!xenditSecretKey && !isMockMode) {
        throw new HttpsError("failed-precondition", "Payment provider configuration missing");
    }

    if (isMockMode) {
        paymentData.providerInvoiceId = `mock_inv_${paymentId}`;
        paymentData.providerInvoiceUrl = `https://checkout-staging.xendit.co/v2/mock_inv_${paymentId}`;
        paymentData.status = "pending";
    } else {
        try {
            const authHeader = Buffer.from(`${xenditSecretKey}:`).toString('base64');
            const response = await axios.post('https://api.xendit.co/v2/invoices', {
                external_id: externalId,
                amount: amountIdr,
                currency: "IDR",
                description: description || `Mozzy Payment - ${purpose}`,
                success_redirect_url: `mozzy://payments/${paymentId}`,
                failure_redirect_url: `mozzy://payments/${paymentId}`,
                metadata: {
                    paymentId,
                    purpose,
                    sourceType,
                    sourceId
                }
            }, {
                headers: {
                    'Authorization': `Basic ${authHeader}`,
                    'Content-Type': 'application/json'
                }
            });

            const invoice = response.data;
            paymentData.providerInvoiceId = invoice.id;
            paymentData.providerInvoiceUrl = invoice.invoice_url;
            paymentData.status = "pending";
            if (invoice.expiry_date) {
                paymentData.expiresAt = admin.firestore.Timestamp.fromDate(new Date(invoice.expiry_date));
            }
        } catch (error) {
            console.error("Xendit Invoice API Error:", error.response?.data || error.message);
            throw new HttpsError("internal", "Failed to create invoice with provider");
        }
    }

    await admin.firestore().collection("payments").doc(paymentId).set(paymentData);

    return {
        paymentId,
        externalId,
        status: paymentData.status,
        amountIdr,
        invoiceUrl: paymentData.providerInvoiceUrl,
        qrString: null,
        expiresAt: paymentData.expiresAt ? paymentData.expiresAt.toDate().toISOString() : null,
        raw: isMockMode ? { mock: true } : {}
    };
});

/**
 * Monetization: Generic Create Xendit QRIS
 */
exports.createXenditQris = onCall(async (request) => {
    // QRIS implementation often requires specific account activation.
    // For Beta 1 foundation, we provide a placeholder or minimal implementation.
    throw new HttpsError("unavailable", "QRIS payment is currently pending account permission");
});

/**
 * Monetization: Get Xendit Payment Status
 */
exports.getXenditPaymentStatus = onCall(async (request) => {
    const { paymentId } = request.data;
    const auth = request.auth;

    if (!auth) {
        throw new HttpsError("unauthenticated", "Authentication required");
    }

    const paymentRef = admin.firestore().collection("payments").doc(paymentId);
    const paymentDoc = await paymentRef.get();

    if (!paymentDoc.exists) {
        throw new HttpsError("not-found", "Payment record not found");
    }

    const paymentData = paymentDoc.data();

    if (paymentData.userId !== auth.uid) {
        throw new HttpsError("permission-denied", "Unauthorized access to payment record");
    }

    // Optionally fetch live status from Xendit if not in a final state
    // For foundation, we return the cached Firestore status
    return {
        paymentId,
        externalId: paymentData.externalId,
        status: paymentData.status,
        amountIdr: paymentData.amountIdr || paymentData.amount,
        invoiceUrl: paymentData.providerInvoiceUrl,
        qrString: paymentData.qrString || null,
        expiresAt: paymentData.expiresAt ? (paymentData.expiresAt.toDate ? paymentData.expiresAt.toDate().toISOString() : paymentData.expiresAt) : null,
        raw: paymentData.rawProviderStatus ? { providerStatus: paymentData.rawProviderStatus } : {}
    };
});

/**
 * Helper: Sanitize Metadata
 */
function sanitizeMetadata(metadata) {
    const cleaned = {};
    if (metadata && typeof metadata === 'object') {
        const FORBIDDEN = ["email", "phone", "phoneNumber", "nik", "ktp", "address"];
        Object.keys(metadata).forEach(key => {
            if (!FORBIDDEN.includes(key)) {
                cleaned[key] = metadata[key];
            }
        });
    }
    return cleaned;
}

/**
 * Monetization: Automate AI Verification on Paid Payment
 */
exports.onPaymentPaidStartAiVerification = onDocumentUpdated({ secrets: [geminiApiKey] }, async (event) => {
    const beforeData = event.data.before.data();
    const afterData = event.data.after.data();

    // 1. Verify transitions and criteria
    if (!shouldTriggerAiVerification(beforeData, afterData)) {
        return;
    }

    const paymentId = event.params.paymentId;
    const productId = afterData.sourceId || afterData.relatedId || (afterData.metadata && afterData.metadata.productId);
    const userId = afterData.userId || afterData.buyerId;

    if (!productId) {
        console.error(`Missing productId for aiVerification payment ${paymentId}`);
        return;
    }

    try {
        await runMarketplaceAiVerification({
            productId,
            paymentId,
            userId,
            paymentData: afterData
        });
    } catch (error) {
        console.error(`Error executing AI verification for payment ${paymentId}:`, error);
    }
});

/**
 * Helper: check if payment paid status transitions can trigger AI verification
 */
function shouldTriggerAiVerification(beforeData, afterData) {
    if (!beforeData || !afterData) return false;
    
    // Status transition: must transition to paid
    if (beforeData.status === "paid" || afterData.status !== "paid") {
        return false;
    }
    
    // Provider check
    if (afterData.provider !== "xendit") {
        return false;
    }
    
    // Purpose check
    if (afterData.purpose !== "aiVerification") {
        return false;
    }

    // Source type check
    if (afterData.sourceType !== "product") {
        return false;
    }

    // Idempotency: skip if already triggered
    if (afterData.aiVerificationTriggeredAt || (afterData.metadata && afterData.metadata.aiVerificationTriggeredAt)) {
        console.log(`AI Verification already triggered for payment`);
        return false;
    }

    if (afterData.fulfillmentStatus === "processing" || afterData.fulfillmentStatus === "completed") {
        console.log(`Fulfillment already in status: ${afterData.fulfillmentStatus}`);
        return false;
    }

    return true;
}

/**
 * Helper: run Marketplace AI Verification and persist outcomes
 */
async function runMarketplaceAiVerification({ productId, paymentId, userId, paymentData }) {
    const db = admin.firestore();
    const paymentRef = db.collection("payments").doc(paymentId);

    // 1. Find Product Document
    let productRef = null;
    const countryCode = (paymentData.metadata && paymentData.metadata.countryCode) || "ID";
    
    // Direct path lookup
    productRef = db.collection("countries").doc(countryCode)
        .collection("domains").doc("marketplace")
        .collection("products").doc(productId);
        
    let productDoc = await productRef.get();
    
    if (!productDoc.exists) {
        // Fallback: search via Collection Group
        console.log(`Product ${productId} not found at direct path. Searching via collectionGroup...`);
        const querySnapshot = await db.collectionGroup("products").where("id", "==", productId).limit(1).get();
        if (!querySnapshot.empty) {
            productDoc = querySnapshot.docs[0];
            productRef = productDoc.ref;
        } else {
            console.error(`Product ${productId} not found anywhere`);
            await paymentRef.update({
                fulfillmentStatus: "failed",
                fulfillmentError: "product_not_found",
                updatedAt: admin.firestore.FieldValue.serverTimestamp()
            });
            return;
        }
    }

    const productData = productDoc.data();

    // 2. Validate Ownership
    const sellerId = productData.sellerId || productData.userId;
    if (sellerId !== userId) {
        console.error(`Ownership mismatch: product owner ${sellerId}, payment buyer ${userId}`);
        await paymentRef.update({
            fulfillmentStatus: "failed",
            fulfillmentError: "ownership_mismatch",
            updatedAt: admin.firestore.FieldValue.serverTimestamp()
        });
        return;
    }

    // 3. Validate Images
    const imageUrls = productData.imageUrls || [];
    if (!imageUrls || imageUrls.length === 0) {
        console.error(`Product ${productId} has no images`);
        
        await db.runTransaction(async (transaction) => {
            transaction.update(productRef, {
                aiVerificationStatus: "failed",
                aiVerificationError: "missing_images",
                updatedAt: admin.firestore.FieldValue.serverTimestamp()
            });
            transaction.update(paymentRef, {
                fulfillmentStatus: "failed",
                fulfillmentError: "missing_images",
                updatedAt: admin.firestore.FieldValue.serverTimestamp()
            });
        });
        return;
    }

    // 4. Idempotency on Product Status
    if (productData.aiVerificationStatus === "completed" || productData.isAiVerified) {
        console.warn(`Product ${productId} is already verified`);
        await paymentRef.update({
            fulfillmentStatus: "completed",
            fulfillmentCompletedAt: admin.firestore.FieldValue.serverTimestamp(),
            updatedAt: admin.firestore.FieldValue.serverTimestamp()
        });
        return;
    }

    if (productData.aiVerificationStatus === "processing") {
        console.warn(`Product ${productId} is already in processing state`);
        return;
    }

    // 5. Update Status to processing
    const now = admin.firestore.FieldValue.serverTimestamp();
    await db.runTransaction(async (transaction) => {
        transaction.update(productRef, {
            aiVerificationStatus: "processing",
            aiVerificationProcessingStartedAt: now,
            aiVerificationPaymentId: paymentId,
            updatedAt: now
        });
        transaction.update(paymentRef, {
            fulfillmentStatus: "processing",
            fulfillmentType: "aiVerification",
            fulfillmentStartedAt: now,
            aiVerificationTriggeredAt: now,
            updatedAt: now
        });
    });

    // 6. Gemini AI Call (Mock or Live)
    const isMockMode = process.env.AI_MOCK_MODE === "true";
    const apiKey = geminiApiKey.value();

    let aiResult;
    try {
        if (isMockMode) {
            aiResult = await runMockGeminiVerification({
                productId,
                title: productData.title,
                description: productData.description,
                category: productData.category,
                imageUrls
            });
        } else {
            if (!apiKey) {
                throw new Error("GEMINI_API_KEY is missing");
            }
            aiResult = await runLiveGeminiVerification({
                productId,
                title: productData.title,
                description: productData.description,
                category: productData.category,
                imageUrls,
                apiKey
            });
        }

        // 7. Process Verification Completion
        const isPassed = aiResult.status === "passed";
        
        await db.runTransaction(async (transaction) => {
            transaction.update(productRef, {
                isAiVerified: isPassed,
                aiVerificationStatus: isPassed ? "completed" : "failed",
                aiVerificationCompletedAt: admin.firestore.FieldValue.serverTimestamp(),
                aiVerifiedAt: admin.firestore.FieldValue.serverTimestamp(),
                aiVerificationResult: {
                    status: aiResult.status,
                    confidence: aiResult.score || 0.85,
                    summary: aiResult.summary || "Verified by Mozzy AI",
                    detectedCategory: aiResult.suggestedCategory || productData.category,
                    conditionGrade: aiResult.conditionLabel === "new" ? "A" : aiResult.conditionLabel === "good" ? "B" : "C",
                    riskFlags: aiResult.detectedIssues || []
                },
                // Deprecated Option A fields but keeping them updated for compatibility
                aiVerificationScore: aiResult.score || 0.85,
                aiVerificationSummary: aiResult.summary || "Verified by Mozzy AI",
                aiDetectedIssues: aiResult.detectedIssues || [],
                aiSuggestedCategory: aiResult.suggestedCategory || productData.category,
                aiConditionLabel: aiResult.conditionLabel || "unknown",
                updatedAt: admin.firestore.FieldValue.serverTimestamp()
            });

            transaction.update(paymentRef, {
                fulfillmentStatus: isPassed ? "completed" : "failed",
                fulfillmentCompletedAt: admin.firestore.FieldValue.serverTimestamp(),
                fulfillmentError: isPassed ? null : "ai_verification_failed",
                updatedAt: admin.firestore.FieldValue.serverTimestamp()
            });
        });

        console.log(`AI verification finished for product ${productId}: result = ${aiResult.status}`);

    } catch (e) {
        console.error(`AI verification exception for product ${productId}:`, e);
        
        await db.runTransaction(async (transaction) => {
            transaction.update(productRef, {
                aiVerificationStatus: "failed",
                aiVerificationError: e.message || "AI Verification Error",
                updatedAt: admin.firestore.FieldValue.serverTimestamp()
            });
            transaction.update(paymentRef, {
                fulfillmentStatus: "failed",
                fulfillmentFailedAt: admin.firestore.FieldValue.serverTimestamp(),
                fulfillmentError: "ai_api_error",
                updatedAt: admin.firestore.FieldValue.serverTimestamp()
            });
        });
    }
}

/**
 * Helper: run Mock Gemini AI Verification
 */
async function runMockGeminiVerification({ productId, title, description, category, imageUrls }) {
    console.log(`Running Mock Gemini verification for ${title}`);
    
    // We allow testing the failed path by having "fail" or "fraud" in the title!
    const isFail = title.toLowerCase().includes("fail") || title.toLowerCase().includes("fraud");
    
    if (isFail) {
        return {
            status: "failed",
            score: 0.15,
            summary: "Mock AI Verification Failed: Suspected fraud or keyword trigger",
            detectedIssues: ["suspected_mismatch", "keyword_flagged"],
            suggestedCategory: category,
            conditionLabel: "damaged"
        };
    } else {
        return {
            status: "passed",
            score: 0.95,
            summary: "Mock AI Verification Passed: Product image matches listing title and category",
            detectedIssues: [],
            suggestedCategory: category,
            conditionLabel: "good"
        };
    }
}

/**
 * Helper: run Live Gemini AI Verification
 */
async function runLiveGeminiVerification({ productId, title, description, category, imageUrls, apiKey }) {
    const modelName = process.env.GEMINI_MODEL || "gemini-3-flash-preview";
    
    const prompt = `You are a strict marketplace AI verification agent for Mozzy, a hyperlocal Indonesian marketplace.
You must verify whether the listing text and the uploaded product images match exactly.

Product Title: ${title}
Description: ${description}
Category: ${category}

Critical Rules:
1. Inspect the provided images directly and compare them with the title and description.
2. If the title claims a specific model, generation, or version (e.g., "AirPods Pro 3", "iPhone 15 Pro"), verify if the images actually show that exact model.
3. If the model/generation cannot be confidently verified from the images, you MUST return "needs_review".
4. If the images appear to show a different product, a different version, or a knock-off of what is claimed in the title, return "needs_review" or "failed".
5. If images are missing, blurry, or insufficient to prove the claim, return "needs_review".
6. Be extremely conservative for electronics and branded goods. Do not mark "passed" unless the image-text-category consistency is 100% clear.

Return ONLY a JSON object:
{
  "status": "passed" | "failed" | "needs_review",
  "score": 0.0 to 1.0,
  "summary": "Brief explanation",
  "detectedIssues": ["issue1", "issue2"],
  "suggestedCategory": "category name",
  "conditionLabel": "new" | "good" | "used" | "damaged" | "unknown",
  "imageTextMatch": "matched" | "mismatch" | "uncertain",
  "modelClaimVerified": true | false
}`;

    const parts = [{ text: prompt }];

    // Fetch the first image and add as inlineData
    if (imageUrls && imageUrls.length > 0) {
        const base64Data = await downloadImageAsBase64(imageUrls[0]);
        if (base64Data) {
            parts.push({
                inlineData: {
                    mimeType: "image/webp",
                    data: base64Data
                }
            });
        }
    }

    const response = await axios.post(
        `https://generativelanguage.googleapis.com/v1beta/models/${modelName}:generateContent?key=${apiKey}`,
        {
            contents: [{ parts }],
            generationConfig: {
                responseMimeType: "application/json",
            }
        },
        {
            headers: { 'Content-Type': 'application/json' },
            timeout: 25000
        }
    );

    const content = response.data?.candidates?.[0]?.content?.parts?.[0]?.text;
    if (!content) {
        throw new Error("Empty response from Gemini");
    }

    let cleanedJson = content.trim();
    if (cleanedJson.startsWith("```")) {
        const lines = cleanedJson.split("\n");
        if (lines.length >= 2) {
            cleanedJson = lines.slice(1, lines.length - 1).join("\n").trim();
        }
    }

    return JSON.parse(cleanedJson);
}

/**
 * Helper: Download image and encode as base64
 */
async function downloadImageAsBase64(url) {
    try {
        const response = await axios.get(url, { responseType: 'arraybuffer', timeout: 5000 });
        return Buffer.from(response.data, 'binary').toString('base64');
    } catch (e) {
        console.error(`Failed to download image from ${url}:`, e.message);
        return null;
    }
}

