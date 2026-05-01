# Mozzy Phase 2: Marketplace Admin Claims / Role Source Foundation (P2-B17)

## 🎯 Overview
Implementation of a secure, server-side admin role foundation using Firebase Custom Claims. This replaces client-side hardcoded role enforcement with a claim-based source of truth that is synchronized with Firestore Security Rules.

## 🏗️ Key Changes

### 1. Custom Claims Contract
- **Claim Key**: `marketplaceAdminRole`
- **Allowed Values**: `none`, `reviewer`, `admin`, `superAdmin`.
- **Client Status**: Read-only. The Flutter app never sets or modifies these claims.

### 2. Admin Role Source Service
- **MarketplaceAdminRoleSource**: Abstract interface for role retrieval.
- **FirebaseMarketplaceAdminRoleSource**: Production implementation using `getIdTokenResult()` to read claims.
- **InMemoryMarketplaceAdminRoleSource**: Used for integration tests (`IntegrationTestConfig.enabled`) and unit tests.

### 3. Providers
- `marketplaceAdminRoleAsyncProvider`: A `FutureProvider` that asynchronously fetches the role from the claim source.
- `marketplaceAdminRoleProvider`: A sync `Provider` with fallback to `none` while loading, used for simple UI visibility.
- `AdminReviewActionController`: Updated to perform a fresh role check (with `forceRefresh: true`) before any moderation mutation to prevent unauthorized actions even if local state is stale.

### 4. UI Guards
- **AdminReviewScreen**: Re-implemented with `AsyncValue` to handle loading/error states during role verification.
- **MarketplaceListScreen**: Uses the async-backed role provider to show/hide the admin review entry point.

### 5. Firestore Security Rules
- Added helper functions: `marketplaceAdminRole()`, `canViewMarketplaceReviewQueue()`, `canModerateMarketplaceReviewQueue()`.
- Secured `ai_review_queue` collection:
  - `read`: Restricted to `reviewer`, `admin`, `superAdmin`.
  - `update`: Restricted to `admin`, `superAdmin`.

## 🔒 Security Documentation
- Created `docs/security/marketplace_admin_claims_setup.md` detailing the contract and provide pseudo-code for server-side claim assignment.

## 🧪 Verification Results
- **Unit Tests**:
  - `admin_role_provider_test.dart`: Verified async role propagation.
  - `marketplace_admin_role_source_test.dart`: Verified claim mapping from Firebase Auth.
  - `admin_review_screen_test.dart`: Verified role-based button visibility and access guards.
- **Analyze**: No issues found.
- **Marketplace E2E**: Passed on SM A715F. Integration mode correctly defaults to `admin` role.

## 📦 Commit Information
- **Feature Commit**: `PENDING_UNTIL_COMMIT`
- **Docs Commit**: `PENDING_UNTIL_COMMIT`

## 🚀 Next Steps
- **P2-B18**: Implementation of persistent Admin Audit Logs.
- **P2-B19**: Production script for batch/manual admin claim assignment.
