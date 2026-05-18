import 'package:freezed_annotation/freezed_annotation.dart';
import 'payment_status.dart';

part 'payment_result.freezed.dart';
part 'payment_result.g.dart';

@freezed
abstract class PaymentResult with _$PaymentResult {
  const factory PaymentResult({
    required String paymentId,
    required String externalId,
    @Default(MozzyPaymentStatus.pending) MozzyPaymentStatus status,
    required int amountIdr,
    String? invoiceUrl,
    String? qrString,
    DateTime? expiresAt,
    @Default(<String, dynamic>{}) Map<String, dynamic> raw,
  }) = _PaymentResult;

  factory PaymentResult.fromJson(Map<String, dynamic> json) =>
      _$PaymentResultFromJson(json);
}
