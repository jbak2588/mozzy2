import '../models/payment_provider_type.dart';
import '../models/payment_status.dart';
import 'payment_provider_adapter.dart';

class MidtransPaymentAdapter implements PaymentProviderAdapter {
  @override
  PaymentProviderType get providerType => PaymentProviderType.midtrans;

  @override
  Future<PaymentInvoiceResult> createInvoice(PaymentCreateRequest request) async {
    // Skeleton implementation
    throw UnimplementedError('Midtrans createInvoice not implemented yet');
  }

  @override
  Future<PaymentWebhookResult> normalizeWebhook(
    Map<String, dynamic> payload,
    Map<String, String> headers,
  ) async {
    // Skeleton implementation
    final transactionStatus = payload['transaction_status'] as String? ?? '';
    final orderId = payload['order_id'] as String? ?? '';

    PaymentStatus status;
    // Basic Midtrans status mapping
    if (transactionStatus == 'settlement' || transactionStatus == 'capture') {
      status = PaymentStatus.paid;
    } else if (transactionStatus == 'pending') {
      status = PaymentStatus.pending;
    } else if (transactionStatus == 'expire') {
      status = PaymentStatus.expired;
    } else if (transactionStatus == 'cancel' || transactionStatus == 'deny') {
      status = PaymentStatus.failed;
    } else {
      status = PaymentStatus.pending;
    }

    return PaymentWebhookResult(
      externalId: orderId,
      status: status,
      rawStatus: transactionStatus,
    );
  }

  @override
  bool verifyWebhookSignature(
    Map<String, dynamic> payload,
    Map<String, String> headers,
    String secret,
  ) {
    // Midtrans uses SHA512 of order_id, status_code, gross_amount, server_key
    return true; // Simplified for skeleton
  }
}
