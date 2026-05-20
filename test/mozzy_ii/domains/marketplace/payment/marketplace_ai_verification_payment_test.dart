import 'package:flutter_test/flutter_test.dart';
import 'package:mozzy/mozzy_ii/domains/marketplace/payment/marketplace_payment_config.dart';
import 'package:mozzy/mozzy_ii/core/payment/models/payment_request.dart';
import 'package:mozzy/mozzy_ii/core/payment/models/payment_purpose.dart';

void main() {
  group('Marketplace AI Verification Payment Request', () {
    test('PaymentRequest uses correct fields for AI Verification', () {
      final request = PaymentRequest(
        purpose: PaymentPurpose.aiVerification,
        userId: 'test_user',
        amountIdr: MarketplacePaymentConfig.aiVerificationPriceIdr,
        description: 'Marketplace AI Verification',
        sourceType: 'product',
        sourceId: 'prod_123',
        metadata: {
          'productId': 'prod_123',
          'feature': 'marketplace',
        },
      );

      expect(request.purpose, equals(PaymentPurpose.aiVerification));
      expect(request.amountIdr, equals(15000));
      expect(request.sourceType, equals('product'));
      expect(request.sourceId, equals('prod_123'));
      expect(request.userId, equals('test_user'));
      expect(request.metadata['productId'], equals('prod_123'));
    });
  });
}
