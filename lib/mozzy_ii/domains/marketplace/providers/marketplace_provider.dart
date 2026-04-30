import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/config/integration_test_config.dart';
import '../repositories/marketplace_repository.dart';
import '../repositories/in_memory_marketplace_repository.dart';
import '../models/product_model.dart';
import '../services/marketplace_image_upload_service.dart';
import '../services/in_memory_marketplace_image_upload_service.dart';
import '../services/marketplace_image_optimization_service.dart';
import '../services/in_memory_marketplace_image_optimization_service.dart';

final currentMarketplaceUserIdProvider = Provider<String?>((ref) {
  if (IntegrationTestConfig.enabled) {
    return IntegrationTestConfig.testUserId;
  }
  // This will throw if not logged in. The UI should prevent this.
  return FirebaseAuth.instance.currentUser?.uid;
});

final _integrationMarketplaceRepository = InMemoryMarketplaceRepository();
final _integrationImageUploadService = InMemoryMarketplaceImageUploadService();
final _integrationImageOptimizationService = InMemoryMarketplaceImageOptimizationService();

final marketplaceRepositoryProvider = Provider<MarketplaceRepository>((ref) {
  if (IntegrationTestConfig.enabled) {
    return _integrationMarketplaceRepository;
  }
  return MarketplaceRepository();
});

final marketplaceImageUploadServiceProvider = Provider<MarketplaceImageUploadService>((ref) {
  if (IntegrationTestConfig.enabled) {
    return _integrationImageUploadService;
  }
  return MarketplaceImageUploadService();
});

final marketplaceImageOptimizationServiceProvider = Provider<MarketplaceImageOptimizationService>((ref) {
  if (IntegrationTestConfig.enabled) {
    return _integrationImageOptimizationService;
  }
  return MarketplaceImageOptimizationServiceImpl();
});

final productsByKecamatanProvider = FutureProvider.family
    .autoDispose<List<ProductModel>, String>((ref, kecamatan) async {
      final repo = ref.read(marketplaceRepositoryProvider);
      return repo.fetchByKecamatan(kecamatan: kecamatan);
    });

final productsByCategoryProvider = FutureProvider.family
    .autoDispose<List<ProductModel>, String>((ref, category) async {
      final repo = ref.read(marketplaceRepositoryProvider);
      return repo.fetchByCategory(category: category);
    });

class CreateProductAction {
  final MarketplaceRepository _repo;
  CreateProductAction(this._repo);

  Future<String> call(ProductModel product) => _repo.createProduct(product);
}

final createProductProvider = Provider<CreateProductAction>((ref) {
  return CreateProductAction(ref.read(marketplaceRepositoryProvider));
});

final productByIdProvider = FutureProvider.family.autoDispose<ProductModel?, String>((ref, productId) {
  final repo = ref.read(marketplaceRepositoryProvider);
  return repo.getProductById(productId);
});
