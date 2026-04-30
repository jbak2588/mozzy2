import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:go_router/go_router.dart';
import '../../../geo/providers/location_provider.dart';
import '../../../geo/models/location_parts.dart';
import '../providers/marketplace_provider.dart';
import '../widgets/marketplace_product_card.dart';

class MarketplaceListScreen extends ConsumerStatefulWidget {
  const MarketplaceListScreen({super.key});

  @override
  ConsumerState<MarketplaceListScreen> createState() => _MarketplaceListScreenState();
}

class _MarketplaceListScreenState extends ConsumerState<MarketplaceListScreen> {
  String _selectedCategory = 'all';

  @override
  Widget build(BuildContext context) {
    final locationState = ref.watch(locationProvider);

    return Scaffold(
      key: const Key('marketplaceListScreen'),
      appBar: AppBar(
        title: Text('marketplace.title'.tr()),
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
        onPressed: () => context.push('/marketplace/create'),
        child: const Icon(Icons.add),
      ),
    );
  }

  Widget _buildLocationHeader(AsyncValue<LocationParts?> locationState) {
    return locationState.when(
      data: (loc) {
        final kecamatan = loc?.idAddress?.kecamatan ?? 'marketplace.locationUnavailable'.tr();
        final kabupaten = loc?.idAddress?.kabupaten ?? '';
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
          child: Row(
            children: [
              const Icon(Icons.location_on, size: 16, color: Colors.red),
              const SizedBox(width: 4),
              Text(
                '$kecamatan, $kabupaten',
                style: const TextStyle(fontWeight: FontWeight.bold),
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
          final label = cat == 'all' ? 'marketplace.all'.tr() : 'marketplace.category.$cat'.tr();

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

  Widget _buildBody(AsyncValue<LocationParts?> locationState) {
    if (_selectedCategory == 'all') {
      return locationState.when(
        data: (loc) {
          final kecamatan = loc?.idAddress?.kecamatan;
          if (kecamatan == null) {
            return Center(child: Text('marketplace.locationUnavailable'.tr()));
          }
          final productsAsync = ref.watch(productsByKecamatanProvider(kecamatan));
          return _buildProductGrid(productsAsync);
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (err, stack) => Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('common.error'.tr()),
              ElevatedButton(
                onPressed: () => ref.invalidate(locationProvider),
                child: Text('marketplace.retry'.tr()),
              ),
            ],
          ),
        ),
      );
    } else {
      final productsAsync = ref.watch(productsByCategoryProvider(_selectedCategory));
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
                  style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
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
      loading: () => const Center(child: CircularProgressIndicator()),
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
