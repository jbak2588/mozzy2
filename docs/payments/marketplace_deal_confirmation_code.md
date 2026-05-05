# Marketplace Deal Confirmation Code (COD Flow)

## Objective
To provide a secure, offline way to confirm that a transaction has been completed between a buyer and a seller, without Mozzy holding any funds.

## Mechanism
1. A buyer agrees to purchase an item via Cash on Delivery (COD) or direct offline transfer.
2. The `deals` document is created in Firestore with status `confirmed`.
3. A backend function (or secure client generation) creates a 6-character, uppercase alphanumeric `confirmationCode`.
4. The code is saved to the deal document and a `codeExpiresAt` is set (e.g., 24 hours from creation).
5. The UI shows the `confirmationCode` only to the Buyer.
6. When meeting, the Buyer shows/tells the code to the Seller.
7. The Seller inputs the code into the Mozzy app.
8. The app calls a function (or performs a transaction) to verify the code against `deals/{dealId}`.
9. If matched, the deal is marked as `completed`, and the product may be marked as `sold`.

## Security
- The code is short (6 chars) for easy typing but has enough entropy (36^6) for a 24-hour window per deal.
- Rate limiting should be applied to prevent brute-forcing the code on the seller side.
- Only the buyer of the specific deal can read the code.

## COD Entry Point & Verification
To ensure a smooth user experience, the COD CTA ("Beli COD") is explicitly displayed on the `ProductDetailScreen` just below the product header.

The CTA clearly communicates the product's COD eligibility based on the following rules:
- **Eligible**: Buyer + `aiVerificationStatus == 'passed'` + `isAiVerified == true` -> Button is active.
- **Needs Review**: Buyer + `needs_review` -> Button is disabled showing "Menunggu review admin".
- **Failed**: Buyer + `failed` (or `isAiVerified == false`) -> Button is disabled showing "Tidak lolos AI".
- **Seller Own Product**: Button is disabled showing "Tidak bisa membeli produk sendiri".
- **Unauthenticated**: Button is disabled showing "Login diperlukan".

This visibility rule replaces hiding the COD option entirely, ensuring users understand why they cannot proceed with a COD deal and reducing confusion during testing and regular use.


### 2026-05-05 Update: Auth-State & COD Ownership Validation
- Provider currentMarketplaceUserIdProvider has been updated to use FirebaseAuth.instance.authStateChanges() for reactively catching user switching.
- Admin effective role and ownership (Seller check isSeller = effectiveCurrentUid == product.sellerId) is explicitly validated using this reactive uid.
- Fixes an issue where F1Rho saw Beli COD on his own products due to stale static read of currentUser.uid.