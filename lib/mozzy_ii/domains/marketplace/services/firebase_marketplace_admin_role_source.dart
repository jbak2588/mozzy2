// ============================================================================
// Mozzy DocHeader
// Module        : Marketplace Domain
// File          : lib/mozzy_ii/domains/marketplace/services/firebase_marketplace_admin_role_source.dart
// Purpose       : Firebase Auth Custom Claims를 이용한 관리자 권한 조회 구현체.
// ============================================================================

import 'package:firebase_auth/firebase_auth.dart';
import '../models/admin_role_model.dart';
import '../security/marketplace_admin_allowlist.dart';
import 'marketplace_admin_role_source.dart';

class FirebaseMarketplaceAdminRoleSource implements MarketplaceAdminRoleSource {
  final FirebaseAuth _auth;

  FirebaseMarketplaceAdminRoleSource({FirebaseAuth? auth})
    : _auth = auth ?? FirebaseAuth.instance;

  @override
  Future<MarketplaceAdminRole> getCurrentRole({
    bool forceRefresh = false,
  }) async {
    final user = _auth.currentUser;
    if (user == null) return MarketplaceAdminRole.none;

    // Hard block: UID must be in allowlist before checking claims
    if (!isMarketplaceAdminUidAllowed(user.uid)) {
      return MarketplaceAdminRole.none;
    }

    try {
      final tokenResult = await user.getIdTokenResult(forceRefresh);
      final claims = tokenResult.claims;

      if (claims != null) {
        final roleValue = claims['marketplaceAdminRole'] as String?;
        if (roleValue != null) {
          final claimRole = _mapStringToRole(roleValue);
          if (claimRole != MarketplaceAdminRole.none) {
            return claimRole;
          }
        }
      }

      // Staging MVP fallback: allowlisted UID gets admin even without custom claims
      return marketplaceAdminRoleForAllowlistedUid(user.uid);
    } catch (e) {
      // Even if token refresh fails, allowlisted staging admin should not be locked out
      return marketplaceAdminRoleForAllowlistedUid(user.uid);
    }
  }

  MarketplaceAdminRole _mapStringToRole(String value) {
    switch (value) {
      case 'reviewer':
        return MarketplaceAdminRole.reviewer;
      case 'admin':
        return MarketplaceAdminRole.admin;
      case 'superAdmin':
        return MarketplaceAdminRole.superAdmin;
      case 'none':
      default:
        return MarketplaceAdminRole.none;
    }
  }
}
