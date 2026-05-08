import 'package:freezed_annotation/freezed_annotation.dart';
import 'payment_provider_type.dart';
import 'payment_product_type.dart';
import 'payment_status.dart';
import '../../marketplace/models/product_model.dart'; // For SafeDateTimeConverter

part 'payment_model.freezed.dart';
part 'payment_model.g.dart';

@freezed
abstract class PaymentModel with _$PaymentModel {
  const PaymentModel._();

  const factory PaymentModel({
    required String id,
    required PaymentProviderType provider,
    required PaymentProviderMode providerMode,
    required PaymentProductType productType,
    required RelatedDomain relatedDomain,
    required String relatedId,
    required String buyerId,
    String? sellerId,
    String? ownerId,
    required int amount,
    @Default('IDR') String currency,
    required PaymentStatus status,
    String? providerInvoiceId,
    String? providerInvoiceUrl,
    String? externalId,
    @Default({}) Map<String, dynamic> metadata,
    @SafeDateTimeConverter() required DateTime createdAt,
    @SafeDateTimeConverter() required DateTime updatedAt,
    @OptionalSafeDateTimeConverter() DateTime? paidAt,
    @OptionalSafeDateTimeConverter() DateTime? expiredAt,
    @OptionalSafeDateTimeConverter() DateTime? webhookLastReceivedAt,
    String? rawProviderStatus,
  }) = _PaymentModel;

  factory PaymentModel.fromJson(Map<String, dynamic> json) => _$PaymentModelFromJson(json);
}
