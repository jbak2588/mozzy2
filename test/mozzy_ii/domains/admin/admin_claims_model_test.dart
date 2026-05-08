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
  });
}
