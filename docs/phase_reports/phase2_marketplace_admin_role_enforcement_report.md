# P2-B23-B6 Admin Allowlist Fallback Fix Report

## 1. Root Cause

| Issue | Cause | Fix |
|---|---|---|
| F1Rho admin showed role `none` | Firebase custom claim `marketplaceAdminRole` was never set for this user, so source returned `none` despite UID being in allowlist | Added staging fallback: if allowlisted UID has no/none claim, `marketplaceAdminRoleForAllowlistedUid()` returns `admin` |
| HUZ previously saw admin (B4 fix) | No UID allowlist existed | B4 added allowlist — still working, HUZ blocked ✅ |
| Marketplace feed empty at Kelapa Dua | Location filter mismatch — products were created in Kebayoran Baru but device GPS reads Kelapa Dua | Expected behavior for location-scoped marketplace; will resolve via new product creation in buyer location |

## 2. Fix Summary

### marketplace_admin_allowlist.dart
- Added `marketplaceAdminRoleForAllowlistedUid(uid)` — returns `admin` for allowlisted UIDs, `none` otherwise

### firebase_marketplace_admin_role_source.dart
- Claims check now tries claim first; if claim is missing/none/invalid, falls back to `marketplaceAdminRoleForAllowlistedUid()`
- Token refresh error also falls back to allowlisted role instead of `none`

### marketplace_provider.dart (sync provider)
- `orElse` and `data: none` cases now use `marketplaceAdminRoleForAllowlistedUid(uid)` instead of `none`
- Guarantees allowlisted UIDs see admin menus even while async is loading

### profile_screen.dart
- Added `UID allowlisted: true/false` display in Dev Profile with color coding

## 3. Policy Matrix

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

## 4. Test Results

| Suite | Count | Status |
|---|---:|---|
| flutter analyze | 0 issues | ✅ |
| marketplace tests | 93 | ✅ (was 86, now 93 with expanded admin tests) |
| timestamp tests | 5 | ✅ |
| auth tests | 3 | ✅ |

## 5. Commit
- `55d03a3` — fix(marketplace): allowlisted admin fallback role for staging

## 6. Marketplace Location Note
Empty marketplace list at Kelapa Dua is expected — products were created in Kebayoran Baru.
For COD testing, seller should create a new product while at the buyer's location (Kelapa Dua), or both accounts should be tested from the same location.

## 7. Next Step
- Run on physical device to verify F1Rho now sees admin menus
- Verify HUZ still blocked
- If admin guard passes: resume COD Buyer/Seller testing
