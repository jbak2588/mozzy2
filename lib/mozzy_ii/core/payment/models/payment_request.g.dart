// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'payment_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_PaymentRequest _$PaymentRequestFromJson(Map<String, dynamic> json) =>
    _PaymentRequest(
      purpose: $enumDecode(_$PaymentPurposeEnumMap, json['purpose']),
      userId: json['userId'] as String,
      amountIdr: (json['amountIdr'] as num).toInt(),
      description: json['description'] as String,
      sourceType: json['sourceType'] as String?,
      sourceId: json['sourceId'] as String?,
      method:
          $enumDecodeNullable(_$MozzyPaymentMethodEnumMap, json['method']) ??
          MozzyPaymentMethod.qris,
      metadata:
          json['metadata'] as Map<String, dynamic>? ??
          const <String, dynamic>{},
    );

Map<String, dynamic> _$PaymentRequestToJson(_PaymentRequest instance) =>
    <String, dynamic>{
      'purpose': _$PaymentPurposeEnumMap[instance.purpose]!,
      'userId': instance.userId,
      'amountIdr': instance.amountIdr,
      'description': instance.description,
      'sourceType': instance.sourceType,
      'sourceId': instance.sourceId,
      'method': _$MozzyPaymentMethodEnumMap[instance.method]!,
      'metadata': instance.metadata,
    };

const _$PaymentPurposeEnumMap = {
  PaymentPurpose.aiVerification: 'aiVerification',
  PaymentPurpose.boostPost: 'boostPost',
  PaymentPurpose.boostProduct: 'boostProduct',
  PaymentPurpose.boostJob: 'boostJob',
  PaymentPurpose.subscriptionMozzyPlus: 'subscriptionMozzyPlus',
  PaymentPurpose.businessPlus: 'businessPlus',
};

const _$MozzyPaymentMethodEnumMap = {
  MozzyPaymentMethod.qris: 'qris',
  MozzyPaymentMethod.virtualAccount: 'virtualAccount',
  MozzyPaymentMethod.eWallet: 'eWallet',
  MozzyPaymentMethod.retailOutlet: 'retailOutlet',
};
