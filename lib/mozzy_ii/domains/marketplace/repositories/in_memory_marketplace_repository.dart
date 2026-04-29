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
}
