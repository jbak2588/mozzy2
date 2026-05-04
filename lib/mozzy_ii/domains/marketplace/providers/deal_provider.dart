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

final buyerDealsProvider = FutureProvider.autoDispose<List<DealModel>>((ref) async {
  final userId = ref.watch(currentMarketplaceUserIdProvider);
  if (userId == null) return [];
  final repo = ref.watch(dealRepositoryProvider);
  return repo.fetchBuyerDeals(userId);
});

final sellerDealsProvider = FutureProvider.autoDispose<List<DealModel>>((ref) async {
  final userId = ref.watch(currentMarketplaceUserIdProvider);
  if (userId == null) return [];
  final repo = ref.watch(dealRepositoryProvider);
  return repo.fetchSellerDeals(userId);
});

final buyerDealCodeProvider = FutureProvider.autoDispose.family<BuyerDealCodeModel?, String>((ref, dealId) async {
  final userId = ref.watch(currentMarketplaceUserIdProvider);
  if (userId == null) return null;
  final repo = ref.watch(dealRepositoryProvider);
  return repo.getBuyerDealCode(buyerId: userId, dealId: dealId);
});
