import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter/foundation.dart';
import '../../../core/config/integration_test_config.dart';
import '../../../geo/models/location_parts.dart';
import '../providers/marketplace_provider.dart';
import '../providers/marketplace_location_provider.dart';
import '../widgets/marketplace_product_card.dart';

class MarketplaceListScreen extends ConsumerStatefulWidget {
  const MarketplaceListScreen({super.key});

  @override
  ConsumerState<MarketplaceListScreen> createState() =>
      _MarketplaceListScreenState();
}

class _MarketplaceListScreenState extends ConsumerState<MarketplaceListScreen> {
  String _selectedCategory = 'all';

  @override
  Widget build(BuildContext context) {
    final locationState = ref.watch(effectiveMarketplaceLocationProvider);

    return Scaffold(
      key: const Key('marketplaceListScreen'),
      appBar: AppBar(
        title: Text('marketplace.title'.tr()),
        actions: [
          IconButton(
            key: const Key('marketplaceSavedButton'),
            icon: const Icon(Icons.bookmark_border),
            tooltip: 'marketplace.savedItems'.tr(),
            onPressed: () => context.push('/marketplace/saved'),
          ),
          if (ref.watch(canViewMarketplaceAdminReviewProvider)) ...[
            IconButton(
              key: const Key('marketplaceAdminReviewButton'),
              icon: const Icon(Icons.admin_panel_settings_outlined),
              tooltip: 'marketplace.adminReview'.tr(),
              onPressed: () => context.push('/marketplace/admin-review'),
            ),
            IconButton(
              key: const Key('marketplaceAdminAuditLogButton'),
              icon: const Icon(Icons.history_outlined),
              tooltip: 'marketplace.adminAuditLog'.tr(),
              onPressed: () => context.push('/marketplace/admin-audit-logs'),
            ),
          ],
        ],
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(100),
          child: Column(
            children: [
              _buildLocationHeader(locationState),
              _buildCategoryChips(),
            ],
          ),
        ),
      ),
      body: _buildBody(locationState),
      floatingActionButton: FloatingActionButton(
        key: const Key('marketplaceCreateFab'),
        onPressed: () async {
          await context.push('/marketplace/create');
          // Refresh lists after returning from create screen
          ref.invalidate(productsByKecamatanProvider);
          ref.invalidate(productsByCategoryProvider);
        },
        child: const Icon(Icons.add),
      ),
    );
  }

  Widget _buildLocationHeader(AsyncValue<LocationParts> locationState) {
    return locationState.when(
      data: (loc) {
        final kecamatan =
            loc.idAddress?.kecamatan ?? 'marketplace.locationUnavailable'.tr();
        final kabupaten = loc.idAddress?.kabupaten ?? '';
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
          child: Row(
            children: [
              const Icon(Icons.location_on, size: 16, color: Colors.red),
              const SizedBox(width: 4),
              Expanded(
                child: Text(
                  '$kecamatan, $kabupaten',
                  style: const TextStyle(fontWeight: FontWeight.bold),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
        );
      },
      loading: () => const SizedBox.shrink(),
      error: (err, stack) => const SizedBox.shrink(),
    );
  }

  Widget _buildCategoryChips() {
    final categories = [
      'all',
      'electronics',
      'fashion',
      'home',
      'baby',
      'sports',
      'vehicles',
      'books',
      'other',
    ];

    return SizedBox(
      height: 50,
      child: ListView.separated(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        scrollDirection: Axis.horizontal,
        itemCount: categories.length,
        separatorBuilder: (_, index) => const SizedBox(width: 8),
        itemBuilder: (context, index) {
          final cat = categories[index];
          final isSelected = _selectedCategory == cat;
          final label = cat == 'all'
              ? 'marketplace.all'.tr()
              : 'marketplace.category.$cat'.tr();

          return ChoiceChip(
            label: Text(label),
            selected: isSelected,
            onSelected: (selected) {
              if (selected) {
                setState(() => _selectedCategory = cat);
              }
            },
          );
        },
      ),
    );
  }

  Widget _buildBody(AsyncValue<LocationParts> locationState) {
    if (_selectedCategory == 'all') {
      return locationState.when(
        data: (loc) {
          final kecamatan = loc.idAddress?.kecamatan ?? 'Kebayoran Baru';
          if (kDebugMode) {
            debugPrint('[MarketplaceList] effective location loaded: $kecamatan');
          }
          final productsAsync = ref.watch(
            productsByKecamatanProvider(kecamatan),
          );
          return _buildProductGrid(productsAsync);
        },
        loading: () => Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const CircularProgressIndicator(),
              const SizedBox(height: 16),
              Text(
                IntegrationTestConfig.enabled
                    ? 'Loading Location...'
                    : 'marketplace.detectingLocation'.tr(),
              ),
            ],
          ),
        ),
        error: (err, stack) => Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.error_outline, size: 48, color: Colors.red),
              const SizedBox(height: 16),
              Text('common.error'.tr()),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: () => ref.invalidate(effectiveMarketplaceLocationProvider),
                child: Text('marketplace.retry'.tr()),
              ),
            ],
          ),
        ),
      );
    } else {
      final productsAsync = ref.watch(
        productsByCategoryProvider(_selectedCategory),
      );
      return _buildProductGrid(productsAsync);
    }
  }

  Widget _buildProductGrid(AsyncValue<List<dynamic>> productsAsync) {
    return productsAsync.when(
      data: (products) {
        if (products.isEmpty) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'marketplace.emptyTitle'.tr(),
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                Text('marketplace.emptyDescription'.tr()),
              ],
            ),
          );
        }

        return GridView.builder(
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
            ? const Text('Loading Products...')
            : const CircularProgressIndicator(),
      ),
      error: (err, stack) => Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('common.error'.tr()),
            ElevatedButton(
              onPressed: () => ref.invalidate(marketplaceRepositoryProvider),
              child: Text('marketplace.retry'.tr()),
            ),
          ],
        ),
      ),
    );
  }
}
