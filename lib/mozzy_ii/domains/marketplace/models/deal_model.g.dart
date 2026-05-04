// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'deal_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DealModel _$DealModelFromJson(Map<String, dynamic> json) => DealModel(
  id: json['id'] as String,
  productId: json['productId'] as String,
  productTitle: json['productTitle'] as String,
  productImageUrl: json['productImageUrl'] as String?,
  buyerId: json['buyerId'] as String,
  sellerId: json['sellerId'] as String,
  amount: (json['amount'] as num).toInt(),
  currencyCode: json['currencyCode'] as String,
  method: json['method'] as String,
  status: json['status'] as String,
  confirmationCodeHash: json['confirmationCodeHash'] as String,
  confirmationCodeMasked: json['confirmationCodeMasked'] as String,
  codeExpiresAt: _dateTimeFromJson(json['codeExpiresAt']),
  codeAttemptCount: (json['codeAttemptCount'] as num).toInt(),
  maxCodeAttempts: (json['maxCodeAttempts'] as num).toInt(),
  completedAt: _nullableDateTimeFromJson(json['completedAt']),
  completedBy: json['completedBy'] as String?,
  createdAt: _dateTimeFromJson(json['createdAt']),
  updatedAt: _dateTimeFromJson(json['updatedAt']),
  productSnapshot: json['productSnapshot'] as Map<String, dynamic>?,
);

Map<String, dynamic> _$DealModelToJson(DealModel instance) => <String, dynamic>{
  'id': instance.id,
  'productId': instance.productId,
  'productTitle': instance.productTitle,
  'productImageUrl': instance.productImageUrl,
  'buyerId': instance.buyerId,
  'sellerId': instance.sellerId,
  'amount': instance.amount,
  'currencyCode': instance.currencyCode,
  'method': instance.method,
  'status': instance.status,
  'confirmationCodeHash': instance.confirmationCodeHash,
  'confirmationCodeMasked': instance.confirmationCodeMasked,
  'codeExpiresAt': _dateTimeToJson(instance.codeExpiresAt),
  'codeAttemptCount': instance.codeAttemptCount,
  'maxCodeAttempts': instance.maxCodeAttempts,
  'completedAt': _nullableDateTimeToJson(instance.completedAt),
  'completedBy': instance.completedBy,
  'createdAt': _dateTimeToJson(instance.createdAt),
  'updatedAt': _dateTimeToJson(instance.updatedAt),
  'productSnapshot': instance.productSnapshot,
};
