// ============================================================================
// Mozzy DocHeader
// Module        : Marketplace Domain
// File          : lib/mozzy_ii/domains/marketplace/models/admin_role_model.dart
// Purpose       : Marketplace 관리자 권한 모델 및 권한 로직 정의.
// ============================================================================

enum MarketplaceAdminRole { none, reviewer, admin, superAdmin }

extension MarketplaceAdminRoleX on MarketplaceAdminRole {
  bool get canViewReviewQueue =>
      this == MarketplaceAdminRole.reviewer ||
      this == MarketplaceAdminRole.admin ||
      this == MarketplaceAdminRole.superAdmin;

  bool get canModerate =>
      this == MarketplaceAdminRole.admin ||
      this == MarketplaceAdminRole.superAdmin;
}
