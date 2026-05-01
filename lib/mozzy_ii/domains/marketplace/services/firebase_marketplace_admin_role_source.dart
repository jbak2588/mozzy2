// ============================================================================
// Mozzy DocHeader
// Module        : Marketplace Domain
// File          : lib/mozzy_ii/domains/marketplace/services/firebase_marketplace_admin_role_source.dart
// Purpose       : Firebase Auth Custom Claims를 이용한 관리자 권한 조회 구현체.
// ============================================================================

import 'package:firebase_auth/firebase_auth.dart';
import '../models/admin_role_model.dart';
import 'marketplace_admin_role_source.dart';

class FirebaseMarketplaceAdminRoleSource implements MarketplaceAdminRoleSource {
  final FirebaseAuth _auth;

  FirebaseMarketplaceAdminRoleSource({FirebaseAuth? auth})
      : _auth = auth ?? FirebaseAuth.instance;

  @override
  Future<MarketplaceAdminRole> getCurrentRole({bool forceRefresh = false}) async {
    final user = _auth.currentUser;
    if (user == null) return MarketplaceAdminRole.none;

    try {
      final tokenResult = await user.getIdTokenResult(forceRefresh);
      final claims = tokenResult.claims;
      
      if (claims == null) return MarketplaceAdminRole.none;

      final roleValue = claims['marketplaceAdminRole'] as String?;
      
      if (roleValue == null) return MarketplaceAdminRole.none;

      return _mapStringToRole(roleValue);
    } catch (e) {
      // In case of error (network, etc.), default to none for security
      return MarketplaceAdminRole.none;
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
