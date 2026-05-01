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
import '../repositories/ai_verification_report_repository.dart';
import '../repositories/in_memory_ai_verification_report_repository.dart';
import '../models/ai_verification_report_model.dart';
import '../models/ai_review_queue_item_model.dart';
import '../models/admin_role_model.dart';

final currentMarketplaceUserIdProvider = Provider<String?>((ref) {
  if (IntegrationTestConfig.enabled) {
    return IntegrationTestConfig.testUserId;
  }
  // This will throw if not logged in. The UI should prevent this.
  return FirebaseAuth.instance.currentUser?.uid;
});

final marketplaceAdminRoleProvider = Provider<MarketplaceAdminRole>((ref) {
  if (IntegrationTestConfig.enabled) {
    return MarketplaceAdminRole.admin;
  }

  // Foundation only:
  // In production/release, default to none until server-side role source is added.
  return MarketplaceAdminRole.none;
});

final canViewMarketplaceAdminReviewProvider = Provider<bool>((ref) {
  final role = ref.watch(marketplaceAdminRoleProvider);
  return role.canViewReviewQueue;
});

final _integrationMarketplaceRepository = InMemoryMarketplaceRepository();
final _integrationImageUploadService = InMemoryMarketplaceImageUploadService();
final _integrationImageOptimizationService = InMemoryMarketplaceImageOptimizationService();
final _integrationAiVerificationService = InMemoryMarketplaceAiVerificationService();
final _integrationAiVerificationReportRepository = InMemoryAiVerificationReportRepository();

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

final aiVerificationReportRepositoryProvider = Provider<AiVerificationReportRepository>((ref) {
  if (IntegrationTestConfig.enabled) {
    return _integrationAiVerificationReportRepository;
  }
  return AiVerificationReportRepository();
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

final aiReportsByProductProvider =
    FutureProvider.family.autoDispose<List<AiVerificationReportModel>, String>(
  (ref, productId) {
    final repo = ref.read(aiVerificationReportRepositoryProvider);
    return repo.fetchReportsByProduct(productId);
  },
);

final aiReviewQueueProvider =
    FutureProvider.autoDispose<List<AiReviewQueueItemModel>>((ref) {
  final repo = ref.read(aiVerificationReportRepositoryProvider);
  return repo.fetchOpenReviewQueue(limit: 50);
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
    _ref.invalidate(savedMarketplaceProductsProvider(userId));
  }
}

final toggleProductLikeProvider = Provider<ToggleProductLikeAction>((ref) {
  return ToggleProductLikeAction(ref.read(marketplaceRepositoryProvider), ref);
});

class AdminReviewActionController {
  final AiVerificationReportRepository _aiRepo;
  final MarketplaceRepository _marketRepo;
  final Ref _ref;

  AdminReviewActionController(this._aiRepo, this._marketRepo, this._ref);

  Future<void> approve(String itemId, String productId) async {
    final role = _ref.read(marketplaceAdminRoleProvider);
    if (!role.canModerate) throw Exception('Unauthorized');

    final reviewerId = _ref.read(currentMarketplaceUserIdProvider) ?? 'unknown_admin';

    await _aiRepo.resolveReviewItem(
      itemId: itemId,
      reviewerId: reviewerId,
      decision: 'approved',
    );

    await _marketRepo.updateProductAiStatus(
      productId: productId,
      isVerified: true,
      status: 'passed',
    );

    _ref.invalidate(aiReviewQueueProvider);
    _ref.invalidate(productByIdProvider(productId));
  }

  Future<void> reject(String itemId, String productId, {String? note}) async {
    final role = _ref.read(marketplaceAdminRoleProvider);
    if (!role.canModerate) throw Exception('Unauthorized');

    final reviewerId = _ref.read(currentMarketplaceUserIdProvider) ?? 'unknown_admin';

    await _aiRepo.resolveReviewItem(
      itemId: itemId,
      reviewerId: reviewerId,
      decision: 'rejected',
      note: note,
    );

    await _marketRepo.updateProductAiStatus(
      productId: productId,
      isVerified: false,
      status: 'failed',
    );

    _ref.invalidate(aiReviewQueueProvider);
    _ref.invalidate(productByIdProvider(productId));
  }

  Future<void> dismiss(String itemId) async {
    final role = _ref.read(marketplaceAdminRoleProvider);
    if (!role.canModerate) throw Exception('Unauthorized');

    final reviewerId = _ref.read(currentMarketplaceUserIdProvider) ?? 'unknown_admin';

    await _aiRepo.resolveReviewItem(
      itemId: itemId,
      reviewerId: reviewerId,
      decision: 'dismissed',
    );

    _ref.invalidate(aiReviewQueueProvider);
  }
}

final adminReviewActionControllerProvider = Provider<AdminReviewActionController>((ref) {
  return AdminReviewActionController(
    ref.read(aiVerificationReportRepositoryProvider),
    ref.read(marketplaceRepositoryProvider),
    ref,
  );
});
