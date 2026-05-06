# P2-B23: Xendit Payment & Idempotency Backlog

## Goal
Implement a secure, idempotent payment webhook and transaction synchronization system using Xendit. Also include an offline COD confirmation flow.

## Sequence / Phases
- [x] P2-B23-A: Architecture / schema / security planning
- [x] P2-B23-B: COD confirmationCode MVP (Verified 2026-05-06)
- [x] P2-B23-C: Product Sold / Deal State Alignment (Implemented 2026-05-06)
- [ ] P2-B23-D: Xendit sandbox environment setup
- [ ] P2-B23-E: Cloud Functions webhook skeleton
- [ ] P2-B23-F: Invoice/QRIS sandbox creation
- [ ] P2-B23-G: Webhook live test
- [ ] P2-B23-H: Payment UI integration
- [ ] P2-B23-I: Admin payment audit screen
- [ ] P2-B23-J: Final staging verification

## Tasks

### 1. Webhook Endpoint Setup
- [ ] Implement Xendit webhook receiving endpoint (Cloud Function or backend equivalent).
- [ ] Validate `X-CALLBACK-TOKEN` on all incoming requests to ensure authenticity.

### 2. Idempotency & Transaction Safety
- [ ] Enforce idempotency using Xendit's `external_id` or event `id`.
- [ ] Ensure duplicate webhook receipts do not trigger re-processing or duplicate balance updates.
- [ ] Use Firestore Transactions to safely update states.

### 3. State Synchronization
- [ ] Record raw payloads in `payments/{externalId}`.
- [ ] Synchronize payment states securely to the `transactions` or `deals` collections.

### 4. Error Handling & Escalation
- [ ] Implement a retry/failure tracking mechanism.
- [ ] Trigger an escalation log/alert upon 3 consecutive processing failures for the same `external_id`.

### 5. COD Confirmation
- [x] Generate 6-char `confirmationCode` upon deal confirmation.
- [x] Implement seller code entry to complete a deal offline safely.
