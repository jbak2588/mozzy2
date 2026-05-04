import 'package:flutter_test/flutter_test.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mozzy/mozzy_ii/domains/marketplace/models/deal_model.dart';

void main() {
  group('DealModel Tests', () {
    test('fromJson parses Firestore Timestamp and String correctly', () {
      final now = DateTime.now().toUtc();
      final timestamp = Timestamp.fromDate(now);
      
      final json = {
        'id': 'deal1',
        'productId': 'prod1',
        'productTitle': 'Title',
        'buyerId': 'buyer1',
        'sellerId': 'seller1',
        'amount': 10000,
        'currencyCode': 'IDR',
        'method': 'cod',
        'status': 'confirmed',
        'confirmationCodeHash': 'hash123',
        'confirmationCodeMasked': 'A****Z',
        'codeExpiresAt': timestamp,
        'codeAttemptCount': 0,
        'maxCodeAttempts': 5,
        'createdAt': now.toIso8601String(), // Test String parsing
        'updatedAt': timestamp, // Test Timestamp parsing
      };

      final deal = DealModel.fromJson(json);

      expect(deal.id, 'deal1');
      expect(deal.codeExpiresAt, now);
      expect(deal.createdAt, now);
      expect(deal.updatedAt, now);
      expect(deal.completedAt, null);
    });

    test('copyWith updates fields correctly', () {
      final now = DateTime.now().toUtc();
      
      final deal = DealModel(
        id: 'deal1',
        productId: 'prod1',
        productTitle: 'Title',
        buyerId: 'buyer1',
        sellerId: 'seller1',
        amount: 10000,
        currencyCode: 'IDR',
        method: 'cod',
        status: 'confirmed',
        confirmationCodeHash: 'hash123',
        confirmationCodeMasked: 'A****Z',
        codeExpiresAt: now,
        codeAttemptCount: 0,
        maxCodeAttempts: 5,
        createdAt: now,
        updatedAt: now,
      );

      final updated = deal.copyWith(
        status: 'completed',
        codeAttemptCount: 1,
      );

      expect(updated.status, 'completed');
      expect(updated.codeAttemptCount, 1);
      expect(updated.id, 'deal1');
    });
  });
}
