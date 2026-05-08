const { onDocumentCreated, onDocumentUpdated } = require("firebase-functions/v2/firestore");
const admin = require("firebase-admin");

admin.initializeApp();

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

// Boost Packages Policy
const BOOST_PACKAGES = {
    'job_boost_1_day': { amount: 15000, durationDays: 1, title: 'Boost 1 hari' },
    'job_boost_3_days': { amount: 40000, durationDays: 3, title: 'Boost 3 hari' },
    'job_boost_7_days': { amount: 90000, durationDays: 7, title: 'Boost 7 hari' }
};

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
                        durationDays: pkg.durationDays,
                        ownerId: userId
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
                paymentData.rawProviderStatus = invoice.status;
                paymentData.status = "pending";
                
                if (invoice.expiry_date) {
                    paymentData.expiredAt = admin.firestore.Timestamp.fromDate(new Date(invoice.expiry_date));
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
                updateData.expiredAt = admin.firestore.Timestamp.fromDate(new Date(payload.expiry_date));
            }

            transaction.update(paymentRef, updateData);
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
        updatedAt: admin.firestore.FieldValue.serverTimestamp()
    };
}

// Export helpers for testing
exports._testHelpers = {
    mapXenditInvoiceStatus,
    shouldSkipUpdate,
    resolveBoostDurationDays,
    calculateBoostActiveUntil,
    shouldActivateJobBoost,
    buildJobBoostUpdate
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

            console.log(`Successfully activated job boost for job ${jobId}`);
        });
    } catch (error) {
        console.error(`Error activating job boost for ${paymentId}:`, error);
    }
});
