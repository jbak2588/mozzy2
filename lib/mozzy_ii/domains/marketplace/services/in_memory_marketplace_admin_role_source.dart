// ============================================================================
// Mozzy DocHeader
// Module        : Marketplace Domain
// File          : lib/mozzy_ii/domains/marketplace/services/in_memory_marketplace_admin_role_source.dart
// Purpose       : 테스트 및 통합 테스트를 위한 인메모리 관리자 권한 조회 구현체.
// ============================================================================

import '../models/admin_role_model.dart';
import 'marketplace_admin_role_source.dart';

class InMemoryMarketplaceAdminRoleSource implements MarketplaceAdminRoleSource {
  MarketplaceAdminRole _role;

  InMemoryMarketplaceAdminRoleSource([this._role = MarketplaceAdminRole.none]);

  void setRole(MarketplaceAdminRole role) {
    _role = role;
  }

  @override
  Future<MarketplaceAdminRole> getCurrentRole({bool forceRefresh = false}) async {
    return _role;
  }
}
