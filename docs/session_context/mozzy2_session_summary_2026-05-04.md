# Session Summary: P2-B23-B6 Admin Allowlist Fallback Fix

## Critical Fix
Admin UID F1Rho was blocked from admin features despite being in the UID allowlist.
Root cause: Firebase custom claim `marketplaceAdminRole` was never set, so the source returned `none`.

## Solution
Added staging fallback: allowlisted UIDs get `admin` role even when custom claims are missing, `none`, or when token refresh fails.
Non-allowlisted UIDs remain permanently blocked regardless of claims.

## Changes
- `marketplace_admin_allowlist.dart`: Added `marketplaceAdminRoleForAllowlistedUid()`
- `firebase_marketplace_admin_role_source.dart`: Claims → fallback chain for allowlisted UIDs
- `marketplace_provider.dart`: Sync provider uses allowlist fallback during loading/none
- `profile_screen.dart`: Shows `UID allowlisted: true/false` in Dev Profile

## Test Results
- flutter analyze: 0 issues
- marketplace tests: 93 PASS (expanded from 86)
- auth tests: 3 PASS
- timestamp tests: 5 PASS
- Commit: 55d03a3

## Location Note
Marketplace feed empty at Kelapa Dua — location-scoped, not a bug.
Products were created in Kebayoran Baru. COD test needs same-location products.

## Next Steps
- Verify on physical device: F1Rho sees admin, HUZ does not
- Resume COD Buyer/Seller testing after admin guard confirmed
