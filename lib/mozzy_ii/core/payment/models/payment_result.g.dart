// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'payment_result.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_PaymentResult _$PaymentResultFromJson(Map<String, dynamic> json) =>
    _PaymentResult(
      paymentId: json['paymentId'] as String,
      externalId: json['externalId'] as String,
      status:
          $enumDecodeNullable(_$MozzyPaymentStatusEnumMap, json['status']) ??
          MozzyPaymentStatus.pending,
      amountIdr: (json['amountIdr'] as num).toInt(),
      invoiceUrl: json['invoiceUrl'] as String?,
      qrString: json['qrString'] as String?,
      expiresAt: json['expiresAt'] == null
          ? null
          : DateTime.parse(json['expiresAt'] as String),
      raw: json['raw'] as Map<String, dynamic>? ?? const <String, dynamic>{},
    );

Map<String, dynamic> _$PaymentResultToJson(_PaymentResult instance) =>
    <String, dynamic>{
      'paymentId': instance.paymentId,
      'externalId': instance.externalId,
      'status': _$MozzyPaymentStatusEnumMap[instance.status]!,
      'amountIdr': instance.amountIdr,
      'invoiceUrl': instance.invoiceUrl,
      'qrString': instance.qrString,
      'expiresAt': instance.expiresAt?.toIso8601String(),
      'raw': instance.raw,
    };

const _$MozzyPaymentStatusEnumMap = {
  MozzyPaymentStatus.unpaid: 'unpaid',
  MozzyPaymentStatus.pending: 'pending',
  MozzyPaymentStatus.paid: 'paid',
  MozzyPaymentStatus.settled: 'settled',
  MozzyPaymentStatus.failed: 'failed',
  MozzyPaymentStatus.expired: 'expired',
  MozzyPaymentStatus.refunded: 'refunded',
};
