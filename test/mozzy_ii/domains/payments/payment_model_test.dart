import 'package:flutter_test/flutter_test.dart';
import 'package:mozzy/mozzy_ii/domains/payments/models/payment_model.dart';
import 'package:mozzy/mozzy_ii/domains/payments/models/payment_status.dart';
import 'package:mozzy/mozzy_ii/domains/payments/models/payment_provider_type.dart';
import 'package:mozzy/mozzy_ii/domains/payments/models/payment_product_type.dart';

void main() {
  group('PaymentModel Tests', () {
    final now = DateTime.now().toUtc();
    final payment = PaymentModel(
      id: 'pay_123',
      provider: PaymentProviderType.xendit,
      providerMode: PaymentProviderMode.sandbox,
      productType: PaymentProductType.jobBoost,
      relatedDomain: RelatedDomain.jobs,
      relatedId: 'job_456',
      buyerId: 'user_789',
      amount: 150000,
      currency: 'IDR',
      status: PaymentStatus.pending,
      createdAt: now,
      updatedAt: now,
    );

    test('PaymentModel should serialize to JSON correctly', () {
      final json = payment.toJson();
      expect(json['id'], 'pay_123');
      expect(json['provider'], 'xendit');
      expect(json['amount'], 150000);
      expect(json['currency'], 'IDR');
      expect(json['status'], 'pending');
    });

    test('PaymentModel should deserialize from JSON correctly', () {
      final json = {
        'id': 'pay_123',
        'provider': 'xendit',
        'providerMode': 'sandbox',
        'productType': 'jobBoost',
        'relatedDomain': 'jobs',
        'relatedId': 'job_456',
        'buyerId': 'user_789',
        'amount': 150000,
        'currency': 'IDR',
        'status': 'pending',
        'createdAt': now.toIso8601String(),
        'updatedAt': now.toIso8601String(),
      };
      final deserialized = PaymentModel.fromJson(json);
      expect(deserialized.id, 'pay_123');
      expect(deserialized.provider, PaymentProviderType.xendit);
      expect(deserialized.amount, 150000);
      expect(deserialized.status, PaymentStatus.pending);
    });

    test('Default values should be applied correctly', () {
      final minimalJson = {
        'id': 'pay_min',
        'provider': 'midtrans',
        'providerMode': 'production',
        'productType': 'marketplaceDeal',
        'relatedDomain': 'marketplace',
        'relatedId': 'prod_001',
        'buyerId': 'user_abc',
        'amount': 50000,
        'status': 'created',
        'createdAt': now.toIso8601String(),
        'updatedAt': now.toIso8601String(),
      };
      final minimalPayment = PaymentModel.fromJson(minimalJson);
      expect(minimalPayment.currency, 'IDR'); // Default value
      expect(minimalPayment.metadata, {}); // Default value
    });
  });
}
