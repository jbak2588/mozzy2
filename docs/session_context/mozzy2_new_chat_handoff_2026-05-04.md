# Handoff: P2-B23-B6 Admin Allowlist Fallback Complete

## Context
F1Rho admin was blocked because Firebase custom claims were absent. Fixed with staging fallback:
allowlisted UIDs get `admin` role regardless of claim state.

## Key Changes (commit 55d03a3)
- `marketplace_admin_allowlist.dart`: `marketplaceAdminRoleForAllowlistedUid()` returns admin for allowlisted UIDs
- `firebase_marketplace_admin_role_source.dart`: Falls back to allowlist role when claims missing/none/error
- `marketplace_provider.dart`: Sync provider uses allowlist fallback during loading and none states
- `profile_screen.dart`: Shows UID allowlist status in Dev Profile

## Admin UID: F1RhoJnK0uUQ1jPzvA9GuIG6U2w1 — Expected: admin
## General UID: HUZMs5mweBT2DjkS8vHQrDjKZCx2 — Expected: none (blocked)

## Test Status
- marketplace tests: 93 PASS
- flutter analyze: 0 issues

## Next Actions
1. Physical device test: verify F1Rho sees admin, HUZ blocked
2. Resume COD Buyer/Seller verification
3. Address location mismatch for COD testing (create product in buyer's location)
