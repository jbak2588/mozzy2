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

const { onCall, HttpsError } = require("firebase-functions/v2/https");
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

    // 6. Provider Invoice Creation (Xendit Sandbox)
    let providerInvoiceId = null;
    let providerInvoiceUrl = null;

    if (provider === "xendit") {
        try {
            // Mocking Xendit API call for now if keys are missing, 
            // but structure follows Xendit Invoice API
            const xenditSecretKey = process.env.XENDIT_SECRET_KEY || "xnd_development_mock_key";
            const authHeader = Buffer.from(`${xenditSecretKey}:`).toString('base64');

            // In real implementation:
            // const response = await axios.post('https://api.xendit.co/v2/invoices', { ... }, { headers: { Authorization: `Basic ${authHeader}` } });
            
            // Mock Success Response for P4-M02
            providerInvoiceId = `inv_${paymentId}`;
            providerInvoiceUrl = `https://checkout-staging.xendit.co/v2/${providerInvoiceId}`;

            paymentData.status = "pending";
            paymentData.providerInvoiceId = providerInvoiceId;
            paymentData.providerInvoiceUrl = providerInvoiceUrl;
        } catch (error) {
            console.error("Xendit API Error:", error);
            throw new HttpsError("internal", "Failed to communicate with payment provider");
        }
    } else {
        throw new HttpsError("unimplemented", "Selected provider is not yet supported");
    }

    // 7. Persist and Return
    await admin.firestore().collection("payments").doc(paymentId).set(paymentData);

    return {
        paymentId: paymentId,
        invoiceUrl: providerInvoiceUrl,
        providerInvoiceId: providerInvoiceId,
        status: "pending"
    };
});
