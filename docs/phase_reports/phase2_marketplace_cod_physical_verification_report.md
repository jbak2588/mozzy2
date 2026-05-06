# P2-B23-B14 COD Physical Verification Report

## 1. Status
- Overall: **VERIFIED**
- Device: Physical Device Testing

## 2. Buyer Flow
| Check | Result | Notes |
|---|---|---|
| HUZ role none | PASS | Verified in Dev Profile |
| HUZ sees Beli COD on F1Rho product | PASS | |
| HUZ creates deal | PASS | |
| 6-char code shown | PASS | Displayed on Deal Detail screen |
| Seller instruction shown | PASS | Instructions clearly visible |
| private_deal_codes doc created | PASS | Confirmed via Firebase |

## 3. Seller Flow
| Check | Result | Notes |
|---|---|---|
| F1Rho role admin | PASS | Verified via allowlist |
| F1Rho own product hides Beli COD | PASS | |
| Buka Transaksi COD Penjualan visible | PASS | Correctly replaces buyer CTA |
| Edit/Delete/Mark Sold removed | PASS | Deferred features hidden |
| Button opens Penjualan tab directly | PASS | Deep linking works correctly |
| HUZ deal visible in Penjualan | PASS | *Required Firebase composite index creation (`sellerId` ASC, `createdAt` DESC)* |
| Seller code input visible | PASS | |
| Correct code completes deal | PASS | Deal status successfully changed to `completed` |

## 4. Resolution of Blockers
During testing, the F1Rho seller initially saw an empty list ("Belum ada transaksi penjualan COD") despite the deal being successfully created.
- **Root Cause**: The required Firestore composite index for `deals` (`sellerId` ASC, `createdAt` DESC) had not been deployed to the testing environment. Additionally, `deal_repository.dart` was catching and swallowing `FirebaseException`s (including `failed-precondition` index errors and `permission-denied`), masking the root cause. The missing MVP Firestore rules for deals and private codes were also blocking secure queries.
- **Fix Applied**: 
  - Added strict P2-B23 MVP rules for `deals` and `private_deal_codes` to `firestore.rules`.
  - Modified `DealRepository` to rethrow exceptions in `fetchBuyerDeals` and `fetchSellerDeals` instead of returning `[]` silently.
  - The physical tester ran `firebase deploy --only firestore:rules,firestore:indexes`.
- **Outcome**: The seller immediately saw the deal list, entered the buyer's 6-character code, and the transaction completed successfully.

## 5. Decision
- P2-B23-B COD MVP is **VERIFIED** and complete.
- Next phase: **P2-B23-C Product Sold / Deal State Alignment** (Updating product to sold status when deal is completed).