import '../models/payment_model.dart';
import '../models/payment_status.dart';

abstract class PaymentRepository {
  Future<String> createPayment(PaymentModel payment);
  Stream<PaymentModel?> watchPayment(String paymentId);
  Future<PaymentModel?> fetchPayment(String paymentId);
  Future<void> markPaymentPending(String paymentId);
  Future<void> markPaymentPaid(String paymentId, {DateTime? paidAt});
  Future<void> markPaymentFailed(String paymentId, {String? reason});
  Future<void> markPaymentExpired(String paymentId);
  Future<void> attachProviderInvoice(
    String paymentId, {
    required String providerInvoiceId,
    required String providerInvoiceUrl,
    String? rawStatus,
  });
  Future<void> updateWebhookReceived(String paymentId, Map<String, dynamic> rawPayload);
}
