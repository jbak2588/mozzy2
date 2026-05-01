import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mozzy/mozzy_ii/domains/marketplace/providers/marketplace_provider.dart';
import 'package:mozzy/mozzy_ii/domains/marketplace/models/admin_role_model.dart';
import 'package:mozzy/mozzy_ii/domains/marketplace/services/in_memory_marketplace_admin_role_source.dart';

void main() {
  group('Marketplace Admin Role Providers', () {
    test('marketplaceAdminRoleProvider defaults to none when no async value', () {
      final container = ProviderContainer();
      final role = container.read(marketplaceAdminRoleProvider);
      expect(role, MarketplaceAdminRole.none);
    });

    test('marketplaceAdminRoleAsyncProvider returns role from source', () async {
      final source = InMemoryMarketplaceAdminRoleSource(MarketplaceAdminRole.reviewer);
      final container = ProviderContainer(
        overrides: [
          marketplaceAdminRoleSourceProvider.overrideWithValue(source),
        ],
      );

      final role = await container.read(marketplaceAdminRoleAsyncProvider.future);
      expect(role, MarketplaceAdminRole.reviewer);
      
      // Check sync provider update
      expect(container.read(marketplaceAdminRoleProvider), MarketplaceAdminRole.reviewer);
    });

    test('canViewMarketplaceAdminReviewProvider follows async role', () async {
      final source = InMemoryMarketplaceAdminRoleSource(MarketplaceAdminRole.reviewer);
      final container = ProviderContainer(
        overrides: [
          marketplaceAdminRoleSourceProvider.overrideWithValue(source),
        ],
      );

      // Wait for async initialization
      await container.read(marketplaceAdminRoleAsyncProvider.future);
      
      expect(container.read(canViewMarketplaceAdminReviewProvider), isTrue);

      source.setRole(MarketplaceAdminRole.none);
      container.invalidate(marketplaceAdminRoleAsyncProvider);
      await container.read(marketplaceAdminRoleAsyncProvider.future);
      
      expect(container.read(canViewMarketplaceAdminReviewProvider), isFalse);
    });
  });
}
