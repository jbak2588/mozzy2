import 'package:flutter_test/flutter_test.dart';
import 'package:mozzy/mozzy_ii/domains/admin/models/admin_claims_model.dart';

void main() {
  group('AdminClaimsModel', () {
    test('fromTokenClaims returns correct values for admin', () {
      final claims = {
        'admin': true,
        'adminRole': 'super_admin',
      };
      
      final model = AdminClaimsModel.fromTokenClaims(claims);
      
      expect(model.isAdmin, isTrue);
      expect(model.adminRole, 'super_admin');
      expect(model.claimsUpdatedAt, isNotNull);
    });

    test('fromTokenClaims returns false for non-admin', () {
      final claims = {
        'admin': false,
      };
      
      final model = AdminClaimsModel.fromTokenClaims(claims);
      
      expect(model.isAdmin, isFalse);
      expect(model.adminRole, isNull);
    });

    test('fromTokenClaims returns default for null claims', () {
      final model = AdminClaimsModel.fromTokenClaims(null);
      
      expect(model.isAdmin, isFalse);
      expect(model.adminRole, isNull);
    });

    test('fromJson and toJson work correctly', () {
      final model = AdminClaimsModel(
        isAdmin: true,
        adminRole: 'ops_admin',
        claimsUpdatedAt: DateTime(2026, 5, 8),
      );
      
      final json = model.toJson();
      final fromJson = AdminClaimsModel.fromJson(json);
      
      expect(fromJson.isAdmin, model.isAdmin);
      expect(fromJson.adminRole, model.adminRole);
      expect(fromJson.claimsUpdatedAt, model.claimsUpdatedAt);
    });

    test('role helpers return correct values', () {
      const superAdmin = AdminClaimsModel(isAdmin: true, adminRole: 'super_admin');
      const financeAdmin = AdminClaimsModel(isAdmin: true, adminRole: 'finance_admin');
      const opsAdmin = AdminClaimsModel(isAdmin: true, adminRole: 'ops_admin');
      const supportAdmin = AdminClaimsModel(isAdmin: true, adminRole: 'support_admin');
      const unknownAdmin = AdminClaimsModel(isAdmin: true, adminRole: 'unknown');
      const nonAdmin = AdminClaimsModel(isAdmin: false, adminRole: 'finance_admin');

      expect(superAdmin.isSuperAdmin, isTrue);
      expect(superAdmin.canReadMonetizationAudit, isTrue);

      expect(financeAdmin.isFinanceAdmin, isTrue);
      expect(financeAdmin.canReadMonetizationAudit, isTrue);

      expect(opsAdmin.isOpsAdmin, isTrue);
      expect(opsAdmin.canReadMonetizationAudit, isFalse);

      expect(supportAdmin.isSupportAdmin, isTrue);
      expect(supportAdmin.canReadMonetizationAudit, isFalse);

      expect(unknownAdmin.canReadMonetizationAudit, isFalse);
      expect(nonAdmin.canReadMonetizationAudit, isFalse);
    });
  });
}
