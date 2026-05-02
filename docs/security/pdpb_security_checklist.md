# PDPB Security Checklist

To comply with Indonesian Data Privacy regulations (PDPB) and ensure user trust, the following security measures must be strictly adhered to during development and code review.

## PII Storage (Strict Prohibitions)
- [ ] **NO Plaintext NIK**: Nomor Induk Kependudukan (NIK) must NEVER be stored in plaintext within Firestore or any database.
- [ ] **NO Original KTP Images**: Original photos of Identity Cards (KTP) must NEVER be stored in Cloud Storage.
- [ ] **Hash Only**: Only the hashed representation of the KTP/Identity document should be stored for verification purposes.

## User Rights
- [ ] **Right to Erasure**: API/Backend flows must be designed to support complete user data deletion upon request.

## Geo-Location Privacy
- [ ] **NO Precise Location Publishing**: Exact GPS coordinates must NOT be publicly exposed in feeds or APIs. Use hashed locations, relative distances, or administrative boundaries (Kelurahan/Kecamatan).

## Code & Documentation Security
- [ ] **NO Secret Exposure**: Secrets, API Keys, and Client IDs must NEVER be recorded in plaintext inside markdown documents, logs, or commit messages. Use placeholders (e.g., `<REAL_API_KEY>`, `PRESENT`).
