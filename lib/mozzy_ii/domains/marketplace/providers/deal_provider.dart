import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../repositories/deal_repository.dart';
import '../repositories/in_memory_deal_repository.dart';
import '../models/deal_model.dart';
import '../models/buyer_deal_code_model.dart';
import '../../../core/config/integration_test_config.dart';
import 'marketplace_provider.dart';

final dealRepositoryProvider = Provider<DealRepository>((ref) {
  if (IntegrationTestConfig.enabled) {
    return InMemoryDealRepository();
  }
  return DealRepository();
});

final dealByIdProvider = StreamProvider.autoDispose.family<DealModel?, String>((ref, dealId) {
  final repo = ref.watch(dealRepositoryProvider);
  return repo.watchDealById(dealId);
});

final buyerDealsProvider = StreamProvider.autoDispose<List<DealModel>>((ref) {
  final userId = ref.watch(currentMarketplaceUserIdProvider);
  if (userId == null) return Stream.value([]);
  final repo = ref.watch(dealRepositoryProvider);
  return repo.watchBuyerDeals(userId);
});

final activeDealForProductProvider = Provider.autoDispose.family<AsyncValue<DealModel?>, String>((ref, productId) {
  return ref.watch(buyerDealsProvider).whenData((deals) {
    try {
      return deals.firstWhere((d) => d.productId == productId && d.status == 'confirmed');
    } catch (_) {
      return null;
    }
  });
});

final sellerDealsProvider = StreamProvider.autoDispose<List<DealModel>>((ref) {
  final userId = ref.watch(currentMarketplaceUserIdProvider);
  if (userId == null) return Stream.value([]);
  final repo = ref.watch(dealRepositoryProvider);
  return repo.watchSellerDeals(userId);
});

final buyerDealCodeProvider = FutureProvider.autoDispose.family<BuyerDealCodeModel?, String>((ref, dealId) async {
  final userId = ref.watch(currentMarketplaceUserIdProvider);
  if (userId == null) return null;
  final repo = ref.watch(dealRepositoryProvider);
  return repo.getBuyerDealCode(buyerId: userId, dealId: dealId);
});
