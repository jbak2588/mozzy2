// ============================================================================
// Mozzy DocHeader
// Module        : Marketplace Domain
// File          : lib/mozzy_ii/domains/marketplace/services/marketplace_admin_role_source.dart
// Purpose       : 관리자 권한(Custom Claims) 획득을 위한 추상 인터페이스.
// ============================================================================

import '../models/admin_role_model.dart';

abstract class MarketplaceAdminRoleSource {
  Future<MarketplaceAdminRole> getCurrentRole({bool forceRefresh = false});
}
