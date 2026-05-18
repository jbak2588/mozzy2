# Xendit Sandbox Setup

This guide explains how to set up and test the Xendit payment integration in the Mozzy Sandbox environment.

## 1. Required Environment Variables / Secrets

The following secrets must be configured in Firebase Functions Secret Manager or via `.env` file (not committed).

| Secret Name | Description | Source |
|---|---|---|
| `XENDIT_SECRET_KEY` | Xendit API Secret Key (Standard or API Key) | Xendit Dashboard > Settings > API Keys |
| `XENDIT_WEBHOOK_VERIFICATION_TOKEN` | Token to verify incoming webhooks from Xendit | Xendit Dashboard > Settings > Callbacks |
| `PAYMENT_MOCK_MODE` | Set to `true` to skip actual Xendit API calls and return mock URLs | Local/Test Env |

## 2. Firebase Functions Configuration

### Region
- **Region**: `asia-southeast2` (Jakarta)

### Deployment
Ensure the new callable functions are exported in `functions-v2/index.js`.

```bash
firebase deploy --only functions
```

## 3. Testing Callable Functions

You can test the callable functions using the Firebase CLI or the Firebase Console.

### Create Invoice
**Payload**:
```json
{
  "purpose": "boostJob",
  "userId": "TARGET_USER_UID",
  "amountIdr": 15000,
  "description": "Job Boost 1 Day",
  "sourceType": "job",
  "sourceId": "JOB_ID_HERE"
}
```

### Get Payment Status
**Payload**:
```json
{
  "paymentId": "INTERNAL_PAYMENT_ID"
}
```

## 4. Webhook Setup

1. Go to **Xendit Dashboard** > **Settings** > **Callbacks**.
2. Set the **Invoice Paid** and **Invoice Expired** callback URLs to:
   `https://asia-southeast2-YOUR_PROJECT_ID.cloudfunctions.net/xenditWebhook`
3. Copy the **Verification Token** and set it as `XENDIT_WEBHOOK_VERIFICATION_TOKEN` in Firebase.

## 5. Standard Payment Flow

1. **Flutter App** calls `createXenditInvoice`.
2. **Backend** creates a document in `payments/{paymentId}` with status `created`.
3. **Backend** calls Xendit API to create an invoice.
4. **Backend** updates `payments/{paymentId}` with `providerInvoiceUrl` and status `pending`.
5. **Flutter App** receives `PaymentResult` and opens the `invoiceUrl`.
6. **User** completes payment in Xendit UI.
7. **Xendit** sends a webhook to `xenditWebhook`.
8. **Backend** validates token and updates `payments/{paymentId}` status to `paid`.
9. **Firestore Trigger** (e.g., `onPaymentPaidActivateJobBoost`) performs the actual fulfillment (e.g., activating the boost).

## 6. Security Reminders
- **NEVER** commit `XENDIT_SECRET_KEY` to the repository.
- **NEVER** return the secret key in any API response.
- **ALWAYS** verify that the `userId` in the request matches the authenticated user's UID.
