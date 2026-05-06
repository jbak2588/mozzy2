import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/deal_model.dart';
import '../models/product_model.dart';
import '../models/buyer_deal_code_model.dart';
import 'deal_repository.dart';
import 'marketplace_repository.dart';

class InMemoryDealRepository implements DealRepository {
  final MarketplaceRepository? _marketplaceRepo;
  final List<DealModel> _deals = [];
  final List<BuyerDealCodeModel> _codes = [];

  InMemoryDealRepository([this._marketplaceRepo]);

  @override
  String dealsCollectionPath([String? country]) => 'countries/ID/domains/marketplace/deals';

  @override
  String buyerPrivateCodePath(String buyerId) => 'users/$buyerId/private_deal_codes';

  @override
  CollectionReference get dealsCollection => throw UnimplementedError('InMemory: no collection ref');

  @override
  Stream<DealModel?> watchDealById(String dealId) {
    // Simple in-memory stream: just the current value (doesn't push updates)
    return Stream.fromIterable([
      _deals.firstWhere((d) => d.id == dealId, orElse: () => throw Exception('Not found'))
    ]).handleError((_) => null);
  }

  @override
  Stream<List<DealModel>> watchBuyerDeals(String buyerId) {
    return Stream.fromIterable([_deals.where((d) => d.buyerId == buyerId).toList()]);
  }

  @override
  Stream<List<DealModel>> watchSellerDeals(String sellerId) {
    return Stream.fromIterable([_deals.where((d) => d.sellerId == sellerId).toList()]);
  }

  @override
  Future<DealModel> createCodDeal({
    required ProductModel product,
    required String buyerId,
  }) async {
    if (buyerId == product.sellerId) {
      throw Exception('Cannot buy your own product');
    }
    if (product.aiVerificationStatus != 'passed' || product.isAiVerified != true) {
      throw Exception('Product is not eligible for COD due to AI status');
    }
    if (product.isDeleted || product.status != ProductStatus.available) {
      throw Exception('Product is no longer available');
    }

    final dealId = 'deal_${DateTime.now().millisecondsSinceEpoch}';
    
    final deal = DealModel(
      id: dealId,
      productId: product.id,
      productTitle: product.title,
      buyerId: buyerId,
      sellerId: product.userId,
      amount: product.price,
      currencyCode: 'IDR',
      method: 'cod',
      status: 'confirmed',
      confirmationCodeHash: 'hash',
      confirmationCodeMasked: 'A****Z',
      codeExpiresAt: DateTime.now().add(const Duration(days: 3)),
      codeAttemptCount: 0,
      maxCodeAttempts: 5,
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
    );

    _deals.add(deal);

    // Update product status to reserved if repo is available
    if (_marketplaceRepo != null) {
      await _marketplaceRepo.updateProductStatus(
        productId: product.id,
        status: ProductStatus.reserved,
      );
    }

    final code = BuyerDealCodeModel(
      dealId: dealId,
      buyerId: buyerId,
      sellerId: product.userId,
      productId: product.id,
      confirmationCode: 'ABC123',
      codeExpiresAt: deal.codeExpiresAt,
      createdAt: deal.createdAt,
    );
    _codes.add(code);

    return deal;
  }

  @override
  Future<DealModel> verifySellerConfirmationCode({
    required String dealId,
    required String sellerId,
    required String inputCode,
  }) async {
    final dealIndex = _deals.indexWhere((d) => d.id == dealId && d.sellerId == sellerId);
    if (dealIndex == -1) throw Exception('Deal not found or unauthorized');

    final deal = _deals[dealIndex];
    if (deal.status != 'confirmed') {
      throw Exception('Deal is not in a verifiable state: ${deal.status}');
    }

    if (inputCode == 'ABC123') {
      final updated = deal.copyWith(
        status: 'completed',
        updatedAt: DateTime.now(),
      );
      _deals[dealIndex] = updated;

      if (_marketplaceRepo != null) {
        await _marketplaceRepo.updateProductStatus(
          productId: deal.productId,
          status: ProductStatus.sold,
        );
      }

      return updated;
    } else {
      final newCount = deal.codeAttemptCount + 1;
      final updated = deal.copyWith(
        codeAttemptCount: newCount,
        status: newCount >= deal.maxCodeAttempts ? 'code_locked' : deal.status,
        updatedAt: DateTime.now(),
      );
      _deals[dealIndex] = updated;
      throw Exception('Invalid confirmation code');
    }
  }

  @override
  Future<List<DealModel>> fetchBuyerDeals(String buyerId) async {
    return _deals.where((d) => d.buyerId == buyerId).toList();
  }

  @override
  Future<List<DealModel>> fetchSellerDeals(String sellerId) async {
    return _deals.where((d) => d.sellerId == sellerId).toList();
  }

  @override
  Future<DealModel?> getDealById(String dealId) async {
    try {
      return _deals.firstWhere((d) => d.id == dealId);
    } catch (e) {
      return null;
    }
  }

  @override
  Future<BuyerDealCodeModel?> getBuyerDealCode({
    required String buyerId,
    required String dealId,
  }) async {
    try {
      return _codes.firstWhere((c) => c.dealId == dealId && c.buyerId == buyerId);
    } catch (e) {
      return null;
    }
  }
}
