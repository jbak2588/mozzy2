import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:mockito/annotations.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:mozzy/mozzy_ii/domains/marketplace/services/firebase_marketplace_admin_role_source.dart';
import 'package:mozzy/mozzy_ii/domains/marketplace/models/admin_role_model.dart';

import 'marketplace_admin_role_source_test.mocks.dart';

@GenerateMocks([FirebaseAuth, User, IdTokenResult])
void main() {
  late MockFirebaseAuth mockAuth;
  late MockUser mockUser;
  late MockIdTokenResult mockTokenResult;
  late FirebaseMarketplaceAdminRoleSource roleSource;

  setUp(() {
    mockAuth = MockFirebaseAuth();
    mockUser = MockUser();
    mockTokenResult = MockIdTokenResult();
    roleSource = FirebaseMarketplaceAdminRoleSource(auth: mockAuth);
  });

  group('FirebaseMarketplaceAdminRoleSource', () {
    test('returns none when no user is logged in', () async {
      when(mockAuth.currentUser).thenReturn(null);

      final role = await roleSource.getCurrentRole();

      expect(role, MarketplaceAdminRole.none);
    });

    test('returns none when no claims are present', () async {
      when(mockAuth.currentUser).thenReturn(mockUser);
      when(mockUser.getIdTokenResult(any)).thenAnswer((_) async => mockTokenResult);
      when(mockTokenResult.claims).thenReturn(null);

      final role = await roleSource.getCurrentRole();

      expect(role, MarketplaceAdminRole.none);
    });

    test('returns correct role from claims', () async {
      final scenarios = {
        'reviewer': MarketplaceAdminRole.reviewer,
        'admin': MarketplaceAdminRole.admin,
        'superAdmin': MarketplaceAdminRole.superAdmin,
        'none': MarketplaceAdminRole.none,
        'invalid': MarketplaceAdminRole.none,
      };

      for (final entry in scenarios.entries) {
        when(mockAuth.currentUser).thenReturn(mockUser);
        when(mockUser.getIdTokenResult(any)).thenAnswer((_) async => mockTokenResult);
        when(mockTokenResult.claims).thenReturn({'marketplaceAdminRole': entry.key});

        final role = await roleSource.getCurrentRole();

        expect(role, entry.value, reason: 'Failed for claim value: ${entry.key}');
      }
    });

    test('returns none on exception', () async {
      when(mockAuth.currentUser).thenReturn(mockUser);
      when(mockUser.getIdTokenResult(any)).thenThrow(Exception('Network error'));

      final role = await roleSource.getCurrentRole();

      expect(role, MarketplaceAdminRole.none);
    });
  });
}
