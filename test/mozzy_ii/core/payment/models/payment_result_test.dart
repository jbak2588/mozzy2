import 'package:flutter_test/flutter_test.dart';
import 'package:mozzy/mozzy_ii/core/payment/models/payment_result.dart';
import 'package:mozzy/mozzy_ii/core/payment/models/payment_status.dart';

void main() {
  group('PaymentResult', () {
    test('fromJson parses correctly', () {
      final json = {
        'paymentId': 'pay123',
        'externalId': 'ext123',
        'status': 'paid',
        'amountIdr': 50000,
        'invoiceUrl': 'https://xendit.co/inv',
      };

      final result = PaymentResult.fromJson(json);
      expect(result.status, MozzyPaymentStatus.paid);
      expect(result.amountIdr, 50000);
      expect(result.invoiceUrl, 'https://xendit.co/inv');
    });

    test('fromJson handles missing status with default pending', () {
      final json = {
        'paymentId': 'pay123',
        'externalId': 'ext123',
        'amountIdr': 50000,
      };

      final result = PaymentResult.fromJson(json);
      expect(result.status, MozzyPaymentStatus.pending);
    });
  });
}
