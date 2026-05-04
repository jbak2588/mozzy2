import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import '../models/deal_model.dart';
import '../models/buyer_deal_code_model.dart';
import '../models/product_model.dart';
import '../utils/confirmation_code_utils.dart';
import 'package:uuid/uuid.dart';

class DealRepository {
  final FirebaseFirestore _fs;
  static const String countryId = 'ID';
  static const String domainId = 'marketplace';

  DealRepository([FirebaseFirestore? fs])
      : _fs = fs ?? FirebaseFirestore.instance;

  String dealsCollectionPath([String? country]) {
    final c = country ?? countryId;
    return 'countries/$c/domains/$domainId/deals';
  }

  String buyerPrivateCodePath(String buyerId) {
    return 'users/$buyerId/private_deal_codes';
  }

  CollectionReference get dealsCollection => _fs.collection(dealsCollectionPath());

  Future<DealModel> createCodDeal({
    required ProductModel product,
    required String buyerId,
  }) async {
    if (buyerId == product.sellerId) {
      throw Exception('Cannot buy your own product');
    }
    if (product.aiVerificationStatus == 'failed') {
      throw Exception('Product is not eligible for COD due to AI status');
    }
    if (product.isDeleted) {
      throw Exception('Product is no longer available');
    }

    final dealId = const Uuid().v4();
    final code = generateConfirmationCode();
    final now = DateTime.now().toUtc();
    final expiresAt = now.add(const Duration(hours: 24));

    final deal = DealModel(
      id: dealId,
      productId: product.id,
      productTitle: product.title,
      productImageUrl: product.imageUrls.isNotEmpty ? product.imageUrls.first : null,
      buyerId: buyerId,
      sellerId: product.sellerId,
      amount: product.price,
      currencyCode: 'IDR',
      method: 'cod',
      status: 'confirmed',
      confirmationCodeHash: hashConfirmationCode(dealId: dealId, code: code),
      confirmationCodeMasked: maskConfirmationCode(code),
      codeExpiresAt: expiresAt,
      codeAttemptCount: 0,
      maxCodeAttempts: 5,
      createdAt: now,
      updatedAt: now,
      productSnapshot: product.toJson(),
    );

    final privateCode = BuyerDealCodeModel(
      dealId: dealId,
      buyerId: buyerId,
      sellerId: product.sellerId,
      productId: product.id,
      confirmationCode: code,
      codeExpiresAt: expiresAt,
      createdAt: now,
    );

    final dealRef = dealsCollection.doc(dealId);
    final privateCodeRef = _fs.collection(buyerPrivateCodePath(buyerId)).doc(dealId);

    await _fs.runTransaction((transaction) async {
      transaction.set(dealRef, deal.toJson());
      transaction.set(privateCodeRef, privateCode.toJson());
    });

    return deal;
  }

  Future<DealModel?> getDealById(String dealId) async {
    try {
      final doc = await dealsCollection.doc(dealId).get().timeout(const Duration(seconds: 10));
      if (!doc.exists) return null;
      return DealModel.fromJson({...doc.data() as Map<String, dynamic>, 'id': doc.id});
    } catch (e) {
      if (kDebugMode) debugPrint('[DealRepo] getDealById error: $e');
      return null;
    }
  }

  Stream<DealModel?> watchDealById(String dealId) {
    return dealsCollection.doc(dealId).snapshots().map((doc) {
      if (!doc.exists) return null;
      return DealModel.fromJson({...doc.data() as Map<String, dynamic>, 'id': doc.id});
    });
  }

  Future<List<DealModel>> fetchBuyerDeals(String buyerId) async {
    try {
      final snap = await dealsCollection
          .where('buyerId', isEqualTo: buyerId)
          .orderBy('createdAt', descending: true)
          .get()
          .timeout(const Duration(seconds: 10));
      return snap.docs
          .map((d) => DealModel.fromJson({...d.data() as Map<String, dynamic>, 'id': d.id}))
          .toList();
    } catch (e) {
      if (kDebugMode) debugPrint('[DealRepo] fetchBuyerDeals error: $e');
      return [];
    }
  }

