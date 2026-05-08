import '../models/payment_provider_type.dart';
import '../models/payment_status.dart';

abstract class PaymentProviderAdapter {
  PaymentProviderType get providerType;

  Future<PaymentInvoiceResult> createInvoice(PaymentCreateRequest request);

  Future<PaymentWebhookResult> normalizeWebhook(
    Map<String, dynamic> payload,
    Map<String, String> headers,
  );

  bool verifyWebhookSignature(
    Map<String, dynamic> payload,
    Map<String, String> headers,
    String secret,
  );
}

class PaymentCreateRequest {
  final String externalId;
  final int amount;
  final String payerEmail;
  final String description;
  final Map<String, dynamic> metadata;

  PaymentCreateRequest({
    required this.externalId,
    required this.amount,
    required this.payerEmail,
    this.description = '',
    this.metadata = const {},
  });
}

class PaymentInvoiceResult {
  final String providerInvoiceId;
  final String providerInvoiceUrl;
  final String rawStatus;

  PaymentInvoiceResult({
    required this.providerInvoiceId,
    required this.providerInvoiceUrl,
    required this.rawStatus,
  });
}

class PaymentWebhookResult {
  final String externalId;
  final PaymentStatus status;
  final String rawStatus;
  final DateTime? paidAt;

  PaymentWebhookResult({
    required this.externalId,
    required this.status,
    required this.rawStatus,
    this.paidAt,
  });
}
