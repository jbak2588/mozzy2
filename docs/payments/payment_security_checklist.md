# Payment Security Checklist

- [ ] **No Client-Side Status Updates**: The client application must NEVER update payment statuses directly. Only Cloud Functions/Webhooks and Admin SDK can write to payment statuses.
- [ ] **Webhook Authentication**: All webhooks must validate the `X-CALLBACK-TOKEN` from Xendit.
- [ ] **Idempotency Enforcement**: Use transactions and unique event IDs to prevent duplicate webhook processing.
- [ ] **Secret Management**: Xendit Secret Keys (`XENDIT_SECRET_KEY`) must NEVER be exposed in the Flutter app or committed to version control.
- [ ] **Data Minimization**: Do not store full credit card numbers or sensitive banking credentials; rely entirely on the Payment Gateway (Xendit).
- [ ] **Audit Logging**: All payment events and admin actions must be securely logged and immutable.
- [ ] **Confirmation Code Rate Limiting**: Limit the number of attempts a seller can make to enter a `confirmationCode` to prevent brute force attacks.
- [ ] **Firestore Rules**: 
  - buyer can read own deal
  - seller can read own deal
  - buyer can read own private code
  - seller cannot read buyer private code
  - seller can submit code verification only through repository/client transaction for MVP
  - production should move verification to Cloud Functions
