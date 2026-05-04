// ============================================================================
// Mozzy DocHeader
// Module        : Marketplace Domain
// File          : lib/mozzy_ii/domains/marketplace/security/marketplace_admin_allowlist.dart
// Purpose       : Staging MVP UID allowlist for marketplace admin access.
//                 Production에서는 custom claims + Firestore admin registry +
//                 server-side rules로 확장할 수 있습니다.
// ============================================================================

import '../models/admin_role_model.dart';

/// Staging MVP: Only these UIDs can access marketplace admin features.
/// In production, this will be replaced by Firestore admin registry +
/// Firebase custom claims + server-side security rules.
const Set<String> marketplaceAdminUidAllowlist = {
  'F1RhoJnK0uUQ1jPzvA9GuIG6U2w1',
};

/// Returns true only if the given UID is in the marketplace admin allowlist.
/// Returns false for null, empty, or non-allowlisted UIDs.
bool isMarketplaceAdminUidAllowed(String? uid) {
  if (uid == null || uid.isEmpty) return false;
  return marketplaceAdminUidAllowlist.contains(uid);
}

/// Returns the staging fallback role for an allowlisted UID.
/// If the UID is in the allowlist, returns [MarketplaceAdminRole.admin]
/// even if Firebase custom claims are missing or stale.
/// Non-allowlisted UIDs always return [MarketplaceAdminRole.none].
///
/// This is the staging MVP policy: allowlisted UID = admin.
/// Production will use Firestore admin registry + custom claims.
MarketplaceAdminRole marketplaceAdminRoleForAllowlistedUid(String? uid) {
  if (!isMarketplaceAdminUidAllowed(uid)) {
    return MarketplaceAdminRole.none;
  }
  return MarketplaceAdminRole.admin;
}
