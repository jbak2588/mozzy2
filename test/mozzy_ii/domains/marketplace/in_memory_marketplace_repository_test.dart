import 'package:flutter_test/flutter_test.dart';
import 'package:mozzy/mozzy_ii/domains/marketplace/models/product_model.dart';
import 'package:mozzy/mozzy_ii/domains/marketplace/repositories/in_memory_marketplace_repository.dart';
import 'package:mozzy/mozzy_ii/geo/models/location_parts.dart';

void main() {
  group('InMemoryMarketplaceRepository', () {
    late InMemoryMarketplaceRepository repo;

    setUp(() {
      repo = InMemoryMarketplaceRepository();
    });

    ProductModel createSampleProduct({
      required String id,
      String category = 'electronics',
      String kecamatan = 'COBLONG',
      bool isDeleted = false,
      DateTime? createdAt,
    }) {
      return ProductModel(
        id: id,
        userId: 'u1',
        title: 'Product $id',
        description: 'Desc $id',
        category: category,
        price: 1000,
        geoPath: 'ID#JB#BANDUNG#$kecamatan',
        locationParts: LocationParts(
          countryCode: 'ID',
          idAddress: IndonesiaGeoAddress(
            provinsi: 'JB',
            kabupaten: 'BANDUNG',
            kecamatan: kecamatan,
            kelurahan: 'DAGO',
          ),
          latitude: 0,
          longitude: 0,
          geoHash: 'h',
        ),
        createdAt: createdAt ?? DateTime.now().toUtc(),
        isDeleted: isDeleted,
      );
    }

    test('createProduct and getProductById', () async {
      final product = createSampleProduct(id: 'p1');
      await repo.createProduct(product);

      final fetched = await repo.getProductById('p1');
      expect(fetched, isNotNull);
      expect(fetched?.id, 'p1');
    });

    test('fetchByCategory filters correctly and excludes deleted', () async {
      final p1 = createSampleProduct(id: 'p1', category: 'cat1');
      final p2 = createSampleProduct(id: 'p2', category: 'cat1', isDeleted: true);
      final p3 = createSampleProduct(id: 'p3', category: 'cat2');

      await repo.createProduct(p1);
      await repo.createProduct(p2);
      await repo.createProduct(p3);

      final results = await repo.fetchByCategory(category: 'cat1');
      expect(results.length, 1);
      expect(results.first.id, 'p1');
    });

    test('fetchByKecamatan filters correctly', () async {
      final p1 = createSampleProduct(id: 'p1', kecamatan: 'KEC1');
      final p2 = createSampleProduct(id: 'p2', kecamatan: 'KEC2');

      await repo.createProduct(p1);
      await repo.createProduct(p2);

      final results = await repo.fetchByKecamatan(kecamatan: 'KEC1');
      expect(results.length, 1);
      expect(results.first.id, 'p1');
    });

    test('softDeleteProduct hides product', () async {
      final p1 = createSampleProduct(id: 'p1');
      await repo.createProduct(p1);

      await repo.softDeleteProduct('p1');
      final fetched = await repo.getProductById('p1');
      expect(fetched?.isDeleted, isTrue);

      final list = await repo.fetchByCategory(category: 'electronics');
      expect(list.isEmpty, isTrue);
    });

    test('fetch results are sorted by createdAt descending', () async {
      final p1 = createSampleProduct(id: 'p1', createdAt: DateTime.utc(2026, 1, 1));
      final p2 = createSampleProduct(id: 'p2', createdAt: DateTime.utc(2026, 1, 3));
      final p3 = createSampleProduct(id: 'p3', createdAt: DateTime.utc(2026, 1, 2));

      await repo.createProduct(p1);
      await repo.createProduct(p2);
      await repo.createProduct(p3);

      final results = await repo.fetchByCategory(category: 'electronics');
      expect(results[0].id, 'p2');
      expect(results[1].id, 'p3');
      expect(results[2].id, 'p1');
    });

    test('likeProduct increments likesCount and isProductLikedByUser returns true', () async {
      final p1 = createSampleProduct(id: 'p1');
      await repo.createProduct(p1);

      await repo.likeProduct(productId: 'p1', userId: 'u1');
      
      final fetched = await repo.getProductById('p1');
      expect(fetched?.likesCount, 1);
      
      final isLiked = await repo.isProductLikedByUser(productId: 'p1', userId: 'u1');
      expect(isLiked, isTrue);
    });

    test('duplicate like does not double-increment', () async {
      final p1 = createSampleProduct(id: 'p1');
      await repo.createProduct(p1);

      await repo.likeProduct(productId: 'p1', userId: 'u1');
      await repo.likeProduct(productId: 'p1', userId: 'u1');
      
      final fetched = await repo.getProductById('p1');
      expect(fetched?.likesCount, 1);
    });

    test('unlikeProduct decrements likesCount', () async {
      final p1 = createSampleProduct(id: 'p1');
      await repo.createProduct(p1);

      await repo.likeProduct(productId: 'p1', userId: 'u1');
      await repo.unlikeProduct(productId: 'p1', userId: 'u1');
      
      final fetched = await repo.getProductById('p1');
      expect(fetched?.likesCount, 0);
      
      final isLiked = await repo.isProductLikedByUser(productId: 'p1', userId: 'u1');
      expect(isLiked, isFalse);
    });

    test('unlike below zero is prevented', () async {
      final p1 = createSampleProduct(id: 'p1');
      await repo.createProduct(p1);

      await repo.unlikeProduct(productId: 'p1', userId: 'u1');
      
      final fetched = await repo.getProductById('p1');
      expect(fetched?.likesCount, 0);
    });

    test('fetchSavedProductsByUser returns liked products and excludes deleted', () async {
      final p1 = createSampleProduct(id: 'p1');
      final p2 = createSampleProduct(id: 'p2');
      final p3 = createSampleProduct(id: 'p3');
      final p4 = createSampleProduct(id: 'p4', isDeleted: true);

      await repo.createProduct(p1);
      await repo.createProduct(p2);
      await repo.createProduct(p3);
      await repo.createProduct(p4);

      await repo.likeProduct(productId: 'p1', userId: 'u1');
      await repo.likeProduct(productId: 'p2', userId: 'u1');
      await repo.likeProduct(productId: 'p3', userId: 'u2'); // Different user
      await repo.likeProduct(productId: 'p4', userId: 'u1'); // Deleted product

      final results = await repo.fetchSavedProductsByUser(userId: 'u1');
      expect(results.length, 2);
      final ids = results.map((e) => e.id).toList();
      expect(ids, contains('p1'));
      expect(ids, contains('p2'));
      expect(ids, isNot(contains('p3')));
      expect(ids, isNot(contains('p4')));
    });

    test('fetchSavedProductsByUser sorted by likedAt descending', () async {
      final p1 = createSampleProduct(id: 'p1');
      final p2 = createSampleProduct(id: 'p2');
      final p3 = createSampleProduct(id: 'p3');

      await repo.createProduct(p1);
      await repo.createProduct(p2);
      await repo.createProduct(p3);

      await repo.likeProduct(productId: 'p1', userId: 'u1');
      // No delay needed for InMemory if we use distinct timestamps, 
      // but let's be safe. In our impl, it uses DateTime.now().
      await Future.delayed(const Duration(milliseconds: 10));
      await repo.likeProduct(productId: 'p2', userId: 'u1');
      await Future.delayed(const Duration(milliseconds: 10));
      await repo.likeProduct(productId: 'p3', userId: 'u1');

      final results = await repo.fetchSavedProductsByUser(userId: 'u1');
      expect(results[0].id, 'p3');
      expect(results[1].id, 'p2');
      expect(results[2].id, 'p1');
    });
  });
}
