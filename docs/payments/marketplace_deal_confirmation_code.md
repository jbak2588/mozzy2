# Marketplace Deal Confirmation Code (COD)

## 1. Flow Overview
1. A buyer agrees to purchase an item via Cash on Delivery (COD) or direct offline transfer.
2. The `deals` document is created in Firestore with status `confirmed`.
3. A 6-character, uppercase alphanumeric `confirmationCode` is generated.
4. The code hash is stored in the deal; raw code is stored in `users/{buyerId}/private_deal_codes/{dealId}`.
5. The UI shows the `confirmationCode` only to the Buyer.
6. When meeting, the Buyer shows/tells the code to the Seller.
7. The Seller inputs the code into the Mozzy app on their Deal Detail screen (Penjualan tab).
8. If matched, the deal is marked as `completed`.

## 2. Physical Verification Results (2026-05-06)
- **Status**: VERIFIED
- **Device**: Physical Android device (RR8N109B4JM)
- **HUZ buyer created COD deal**: PASS
- **Buyer code displayed**: PASS
- **F1Rho seller opened Penjualan list**: PASS (After index fix)
- **Seller entered code**: PASS
- **Deal completed**: PASS

## 3. Root Cause Analysis (Resolved)
- **Issue**: Seller's "Penjualan" deal list was empty on first attempt.
- **Root Cause**: Firestore composite index for `sellerId` ASC + `createdAt` DESC was missing in the environment.
- **Resolution**: Deployed `firestore.indexes.json` with the missing composite indexes. Deal list now displays correctly.

## 4. Implementation Details
- Code is 6 characters (Uppercase + Digits).
- Hashing: `SHA-256(dealId + rawCode)`.
- Max attempts: 5 (locked after failure).
- Expiry: 24 hours.

## 5. Known Limitations & Next Steps
- **Duplicate Prevention**: Currently allowed for testing, but restricted in P2-B23-C.
- **Product State Alignment**: Completed deal now updates product status to `sold` (Implemented in P2-B23-C).

## 6. COD Entry Point & Verification
The CTA clearly communicates the product's COD eligibility based on:
- **Eligible**: Buyer + `aiVerificationStatus == 'passed'` + `isAiVerified == true` -> Button active.
- **Needs Review**: Buyer + `needs_review` -> "Menunggu review admin".
- **Failed**: Buyer + `failed` -> "Tidak lolos AI".
- **Seller Own Product**: "Buka Transaksi COD Penjualan" (routes to sales tab).
- **Unauthenticated**: "Login diperlukan".
