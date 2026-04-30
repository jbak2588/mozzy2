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
import '../services/marketplace_ai_verification_service.dart';
import '../services/gemini_marketplace_ai_verification_service.dart';
import '../services/in_memory_marketplace_ai_verification_service.dart';

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
final _integrationAiVerificationService = InMemoryMarketplaceAiVerificationService();

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

final marketplaceAiVerificationServiceProvider = Provider<MarketplaceAiVerificationService>((ref) {
  if (IntegrationTestConfig.enabled) {
    return _integrationAiVerificationService;
  }
  return GeminiMarketplaceAiVerificationService();
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

final savedMarketplaceProductsProvider = FutureProvider.family
    .autoDispose<List<ProductModel>, String>((ref, userId) async {
  final repo = ref.read(marketplaceRepositoryProvider);
  return repo.fetchSavedProductsByUser(userId: userId);
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

class ProductLikeQuery {
  final String productId;
  final String userId;
  const ProductLikeQuery({required this.productId, required this.userId});

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ProductLikeQuery &&
          runtimeType == other.runtimeType &&
          productId == other.productId &&
          userId == other.userId;

  @override
  int get hashCode => productId.hashCode ^ userId.hashCode;
}

final productLikedByUserProvider =
    FutureProvider.family.autoDispose<bool, ProductLikeQuery>((ref, query) {
  final repo = ref.read(marketplaceRepositoryProvider);
  return repo.isProductLikedByUser(
    productId: query.productId,
    userId: query.userId,
  );
});

class ToggleProductLikeAction {
  final MarketplaceRepository _repo;
  final Ref _ref;
  ToggleProductLikeAction(this._repo, this._ref);

  Future<void> call({
    required String productId,
    required String userId,
    required bool currentlyLiked,
  }) async {
    if (currentlyLiked) {
      await _repo.unlikeProduct(productId: productId, userId: userId);
    } else {
      await _repo.likeProduct(productId: productId, userId: userId);
    }

    // Invalidate providers to refresh UI
    _ref.invalidate(productByIdProvider(productId));
    _ref.invalidate(productLikedByUserProvider(ProductLikeQuery(productId: productId, userId: userId)));
  }
}

final toggleProductLikeProvider = Provider<ToggleProductLikeAction>((ref) {
  return ToggleProductLikeAction(ref.read(marketplaceRepositoryProvider), ref);
});
