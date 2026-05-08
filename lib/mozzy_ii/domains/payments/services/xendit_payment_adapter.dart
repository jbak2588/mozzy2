import '../models/payment_provider_type.dart';
import '../models/payment_status.dart';
import 'payment_provider_adapter.dart';

class XenditPaymentAdapter implements PaymentProviderAdapter {
  @override
  PaymentProviderType get providerType => PaymentProviderType.xendit;

  @override
  Future<PaymentInvoiceResult> createInvoice(PaymentCreateRequest request) async {
    // This would typically call Xendit API via a secure backend or a client library
    // For now, we return a mock or placeholder. 
    // In production, the client should never call PG directly with secret keys.
    return PaymentInvoiceResult(
      providerInvoiceId: 'xendit_inv_${request.externalId}',
      providerInvoiceUrl: 'https://checkout-staging.xendit.co/v2/invoice/${request.externalId}',
      rawStatus: 'PENDING',
    );
  }

  @override
  Future<PaymentWebhookResult> normalizeWebhook(
    Map<String, dynamic> payload,
    Map<String, String> headers,
  ) async {
    final statusStr = payload['status'] as String? ?? 'UNKNOWN';
    final externalId = payload['external_id'] as String? ?? '';
    
    PaymentStatus status;
    switch (statusStr) {
      case 'PAID':
      case 'SETTLED':
        status = PaymentStatus.paid;
        break;
      case 'EXPIRED':
        status = PaymentStatus.expired;
        break;
      case 'FAILED':
        status = PaymentStatus.failed;
        break;
      default:
        status = PaymentStatus.pending;
    }

    DateTime? paidAt;
    if (payload['paid_at'] != null) {
      paidAt = DateTime.parse(payload['paid_at']);
    }

    return PaymentWebhookResult(
      externalId: externalId,
      status: status,
      rawStatus: statusStr,
      paidAt: paidAt,
    );
  }

  @override
  bool verifyWebhookSignature(
    Map<String, dynamic> payload,
    Map<String, String> headers,
    String secret,
  ) {
    // Implement Xendit signature verification logic here
    final xenditToken = headers['x-callback-token'];
    return xenditToken == secret;
  }
}
