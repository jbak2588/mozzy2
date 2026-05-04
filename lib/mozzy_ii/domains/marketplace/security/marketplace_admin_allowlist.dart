// ============================================================================
// Mozzy DocHeader
// Module        : Marketplace Domain
// File          : lib/mozzy_ii/domains/marketplace/security/marketplace_admin_allowlist.dart
// Purpose       : Staging MVP UID allowlist for marketplace admin access.
//                 Production에서는 custom claims + Firestore admin registry +
//                 server-side rules로 확장할 수 있습니다.
// ============================================================================

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
