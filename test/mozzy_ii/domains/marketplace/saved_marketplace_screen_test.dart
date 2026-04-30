import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mozzy/mozzy_ii/domains/marketplace/screens/saved_marketplace_screen.dart';
import 'package:mozzy/mozzy_ii/domains/marketplace/providers/marketplace_provider.dart';
import 'package:mozzy/mozzy_ii/domains/marketplace/repositories/in_memory_marketplace_repository.dart';
import 'package:mozzy/mozzy_ii/domains/marketplace/models/product_model.dart';
import 'package:mozzy/mozzy_ii/geo/models/location_parts.dart';

void main() {
  Widget createTestWidget(ProviderContainer container) {
    return UncontrolledProviderScope(
      container: container,
      child: const MaterialApp(
        home: SavedMarketplaceScreen(),
      ),
    );
  }

  group('SavedMarketplaceScreen Widget Test', () {
    late InMemoryMarketplaceRepository repo;

    setUp(() {
      repo = InMemoryMarketplaceRepository();
    });

    ProductModel createSampleProduct(String id) {
      return ProductModel(
        id: id,
        userId: 'u1',
        title: 'Product $id',
        description: 'Desc $id',
        category: 'electronics',
        price: 1000,
        geoPath: 'ID#JB#BANDUNG#COBLONG',
        locationParts: LocationParts(
          countryCode: 'ID',
          idAddress: IndonesiaGeoAddress(
            provinsi: 'JB',
            kabupaten: 'BANDUNG',
            kecamatan: 'COBLONG',
            kelurahan: 'DAGO',
          ),
          latitude: 0,
          longitude: 0,
          geoHash: 'h',
        ),
        createdAt: DateTime.now().toUtc(),
      );
    }

    testWidgets('shows login required if userId is null', (tester) async {
      final container = ProviderContainer(
        overrides: [
          currentMarketplaceUserIdProvider.overrideWithValue(null),
        ],
      );

      await tester.pumpWidget(createTestWidget(container));
      await tester.pump();

      // tr() returns the key if not initialized
      expect(find.text('marketplace.loginRequired'), findsOneWidget);
    });

    testWidgets('shows empty state when no products saved', (tester) async {
      final container = ProviderContainer(
        overrides: [
          currentMarketplaceUserIdProvider.overrideWithValue('u1'),
          marketplaceRepositoryProvider.overrideWithValue(repo),
        ],
      );

      await tester.pumpWidget(createTestWidget(container));
      await tester.pumpAndSettle();

      expect(find.byKey(const Key('savedMarketplaceEmptyState')), findsOneWidget);
      expect(find.text('marketplace.noSavedItems'), findsOneWidget);
    });

    testWidgets('displays saved products', (tester) async {
      final p1 = createSampleProduct('p1');
      await repo.createProduct(p1);
      await repo.likeProduct(productId: 'p1', userId: 'u1');

      final container = ProviderContainer(
        overrides: [
          currentMarketplaceUserIdProvider.overrideWithValue('u1'),
          marketplaceRepositoryProvider.overrideWithValue(repo),
        ],
      );

      await tester.pumpWidget(createTestWidget(container));
      await tester.pumpAndSettle();

      expect(find.byKey(const Key('savedMarketplaceList')), findsOneWidget);
      expect(find.text('Product p1'), findsOneWidget);
    });
  });
}
