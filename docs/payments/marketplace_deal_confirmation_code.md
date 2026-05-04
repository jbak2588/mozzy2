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