  Future<List<DealModel>> fetchSellerDeals(String sellerId) async {
    try {
      final snap = await dealsCollection
          .where('sellerId', isEqualTo: sellerId)
          .orderBy('createdAt', descending: true)
          .get()
          .timeout(const Duration(seconds: 10));
      return snap.docs
          .map((d) => DealModel.fromJson({...d.data() as Map<String, dynamic>, 'id': d.id}))
          .toList();
    } catch (e) {
      if (kDebugMode) debugPrint('[DealRepo] fetchSellerDeals error: $e');
      return [];
    }
  }

  Future<BuyerDealCodeModel?> getBuyerDealCode({
    required String buyerId,
    required String dealId,
  }) async {
    try {
      final doc = await _fs
          .collection(buyerPrivateCodePath(buyerId))
          .doc(dealId)
          .get()
          .timeout(const Duration(seconds: 10));
      if (!doc.exists) return null;
      return BuyerDealCodeModel.fromJson(doc.data()!);
    } catch (e) {
      if (kDebugMode) debugPrint('[DealRepo] getBuyerDealCode error: $e');
      return null;
    }
  }

  Future<DealModel> verifySellerConfirmationCode({
    required String dealId,
    required String sellerId,
    required String inputCode,
  }) async {
    final dealRef = dealsCollection.doc(dealId);
    
    return await _fs.runTransaction((transaction) async {
      final doc = await transaction.get(dealRef);
      if (!doc.exists) {
        throw Exception('Deal not found');
      }

      final data = doc.data() as Map<String, dynamic>;
      final deal = DealModel.fromJson({...data, 'id': doc.id});

      if (deal.sellerId != sellerId) {
        throw Exception('Unauthorized');
      }

      if (deal.status == 'completed') {
        throw Exception('Deal already completed');
      }

      if (['canceled', 'expired', 'code_locked'].contains(deal.status)) {
        throw Exception('Deal cannot be completed in its current status');
      }

      if (isCodeExpired(deal.codeExpiresAt)) {
        transaction.update(dealRef, {'status': 'expired', 'updatedAt': FieldValue.serverTimestamp()});
        throw Exception('Code has expired');
      }

      if (deal.codeAttemptCount >= deal.maxCodeAttempts) {
        transaction.update(dealRef, {'status': 'code_locked', 'updatedAt': FieldValue.serverTimestamp()});
        throw Exception('Maximum attempts reached. Code is locked.');
      }

      final inputHash = hashConfirmationCode(dealId: deal.id, code: inputCode);

      if (inputHash != deal.confirmationCodeHash) {
        final newAttemptCount = deal.codeAttemptCount + 1;
        final newStatus = newAttemptCount >= deal.maxCodeAttempts ? 'code_locked' : deal.status;
        
        transaction.update(dealRef, {
          'codeAttemptCount': newAttemptCount,
          'status': newStatus,
          'updatedAt': FieldValue.serverTimestamp(),
        });
        
        throw Exception('Invalid confirmation code');
      }

      final now = DateTime.now().toUtc();
      
      transaction.update(dealRef, {
        'status': 'completed',
        'completedAt': Timestamp.fromDate(now),
        'completedBy': sellerId,
        'updatedAt': Timestamp.fromDate(now),
      });
      
      // Update product to sold
      final String country = 'ID';
      final productRef = _fs.collection('countries/$country/domains/$domainId/products').doc(deal.productId);
      
      final productDoc = await transaction.get(productRef);
      if (productDoc.exists) {
        transaction.update(productRef, {
          'status': 'sold',
          'updatedAt': Timestamp.fromDate(now),
        });
      }

      return deal.copyWith(
        status: 'completed',
        completedAt: now,
        completedBy: sellerId,
        updatedAt: now,
      );
    });
  }
}
