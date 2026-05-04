# P2-B23-B6 Admin Allowlist Fallback and Location Scope Report

## 1. Status
- Overall: RESOLVED
- Latest commits address both admin role fallback and location scoping.
- Device: Passed emulator verification (Next: physical device).

## 2. Root Cause
| Issue | Cause | Fix |
|---|---|---|
| F1Rho admin showed role `none` | Firebase custom claim `marketplaceAdminRole` was never set for this user, so source returned `none` despite UID being in allowlist | Added staging fallback: if allowlisted UID has no/none claim, `marketplaceAdminRoleForAllowlistedUid()` returns `admin` |
| HUZ previously saw admin | No UID allowlist existed | B4 added allowlist — still working, HUZ blocked ✅ |
| Marketplace feed empty at Kelapa Dua | Location filter mismatch — products were created in Kebayoran Baru but device GPS reads Kelapa Dua | Added `Force Kebayoran Baru` dev override toggle in Dev Profile for testing COD |

## 3. Fix Summary

### marketplace_admin_allowlist.dart
- Added `marketplaceAdminRoleForAllowlistedUid(uid)` — returns `admin` for allowlisted UIDs, `none` otherwise

### firebase_marketplace_admin_role_source.dart
- Claims check now tries claim first; if claim is missing/none/invalid, falls back to `marketplaceAdminRoleForAllowlistedUid()`
- Token refresh error also falls back to allowlisted role instead of `none`

### marketplace_provider.dart (sync provider)
- `orElse` and `data: none` cases now use `marketplaceAdminRoleForAllowlistedUid(uid)` instead of `none`
- Guarantees allowlisted UIDs see admin menus even while async is loading

### profile_screen.dart & marketplace_location_provider.dart
- Added `UID allowlisted: true/false` display in Dev Profile with color coding
- Added `Force Kebayoran Baru` switch in Dev Profile.
- `marketplace_location_provider.dart` uses a `ForceKebayoranBaruNotifier` to hard-override the location scope to Kebayoran Baru.

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

## 6. Marketplace Location Note
Empty marketplace list at Kelapa Dua is expected — products were created in Kebayoran Baru.
For COD testing, the tester can now enable `Force Kebayoran Baru` from the Dev Profile to see existing products without needing to create new ones at their physical location.

## 7. Next Step
- Run on physical device to verify F1Rho now sees admin menus.
- Verify HUZ still blocked.
- Use `Force Kebayoran Baru` toggle on HUZ account to see existing products.
- Resume COD Buyer/Seller testing.
