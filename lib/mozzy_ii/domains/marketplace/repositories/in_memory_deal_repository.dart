import '../models/deal_model.dart';
import '../models/product_model.dart';
import '../models/buyer_deal_code_model.dart';
import 'deal_repository.dart';

class InMemoryDealRepository extends DealRepository {
  final List<DealModel> _deals = [];
  final List<BuyerDealCodeModel> _codes = [];

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
    if (product.isDeleted) {
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
