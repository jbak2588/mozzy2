# Xendit Webhook Idempotency Design

## Principles
1. Webhooks from Xendit can arrive multiple times for the same event.
2. The system must process an event exactly once.
3. Duplicate events must be safely acknowledged (HTTP 200) without altering the state again.
4. Security: The `X-CALLBACK-TOKEN` must be verified before processing.

## Flow
1. Request arrives at `POST /xendit/webhook`.
2. Extract token from headers, verify against `XENDIT_CALLBACK_TOKEN` secret. Return 401 if invalid.
3. Extract `external_id`, `status`, and `id` (event ID) from payload.
4. Begin Firestore Transaction:
   a. Read `payments/{externalId}`.
   b. Read `payment_events/{eventId}`.
   c. If `payment_events/{eventId}` exists -> Duplicate webhook -> Return 200 OK.
   d. If payment is already in `paid` status (and event is also `paid`) -> Duplicate state -> Write event as `ignored` -> Return 200 OK.
   e. Update `payments/{externalId}` status.
   f. Write `payment_events/{eventId}` with `idempotencyResult: processed`.
   g. Update associated `deals/{dealId}` status if required.
5. Commit transaction.
6. Return 200 OK to Xendit.

## Payment Events Logging
The `payment_events` collection acts as an audit trail for all incoming webhooks, regardless of whether they mutated the state or were ignored as duplicates.
