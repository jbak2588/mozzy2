# P2-B23 Xendit Payment Architecture

## 1. Scope
Phase 2-B23 covers the payment planning and implementation for Marketplace deals in Mozzy Ver 2.0.
The payment system is divided into two phases:
- Phase 1: COD / Offline Deal Confirmation (no funds held by Mozzy).
- Phase 2: Xendit Payment via QRIS / E-wallet / Invoice (funds processed by Xendit, synchronized via webhooks).

## 2. What P2-B23 Will Not Do
- Actual Xendit API code implementation is deferred until the architecture is approved.
- No direct in-app wallet or escrow system will be built.
- No direct client manipulation of payment state (status).
- No production rules lockdown yet.
- Full automated PG settlement/accounting.

## 3. Marketplace Deal Flow
1. Buyer creates a Deal from a Product.
2. Deal state transitions: `pending` -> `confirmed` -> `payment_pending` -> `paid` -> `completed`.
3. If COD, the flow jumps from `confirmed` to `completed` using the `confirmationCode`.
4. If Xendit Payment, it goes through `payment_pending` and waits for a webhook to mark as `paid`, then `completed`.

## 4. COD confirmationCode Flow
- When a Deal is `confirmed` (for offline completion), a 6-character alphanumeric `confirmationCode` is generated.
- Buyer sees the code on their device.
- Seller inputs the code on their device when they meet.
- Match confirms the deal as `completed` via a Firestore transaction.
- Code expires in 24 hours.

## 5. Xendit Payment Flow
- Buyer selects online payment -> Payment doc created in Firestore, status `pending`.
- Cloud Function calls Xendit to generate Invoice/QRIS.
- Xendit returns `external_id` and payment URL/QR code.
- User pays via Xendit.
- Xendit sends a Webhook event to Mozzy Cloud Functions.
- Webhook validates signature, ensures idempotency, and updates Payment and Deal status to `paid`.

## 6. Firestore Collections
- `countries/ID/domains/marketplace/deals/{dealId}`
- `countries/ID/domains/marketplace/payments/{externalId}`
- `countries/ID/domains/marketplace/payment_events/{eventId}`

## 7. Webhook Idempotency
- Xendit webhooks may be delivered multiple times.
- Cloud Functions will use Firestore Transactions to process events.
- Duplicate `externalId` and `status` updates will be ignored and safely return 200 OK.
- Unprocessed events will update the Payment and log the event in `payment_events`.

## 8. Security Rules Draft
- Client direct payment status write is forbidden.
- Webhook/Admin SDK is the single source of truth for payment status.
- Buyer can read their own deals/payments.
- Seller can read payments for their own products/deals.
- Admin can read audit logs and payment events.

## 9. Cloud Functions Plan
- `xendit_webhook.ts` endpoint.
- Validates `X-CALLBACK-TOKEN`.
- Parses and normalizes `external_id` and status.
- Updates Firestore securely.

## 10. Client UI Plan
- Checkout screen to select COD or Online Payment.
- COD screen to display/input `confirmationCode`.
- Online Payment screen embedding Xendit Invoice UI or QRIS display.

## 11. Sandbox Test Plan
- Use Xendit Sandbox API keys.
- Simulate payments via Xendit Dashboard or API.
- Validate webhooks via ngrok or Firebase Emulator.

## 12. Failure Cases
- Webhook failure -> automatic retry from Xendit.
- Payment expiration -> Webhook marks as `expired`, UI updates.
- Invalid `confirmationCode` -> UI error message.
- Dispute -> Admin intervention.

## 13. Open Questions
- Xendit product to use first: Invoice vs Direct QRIS? (Suggest Invoice for MVP flexibility)
- Webhook hosting region: `asia-southeast2` (Jakarta)?
- Required business approval status for live PG?

## 14. Implementation Sequence
- P2-B23-A: Architecture / schema / security planning
- P2-B23-B: COD confirmationCode MVP
- P2-B23-C: payments/deals Firestore models
- P2-B23-D: Xendit sandbox environment setup
- P2-B23-E: Cloud Functions webhook skeleton
- P2-B23-F: Invoice/QRIS sandbox creation
- P2-B23-G: Webhook live test
- P2-B23-H: Payment UI integration
- P2-B23-I: Admin payment audit screen
- P2-B23-J: Final staging verification
