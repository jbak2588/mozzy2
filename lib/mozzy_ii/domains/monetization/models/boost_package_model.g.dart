// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'boost_package_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_BoostPackageModel _$BoostPackageModelFromJson(Map<String, dynamic> json) =>
    _BoostPackageModel(
      id: json['id'] as String,
      productType: json['productType'] as String,
      titleKey: json['titleKey'] as String,
      descriptionKey: json['descriptionKey'] as String,
      durationDays: (json['durationDays'] as num).toInt(),
      amount: (json['amount'] as num).toInt(),
      currency: json['currency'] as String? ?? 'IDR',
      isActive: json['isActive'] as bool? ?? true,
    );

Map<String, dynamic> _$BoostPackageModelToJson(_BoostPackageModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'productType': instance.productType,
      'titleKey': instance.titleKey,
      'descriptionKey': instance.descriptionKey,
      'durationDays': instance.durationDays,
      'amount': instance.amount,
      'currency': instance.currency,
      'isActive': instance.isActive,
    };
