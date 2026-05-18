import 'models/payment_request.dart';
import 'models/payment_result.dart';

abstract class XenditService {
  Future<PaymentResult> createInvoice(PaymentRequest request);
  Future<PaymentResult> createQris(PaymentRequest request);
  Future<PaymentResult> getPaymentStatus(String paymentId);
}
