import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:easy_localization/easy_localization.dart';
import '../../../core/config/integration_test_config.dart';
import '../providers/marketplace_provider.dart';
import '../widgets/marketplace_product_card.dart';

class SavedMarketplaceScreen extends ConsumerWidget {
  const SavedMarketplaceScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userId = ref.watch(currentMarketplaceUserIdProvider);

    return Scaffold(
      key: const Key('savedMarketplaceScreen'),
      appBar: AppBar(title: Text('marketplace.savedItems'.tr())),
      body: userId == null
          ? _buildLoginRequired()
          : _buildSavedList(ref, userId),
    );
  }

  Widget _buildLoginRequired() {
    return Center(child: Text('marketplace.loginRequired'.tr()));
  }

  Widget _buildSavedList(WidgetRef ref, String userId) {
    final savedProductsAsync = ref.watch(
      savedMarketplaceProductsProvider(userId),
    );

    return savedProductsAsync.when(
      data: (products) {
        if (products.isEmpty) {
          return Center(
            key: const Key('savedMarketplaceEmptyState'),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'marketplace.noSavedItems'.tr(),
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                Text('marketplace.noSavedItemsDescription'.tr()),
              ],
            ),
          );
        }

        return GridView.builder(
          key: const Key('savedMarketplaceList'),
          padding: const EdgeInsets.all(16),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 0.7,
            crossAxisSpacing: 16,
            mainAxisSpacing: 16,
          ),
          itemCount: products.length,
          itemBuilder: (context, index) {
            final product = products[index];
            return MarketplaceProductCard(product: product);
          },
        );
      },
      loading: () => Center(
        child: IntegrationTestConfig.enabled
            ? const Text('Loading Saved Items...')
            : const CircularProgressIndicator(),
      ),
      error: (err, stack) => Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('marketplace.savedItemsLoadFailed'.tr()),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () =>
                  ref.invalidate(savedMarketplaceProductsProvider(userId)),
              child: Text('common.retry'.tr()),
            ),
          ],
        ),
      ),
    );
  }
}
