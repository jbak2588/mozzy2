import 'models/payment_request.dart';
import 'models/payment_result.dart';
import 'xendit_service.dart';

class PaymentRepository {
  final XenditService _service;

  PaymentRepository({required XenditService service}) : _service = service;

  Future<PaymentResult> requestPayment(PaymentRequest request) async {
    // Basic logic to route between Invoice or QRIS if needed,
    // or just pass through for now.
    return _service.createInvoice(request);
  }

  Future<PaymentResult> requestQris(PaymentRequest request) async {
    return _service.createQris(request);
  }

  Future<PaymentResult> checkStatus(String paymentId) async {
    return _service.getPaymentStatus(paymentId);
  }
}
