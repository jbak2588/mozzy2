# ADR 002: Ver 6.1 Selective Adoption for Mozzy Ver 2.0

## Status
Accepted (2026-05-02)

## Context
A comprehensive architectural proposal (Ver 6.1) was presented, suggesting a massive "5-Engine" redesign, the introduction of Redis/PostgreSQL, reducing Firestore collections from 11 to 6, and rolling back Riverpod versions. 
However, Mozzy Ver 2.0 is currently in progress, with the Marketplace, Auth, Admin, and AI screening features actively pending P2-B22 live verification. A broad refactoring at this stage would derail the MVP timeline and introduce unacceptable risks to the current stabilization phase.

## Decision
We will selectively adopt only isolated, high-value components from the Ver 6.1 proposal into Ver 2.0. A full migration to the 5-Engine architecture is deferred.

### 1. Adopt Now (Must Do)
*   **Xendit Idempotency**: Implementing strict webhook validation and external_id idempotency (Backlog: P2-B23).
*   **COD confirmationCode**: Adding a 6-character alphanumeric code for secure local delivery completion.
*   **PDPB Security Checklist**: Enforcing strict PII rules (no plaintext NIK, no original KTP images).
*   **signalScore v1 (Formula only)**: Documenting the Smart Feed proximity and recency formula (Implementation deferred).

### 2. Adopt Later (Partial/Soft Implementation)
*   **WarungModel**: We will prefer `WarungModel` naming for future Local Stores features but will not migrate existing `shops` collections immediately.
*   **TrustLevel 3**: Documented as a future gate for high-risk transactions (e.g., Bantu/Titip, High-value), but not strictly enforced in current Auth/Marketplace flows.
*   **FCM Priority**: Notifications schema and type enums will be designed first. Cloud Functions implementation is deferred until the core flows are stable.

### 3. Do Not Adopt Yet (Deferred to Ver 3.0+)
*   5-Engine entire collection migration
*   Riverpod 2.4 rollback
*   Firestore 11 -> 6 collections forced merge
*   Redis / PostgreSQL introduction
*   Soft Trust 90-day strict policy
*   Wallet implementation

## Consequences
This selective adoption allows Ver 2.0 to proceed with its P2-B22 live verification without interruption, while simultaneously securing the roadmap for payments (Xendit), delivery completion (COD codes), and strict Indonesian data privacy compliance (PDPB).
