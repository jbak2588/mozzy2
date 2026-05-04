// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'buyer_deal_code_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BuyerDealCodeModel _$BuyerDealCodeModelFromJson(Map<String, dynamic> json) =>
    BuyerDealCodeModel(
      dealId: json['dealId'] as String,
      buyerId: json['buyerId'] as String,
      sellerId: json['sellerId'] as String,
      productId: json['productId'] as String,
      confirmationCode: json['confirmationCode'] as String,
      codeExpiresAt: _dateTimeFromJson(json['codeExpiresAt']),
      createdAt: _dateTimeFromJson(json['createdAt']),
    );

Map<String, dynamic> _$BuyerDealCodeModelToJson(BuyerDealCodeModel instance) =>
    <String, dynamic>{
      'dealId': instance.dealId,
      'buyerId': instance.buyerId,
      'sellerId': instance.sellerId,
      'productId': instance.productId,
      'confirmationCode': instance.confirmationCode,
      'codeExpiresAt': _dateTimeToJson(instance.codeExpiresAt),
      'createdAt': _dateTimeToJson(instance.createdAt),
    };
