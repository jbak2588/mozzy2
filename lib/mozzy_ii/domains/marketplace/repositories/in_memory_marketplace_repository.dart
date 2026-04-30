import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/product_model.dart';
import 'marketplace_repository.dart';

class InMemoryMarketplaceRepository implements MarketplaceRepository {
  final Map<String, ProductModel> _products = {};

  @override
  String productsCollectionPath([String? country]) {
    return 'countries/ID/domains/marketplace/products';
  }

  @override
  CollectionReference get productsCollection => throw UnimplementedError('InMemory: no collection ref');

  @override
  Future<String> createProduct(ProductModel product) async {
    _products[product.id] = product;
    return product.id;
  }

  @override
  Future<ProductModel?> getProductById(String productId) async {
    return _products[productId];
  }

  @override
  Future<List<ProductModel>> fetchByKecamatan({
    required String kecamatan,
    int limit = 20,
    DocumentSnapshot? startAfter,
  }) async {
    final list = _products.values
        .where((p) => !p.isDeleted && p.locationParts?.idAddress?.kecamatan == kecamatan)
        .toList();
    list.sort((a, b) => b.createdAt.compareTo(a.createdAt));
    return list.take(limit).toList();
  }

  @override
  Future<List<ProductModel>> fetchByCategory({
    required String category,
    int limit = 20,
    DocumentSnapshot? startAfter,
  }) async {
    final list = _products.values
        .where((p) => !p.isDeleted && p.category == category)
        .toList();
    list.sort((a, b) => b.createdAt.compareTo(a.createdAt));
    return list.take(limit).toList();
  }

  @override
  Future<void> updateProduct(ProductModel product) async {
    _products[product.id] = product;
  }

  @override
  Future<void> softDeleteProduct(String productId) async {
    final p = _products[productId];
    if (p != null) {
      _products[productId] = p.copyWith(
        isDeleted: true,
        updatedAt: DateTime.now().toUtc(),
      );
    }
  }

  final Map<String, Map<String, DateTime>> _productLikes = {}; // productId -> {userId: likedAt}

  @override
  Future<bool> isProductLikedByUser({
    required String productId,
    required String userId,
  }) async {
    return _productLikes[productId]?.containsKey(userId) ?? false;
  }

  @override
  Future<void> likeProduct({
    required String productId,
    required String userId,
  }) async {
    final likes = _productLikes.putIfAbsent(productId, () => {});
    if (likes.containsKey(userId)) return;

    likes[userId] = DateTime.now().toUtc();
    final p = _products[productId];
    if (p != null) {
      _products[productId] = p.copyWith(likesCount: p.likesCount + 1);
    }
  }

  @override
  Future<void> unlikeProduct({
    required String productId,
    required String userId,
  }) async {
    final likes = _productLikes[productId];
    if (likes == null || !likes.containsKey(userId)) return;

    likes.remove(userId);
    final p = _products[productId];
    if (p != null) {
      final newCount = (p.likesCount > 0) ? p.likesCount - 1 : 0;
      _products[productId] = p.copyWith(likesCount: newCount);
    }
  }

  @override
  Future<List<ProductModel>> fetchSavedProductsByUser({
    required String userId,
    int limit = 50,
  }) async {
    final List<MapEntry<String, DateTime>> userLikes = [];
    
    for (final entry in _productLikes.entries) {
      final productId = entry.key;
      final likes = entry.value;
      if (likes.containsKey(userId)) {
        userLikes.add(MapEntry(productId, likes[userId]!));
      }
    }

    // Sort by likedAt descending
    userLikes.sort((a, b) => b.value.compareTo(a.value));

    final List<ProductModel> products = [];
    for (final entry in userLikes.take(limit)) {
      final p = _products[entry.key];
      if (p != null && !p.isDeleted) {
        products.add(p);
      }
    }
    return products;
  }
}
