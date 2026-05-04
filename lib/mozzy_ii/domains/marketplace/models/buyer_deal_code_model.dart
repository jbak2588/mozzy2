import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:json_annotation/json_annotation.dart';

part 'buyer_deal_code_model.g.dart';

DateTime _dateTimeFromJson(Object? value) {
  if (value is Timestamp) {
    return value.toDate().toUtc();
  }
  if (value is DateTime) {
    return value.toUtc();
  }
  if (value is String) {
    return DateTime.parse(value).toUtc();
  }
  throw FormatException('Unsupported DateTime value: $value');
}

Object _dateTimeToJson(DateTime value) {
  return Timestamp.fromDate(value.toUtc());
}

@JsonSerializable(explicitToJson: true)
class BuyerDealCodeModel {
  final String dealId;
  final String buyerId;
  final String sellerId;
  final String productId;
  final String confirmationCode;

  @JsonKey(fromJson: _dateTimeFromJson, toJson: _dateTimeToJson)
  final DateTime codeExpiresAt;

  @JsonKey(fromJson: _dateTimeFromJson, toJson: _dateTimeToJson)
  final DateTime createdAt;

  const BuyerDealCodeModel({
    required this.dealId,
    required this.buyerId,
    required this.sellerId,
    required this.productId,
    required this.confirmationCode,
    required this.codeExpiresAt,
    required this.createdAt,
  });

  factory BuyerDealCodeModel.fromJson(Map<String, dynamic> json) =>
      _$BuyerDealCodeModelFromJson(json);
  Map<String, dynamic> toJson() => _$BuyerDealCodeModelToJson(this);
}
