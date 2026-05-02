# P2-B23: Xendit Payment & Idempotency Backlog

## Goal
Implement a secure, idempotent payment webhook and transaction synchronization system using Xendit.

## Tasks

### 1. Webhook Endpoint Setup
- [ ] Implement Xendit webhook receiving endpoint (Cloud Function or backend equivalent).
- [ ] Validate `X-CALLBACK-TOKEN` on all incoming requests to ensure authenticity.

### 2. Idempotency & Transaction Safety
- [ ] Enforce idempotency using Xendit's `external_id`.
- [ ] Ensure duplicate webhook receipts do not trigger re-processing or duplicate balance updates.
- [ ] Use Firestore Transactions to safely update states.

### 3. State Synchronization
- [ ] Record raw payloads in `payments/{externalId}`.
- [ ] Synchronize payment states securely to the `transactions` or `deals` collections.

### 4. Error Handling & Escalation
- [ ] Implement a retry/failure tracking mechanism.
- [ ] Trigger an escalation log/alert upon 3 consecutive processing failures for the same `external_id`.
