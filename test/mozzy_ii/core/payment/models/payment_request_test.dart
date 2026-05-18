import 'package:flutter_test/flutter_test.dart';
import 'package:mozzy/mozzy_ii/core/payment/models/payment_request.dart';
import 'package:mozzy/mozzy_ii/core/payment/models/payment_purpose.dart';
import 'package:mozzy/mozzy_ii/core/payment/models/payment_method.dart';

void main() {
  group('PaymentRequest', () {
    test('toJson handles metadata correctly', () {
      const request = PaymentRequest(
        purpose: PaymentPurpose.boostJob,
        userId: 'user123',
        amountIdr: 50000,
        description: 'Job Boost',
        method: MozzyPaymentMethod.qris,
        metadata: {'jobId': 'job456'},
      );

      final json = request.toJson();
      expect(json['amountIdr'], 50000);
      expect(json['metadata']['jobId'], 'job456');
    });

    test('fromJson sets default method to qris', () {
      final json = {
        'purpose': 'boostJob',
        'userId': 'user123',
        'amountIdr': 50000,
        'description': 'Job Boost',
      };

      final request = PaymentRequest.fromJson(json);
      expect(request.method, MozzyPaymentMethod.qris);
    });
  });
}
