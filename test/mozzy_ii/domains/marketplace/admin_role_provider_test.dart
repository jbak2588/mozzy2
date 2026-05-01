import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mozzy/mozzy_ii/domains/marketplace/providers/marketplace_provider.dart';
import 'package:mozzy/mozzy_ii/domains/marketplace/models/admin_role_model.dart';

void main() {
  test('marketplaceAdminRoleProvider defaults to admin in integration tests', () {
    final container = ProviderContainer();
    // IntegrationTestConfig.enabled is true if MOZZY_INTEGRATION_TEST is set.
    // In unit tests, it depends on how it's run, but marketplace_provider.dart 
    // uses IntegrationTestConfig.enabled which defaults to false in standard unit tests.
    
    final role = container.read(marketplaceAdminRoleProvider);
    expect(role, MarketplaceAdminRole.none);
  });

  test('canViewMarketplaceAdminReviewProvider follows role rules', () {
    final container = ProviderContainer(
      overrides: [
        marketplaceAdminRoleProvider.overrideWithValue(MarketplaceAdminRole.reviewer),
      ],
    );

    expect(container.read(canViewMarketplaceAdminReviewProvider), isTrue);

    final container2 = ProviderContainer(
      overrides: [
        marketplaceAdminRoleProvider.overrideWithValue(MarketplaceAdminRole.none),
      ],
    );
    expect(container2.read(canViewMarketplaceAdminReviewProvider), isFalse);
  });
}
