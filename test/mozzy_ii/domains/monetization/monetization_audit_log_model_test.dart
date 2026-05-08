import 'package:flutter_test/flutter_test.dart';
import 'package:mozzy/mozzy_ii/domains/monetization/models/monetization_audit_log_model.dart';

void main() {
  group('MonetizationAuditLogModel', () {
    final now = DateTime.now();
    final log = MonetizationAuditLogModel(
      id: 'log_1',
      type: 'job_boost_activated',
      relatedDomain: 'jobs',
      relatedId: 'job_1',
      paymentId: 'pay_1',
      jobId: 'job_1',
      actorType: 'system',
      createdAt: now,
    );

    test('helpers should return correct values', () {
      expect(log.isJobBoostEvent, isTrue);
      expect(log.isPaymentEvent, isFalse);
      expect(log.displayTypeKey, 'admin.job_boost_activated');
    });

    test('serialization should work', () {
      final json = log.toJson();
      expect(json['id'], 'log_1');
      expect(json['type'], 'job_boost_activated');
      
      final fromJson = MonetizationAuditLogModel.fromJson(json);
      expect(fromJson.id, log.id);
      expect(fromJson.type, log.type);
    });

    test('isPaymentEvent should return true for payment types', () {
      final paymentLog = log.copyWith(type: 'payment_status_changed', relatedDomain: 'payments');
      expect(paymentLog.isPaymentEvent, isTrue);
      expect(paymentLog.isJobBoostEvent, isFalse);
    });
  });
}
