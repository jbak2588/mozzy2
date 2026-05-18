import 'package:freezed_annotation/freezed_annotation.dart';
import 'payment_method.dart';
import 'payment_purpose.dart';

part 'payment_request.freezed.dart';
part 'payment_request.g.dart';

@freezed
abstract class PaymentRequest with _$PaymentRequest {
  const factory PaymentRequest({
    required PaymentPurpose purpose,
    required String userId,
    required int amountIdr,
    required String description,
    String? sourceType,
    String? sourceId,
    @Default(MozzyPaymentMethod.qris) MozzyPaymentMethod method,
    @Default(<String, dynamic>{}) Map<String, dynamic> metadata,
  }) = _PaymentRequest;

  factory PaymentRequest.fromJson(Map<String, dynamic> json) =>
      _$PaymentRequestFromJson(json);
}
