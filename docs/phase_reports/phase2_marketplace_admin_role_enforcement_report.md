# P2-B23-B4 Admin Role Enforcement Report

## Blocker
Admin role leakage: after logging in as admin (F1Rho...), then switching to general user (HUZMs...), admin menus and routes remained accessible.

## Root Cause
1. `marketplaceAdminRoleAsyncProvider` did not watch `currentMarketplaceUserIdProvider` → account switch didn't invalidate cached admin role.
2. Sync fallback (`value ?? none`) could serve stale async value from previous user.
3. No UID-level hard block existed — relied entirely on custom claims which could cache.
4. No route-level guard on `/marketplace/admin-review` or `/marketplace/admin-audit-logs`.
5. `AdminReviewActionController` fell back to `'unknown_admin'` on null UID instead of rejecting.

## Fix Applied (commit 8b4e2e5)
- Created `marketplace_admin_allowlist.dart` with UID allowlist
- Hardened `FirebaseMarketplaceAdminRoleSource` with UID check before claims
- Made `marketplaceAdminRoleAsyncProvider` watch UID + check allowlist
- Made sync provider double-check allowlist
- Created `MarketplaceAdminGuardScreen` route guard
- Wrapped admin routes in `app_router.dart`
- Admin buttons in `DevProfileScreen` and `MarketplaceListScreen` now check allowlist + role
- Logout invalidates admin role providers
- `AdminReviewActionController.approve/reject/dismiss` rejects non-allowlisted UIDs

## Test Results
- flutter analyze: 0 issues
- marketplace tests: 86 PASS (including 11 new admin tests)
- auth tests: 3 PASS
- timestamp tests: 5 PASS

## Status
RESOLVED — Pending live verification with both accounts.
