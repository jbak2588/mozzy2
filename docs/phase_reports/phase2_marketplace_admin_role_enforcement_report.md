# P2-B23-B9 Admin Allowlist Fallback and COD Seller Ownership Report

## 1. Status
- Overall: RESOLVED
- Latest commits address both admin role fallback, location scoping, and seller ownership of COD.
- Device: Passed emulator verification (Next: physical device).

## 2. Root Cause & Seller Fix
| Issue | Cause | Fix |
|---|---|---|
| F1Rho admin showed role `none` | `marketplaceAdminRoleAsyncProvider` and `FirebaseMarketplaceAdminRoleSource` fallback correctly, but token missing issue caused silent fallback. | Added `kDebugMode` logging inside `marketplaceAdminRoleAsyncProvider` to track `uid`, `isAllowlisted`, and `source.getCurrentRole` outputs. Fallback to admin relies on `isMarketplaceAdminUidAllowed()`. |
| F1Rho saw `Beli COD` on own product | `ProductDetailScreen` only blocked based on `product.userId` equality, but UI needed explicit rendering path for seller's own product. | Added `isSeller` check. When `true`, entirely hides `Beli COD` CTA and shows `Produk milik Anda` section with Edit/Delete/Mark Sold placeholders. |
| Buyer unclear about code usage | The buyer is given the 6-digit confirmation code but had no instructions on what the seller should do. | Added clear instructions for the buyer on `DealDetailScreen` to tell the seller to navigate to `Deals -> Penjualan -> Enter Code`. |

## 3. Fix Summary

### marketplace_admin_allowlist.dart
- `marketplaceAdminRoleForAllowlistedUid(uid)` correctly handles allowlist.

### firebase_marketplace_admin_role_source.dart
- Claims check falls back to `marketplaceAdminRoleForAllowlistedUid()`.
- Token refresh error falls back to allowlisted role instead of `none`.

### marketplace_provider.dart (sync provider)
- Sync provider gracefully handles `orElse` and `data: none` using the allowlist fallback.
- Added `debugPrint` logs inside `marketplaceAdminRoleAsyncProvider` to ensure visibility of the underlying role fetch.

### product_detail_screen.dart
- Extracted `_buildSellerOwnerActions` to explicitly render a seller-only view.
- Removed `Beli COD` functionality completely if the user is the seller.
- Moved `Segera hadir` tags to prevent confusion about COD availability.

### deal_detail_screen.dart
- Buyer screen now explicitly instructs: "Penjual harus membuka: Deals -> Penjualan -> pilih transaksi ini -> masukkan kode ini."

## 4. Policy Matrix

| UID | Allowlisted | Claim | Result |
|---|---|---|---|
| F1Rho | ✅ | admin | admin (from claim) |
| F1Rho | ✅ | reviewer | reviewer (from claim) |
| F1Rho | ✅ | none | admin (staging fallback) |
| F1Rho | ✅ | absent | admin (staging fallback) |
| F1Rho | ✅ | error | admin (staging fallback) |
| HUZ | ❌ | admin | none (blocked) |
| HUZ | ❌ | any | none (blocked) |
| null | ❌ | any | none (blocked) |

## 5. Test Results

| Suite | Count | Status |
|---|---:|---|
| flutter analyze | 0 issues | ✅ |
| marketplace tests | 93 | ✅ |
| timestamp tests | 5 | ✅ |
| auth tests | 3 | ✅ |

## 6. COD Buyer/Seller Handoff
- **Buyer**: Navigates to product -> Clicks `Beli COD` -> Gets a 6-digit code. Reads the instruction telling the Seller to go to `Deals`.
- **Seller**: Navigates to `Marketplace -> Deals (Icon) -> Penjualan (Tab)`. Selects the deal, enters the 6-digit code provided by the buyer.
- Seller cannot buy their own product via COD (blocked in UI and backend).

## 7. Next Step
- Run on physical device to verify F1Rho now sees admin menus.
- Verify F1Rho's product shows "Produk milik Anda" and Edit/Delete placeholders.
- Log in as HUZ, buy F1Rho's product via COD, and view the instructions.
- Switch to F1Rho, navigate to `Deals -> Penjualan`, enter the code to complete the deal.
- Proceed to P2-B23-C (Product Sold State Alignment).
