import 'package:flutter_test/flutter_test.dart';
import 'package:mozzy/mozzy_ii/domains/payments/services/payment_provider_adapter.dart';
import 'package:mozzy/mozzy_ii/domains/payments/services/xendit_payment_adapter.dart';
import 'package:mozzy/mozzy_ii/domains/payments/services/midtrans_payment_adapter.dart';
import 'package:mozzy/mozzy_ii/domains/payments/models/payment_provider_type.dart';
import 'package:mozzy/mozzy_ii/domains/payments/models/payment_status.dart';

void main() {
  group('PaymentAdapter Tests', () {
    test('XenditPaymentAdapter should return correct provider type', () {
      final adapter = XenditPaymentAdapter();
      expect(adapter.providerType, PaymentProviderType.xendit);
    });

    test('XenditPaymentAdapter should create mock invoice result', () async {
      final adapter = XenditPaymentAdapter();
      final request = PaymentCreateRequest(
        externalId: 'ext_123',
        amount: 1000,
        payerEmail: 'test@example.com',
      );
      final result = await adapter.createInvoice(request);
      expect(result.providerInvoiceId, contains('ext_123'));
      expect(result.providerInvoiceUrl, contains('xendit.co'));
    });

    test('XenditPaymentAdapter should normalize webhook correctly', () async {
      final adapter = XenditPaymentAdapter();
      final payload = {
        'status': 'PAID',
        'external_id': 'ext_123',
        'paid_at': '2026-05-08T10:00:00Z',
      };
      final result = await adapter.normalizeWebhook(payload, {});
      expect(result.status, PaymentStatus.paid);
      expect(result.externalId, 'ext_123');
    });

    test('MidtransPaymentAdapter should return correct provider type', () {
      final adapter = MidtransPaymentAdapter();
      expect(adapter.providerType, PaymentProviderType.midtrans);
    });

    test('MidtransPaymentAdapter createInvoice should throw UnimplementedError in skeleton', () async {
      final adapter = MidtransPaymentAdapter();
      final request = PaymentCreateRequest(
        externalId: 'ext_123',
        amount: 1000,
        payerEmail: 'test@example.com',
      );
      expect(() => adapter.createInvoice(request), throwsUnimplementedError);
    });

    test('MidtransPaymentAdapter should normalize webhook correctly', () async {
      final adapter = MidtransPaymentAdapter();
      final payload = {
        'transaction_status': 'settlement',
        'order_id': 'order_123',
      };
      final result = await adapter.normalizeWebhook(payload, {});
      expect(result.status, PaymentStatus.paid);
      expect(result.externalId, 'order_123');
    });
  });
}
