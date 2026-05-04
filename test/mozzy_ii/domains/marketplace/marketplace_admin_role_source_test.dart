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

    test('returns none for non-allowlisted UID', () async {
      when(mockAuth.currentUser).thenReturn(mockUser);
      when(mockUser.uid).thenReturn('HUZMs5mweBT2DjkS8vHQrDjKZCx2');

      final role = await roleSource.getCurrentRole();

      expect(role, MarketplaceAdminRole.none);
    });

    test('returns staging fallback admin when no claims are present for allowlisted UID', () async {
      when(mockAuth.currentUser).thenReturn(mockUser);
      when(mockUser.uid).thenReturn('F1RhoJnK0uUQ1jPzvA9GuIG6U2w1');
      when(
        mockUser.getIdTokenResult(any),
      ).thenAnswer((_) async => mockTokenResult);
      when(mockTokenResult.claims).thenReturn(null);

      final role = await roleSource.getCurrentRole();

      // Staging fallback: allowlisted UID gets admin even without claims
      expect(role, MarketplaceAdminRole.admin);
    });

    test('returns correct role from valid claims for allowlisted UID', () async {
      // These claims should return their respective roles (not fallback)
      final claimScenarios = {
        'reviewer': MarketplaceAdminRole.reviewer,
        'admin': MarketplaceAdminRole.admin,
        'superAdmin': MarketplaceAdminRole.superAdmin,
      };

      for (final entry in claimScenarios.entries) {
        when(mockAuth.currentUser).thenReturn(mockUser);
        when(mockUser.uid).thenReturn('F1RhoJnK0uUQ1jPzvA9GuIG6U2w1');
        when(
          mockUser.getIdTokenResult(any),
        ).thenAnswer((_) async => mockTokenResult);
        when(
          mockTokenResult.claims,
        ).thenReturn({'marketplaceAdminRole': entry.key});

        final role = await roleSource.getCurrentRole();

        expect(
          role,
          entry.value,
          reason: 'Failed for claim value: ${entry.key}',
        );
      }
    });

    test('returns staging fallback admin for none/invalid claim on allowlisted UID', () async {
      // These claims map to none, so staging fallback kicks in
      final fallbackScenarios = ['none', 'invalid', ''];

      for (final claimValue in fallbackScenarios) {
        when(mockAuth.currentUser).thenReturn(mockUser);
        when(mockUser.uid).thenReturn('F1RhoJnK0uUQ1jPzvA9GuIG6U2w1');
        when(
          mockUser.getIdTokenResult(any),
        ).thenAnswer((_) async => mockTokenResult);
        when(
          mockTokenResult.claims,
        ).thenReturn({'marketplaceAdminRole': claimValue});

        final role = await roleSource.getCurrentRole();

        expect(
          role,
          MarketplaceAdminRole.admin,
          reason: 'Staging fallback should return admin for allowlisted UID with claim: "$claimValue"',
        );
      }
    });

    test('returns staging fallback admin on token refresh exception for allowlisted UID', () async {
      when(mockAuth.currentUser).thenReturn(mockUser);
      when(mockUser.uid).thenReturn('F1RhoJnK0uUQ1jPzvA9GuIG6U2w1');
      when(
        mockUser.getIdTokenResult(any),
      ).thenThrow(Exception('Network error'));

      final role = await roleSource.getCurrentRole();

      // Staging fallback: even on error, allowlisted UID gets admin
      expect(role, MarketplaceAdminRole.admin);
    });
  });
}
