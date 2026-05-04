import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mozzy/mozzy_ii/domains/marketplace/providers/marketplace_provider.dart';
import 'package:mozzy/mozzy_ii/domains/marketplace/models/admin_role_model.dart';
import 'package:mozzy/mozzy_ii/domains/marketplace/services/in_memory_marketplace_admin_role_source.dart';
import 'package:mozzy/mozzy_ii/domains/marketplace/security/marketplace_admin_allowlist.dart';

void main() {
  group('Marketplace Admin Allowlist', () {
    test('admin UID is allowed', () {
      expect(isMarketplaceAdminUidAllowed('F1RhoJnK0uUQ1jPzvA9GuIG6U2w1'), isTrue);
    });

    test('general user UID is NOT allowed', () {
      expect(isMarketplaceAdminUidAllowed('HUZMs5mweBT2DjkS8vHQrDjKZCx2'), isFalse);
    });

    test('null UID is NOT allowed', () {
      expect(isMarketplaceAdminUidAllowed(null), isFalse);
    });

    test('empty UID is NOT allowed', () {
      expect(isMarketplaceAdminUidAllowed(''), isFalse);
    });

    test('random UID is NOT allowed', () {
      expect(isMarketplaceAdminUidAllowed('randomUID12345'), isFalse);
    });
  });

  group('Marketplace Admin Allowlist Staging Fallback Role', () {
    test('allowlisted UID returns admin', () {
      expect(
        marketplaceAdminRoleForAllowlistedUid('F1RhoJnK0uUQ1jPzvA9GuIG6U2w1'),
        MarketplaceAdminRole.admin,
      );
    });

    test('non-allowlisted UID returns none', () {
      expect(
        marketplaceAdminRoleForAllowlistedUid('HUZMs5mweBT2DjkS8vHQrDjKZCx2'),
        MarketplaceAdminRole.none,
      );
    });

    test('null UID returns none', () {
      expect(marketplaceAdminRoleForAllowlistedUid(null), MarketplaceAdminRole.none);
    });
  });

  group('Admin Role — Non-Allowlisted UID Blocked', () {
    test('non-allowlisted UID gets none even if source returns admin', () async {
      final source = InMemoryMarketplaceAdminRoleSource(
        MarketplaceAdminRole.admin,
      );
      final container = ProviderContainer(
        overrides: [
          currentMarketplaceUserIdProvider.overrideWithValue('HUZMs5mweBT2DjkS8vHQrDjKZCx2'),
          marketplaceAdminRoleSourceProvider.overrideWithValue(source),
        ],
      );
      addTearDown(container.dispose);

      // Sync provider should return none for non-allowlisted UID
      expect(container.read(marketplaceAdminRoleProvider), MarketplaceAdminRole.none);
      expect(container.read(canViewMarketplaceAdminReviewProvider), isFalse);

      // Async provider should also return none
      final asyncRole = await container.read(marketplaceAdminRoleAsyncProvider.future);
      expect(asyncRole, MarketplaceAdminRole.none);
    });

    test('null UID gets none even if source returns admin', () async {
      final source = InMemoryMarketplaceAdminRoleSource(
        MarketplaceAdminRole.admin,
      );
      final container = ProviderContainer(
        overrides: [
          currentMarketplaceUserIdProvider.overrideWithValue(null),
          marketplaceAdminRoleSourceProvider.overrideWithValue(source),
        ],
      );
      addTearDown(container.dispose);

      expect(container.read(marketplaceAdminRoleProvider), MarketplaceAdminRole.none);
      expect(container.read(canViewMarketplaceAdminReviewProvider), isFalse);
    });

    test('non-allowlisted UID blocked from admin review queue visibility', () {
      final source = InMemoryMarketplaceAdminRoleSource(
        MarketplaceAdminRole.superAdmin,
      );
      final container = ProviderContainer(
        overrides: [
          currentMarketplaceUserIdProvider.overrideWithValue('HUZMs5mweBT2DjkS8vHQrDjKZCx2'),
          marketplaceAdminRoleSourceProvider.overrideWithValue(source),
        ],
      );
      addTearDown(container.dispose);

      // Even with superAdmin source, non-allowlisted UID cannot view
      expect(container.read(canViewMarketplaceAdminReviewProvider), isFalse);
      expect(container.read(marketplaceAdminRoleProvider), MarketplaceAdminRole.none);
    });
  });

  group('Admin Role — Allowlisted UID with claims', () {
    test('allowlisted admin UID with admin source gets admin role', () async {
      final source = InMemoryMarketplaceAdminRoleSource(
        MarketplaceAdminRole.admin,
      );
      final container = ProviderContainer(
        overrides: [
          currentMarketplaceUserIdProvider.overrideWithValue('F1RhoJnK0uUQ1jPzvA9GuIG6U2w1'),
          marketplaceAdminRoleSourceProvider.overrideWithValue(source),
        ],
      );
      addTearDown(container.dispose);

      final asyncRole = await container.read(marketplaceAdminRoleAsyncProvider.future);
      expect(asyncRole, MarketplaceAdminRole.admin);

      expect(container.read(marketplaceAdminRoleProvider), MarketplaceAdminRole.admin);
      expect(container.read(canViewMarketplaceAdminReviewProvider), isTrue);
    });

    test('allowlisted admin UID with reviewer source gets reviewer role', () async {
      final source = InMemoryMarketplaceAdminRoleSource(
        MarketplaceAdminRole.reviewer,
      );
      final container = ProviderContainer(
        overrides: [
          currentMarketplaceUserIdProvider.overrideWithValue('F1RhoJnK0uUQ1jPzvA9GuIG6U2w1'),
          marketplaceAdminRoleSourceProvider.overrideWithValue(source),
        ],
      );
      addTearDown(container.dispose);

      final asyncRole = await container.read(marketplaceAdminRoleAsyncProvider.future);
      expect(asyncRole, MarketplaceAdminRole.reviewer);
      expect(container.read(canViewMarketplaceAdminReviewProvider), isTrue);
    });
  });

  group('Admin Role — Allowlisted UID staging fallback (no claims)', () {
    test('allowlisted UID with none source still gets admin via staging fallback', () async {
      // Simulates F1Rho with no custom claims set
      final source = InMemoryMarketplaceAdminRoleSource(
        MarketplaceAdminRole.none,
      );
      final container = ProviderContainer(
        overrides: [
          currentMarketplaceUserIdProvider.overrideWithValue('F1RhoJnK0uUQ1jPzvA9GuIG6U2w1'),
          marketplaceAdminRoleSourceProvider.overrideWithValue(source),
        ],
      );
      addTearDown(container.dispose);

      // Async provider returns none from source, but sync provider applies staging fallback
      final asyncRole = await container.read(marketplaceAdminRoleAsyncProvider.future);
      expect(asyncRole, MarketplaceAdminRole.none);

      // Sync provider should fall back to admin for allowlisted UID
      expect(container.read(marketplaceAdminRoleProvider), MarketplaceAdminRole.admin);
      expect(container.read(canViewMarketplaceAdminReviewProvider), isTrue);
    });

    test('allowlisted UID gets admin while async is still loading', () {
      // Before async resolves, sync provider should still show admin for allowlisted UID
      final source = InMemoryMarketplaceAdminRoleSource(
        MarketplaceAdminRole.admin,
      );
      final container = ProviderContainer(
        overrides: [
          currentMarketplaceUserIdProvider.overrideWithValue('F1RhoJnK0uUQ1jPzvA9GuIG6U2w1'),
          marketplaceAdminRoleSourceProvider.overrideWithValue(source),
        ],
      );
      addTearDown(container.dispose);

      // Don't await async - read sync provider immediately
      expect(container.read(marketplaceAdminRoleProvider), MarketplaceAdminRole.admin);
      expect(container.read(canViewMarketplaceAdminReviewProvider), isTrue);
    });

    test('non-allowlisted UID stays none even with staging fallback path', () async {
      final source = InMemoryMarketplaceAdminRoleSource(
        MarketplaceAdminRole.none,
      );
      final container = ProviderContainer(
        overrides: [
          currentMarketplaceUserIdProvider.overrideWithValue('HUZMs5mweBT2DjkS8vHQrDjKZCx2'),
          marketplaceAdminRoleSourceProvider.overrideWithValue(source),
        ],
      );
      addTearDown(container.dispose);

      final asyncRole = await container.read(marketplaceAdminRoleAsyncProvider.future);
      expect(asyncRole, MarketplaceAdminRole.none);

      expect(container.read(marketplaceAdminRoleProvider), MarketplaceAdminRole.none);
      expect(container.read(canViewMarketplaceAdminReviewProvider), isFalse);
    });
  });
}
