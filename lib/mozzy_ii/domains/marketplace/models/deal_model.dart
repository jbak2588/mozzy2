import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:json_annotation/json_annotation.dart';

part 'deal_model.g.dart';

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

DateTime? _nullableDateTimeFromJson(Object? value) {
  if (value == null) return null;
  return _dateTimeFromJson(value);
}

Object? _nullableDateTimeToJson(DateTime? value) {
  if (value == null) return null;
  return Timestamp.fromDate(value.toUtc());
}

@JsonSerializable(explicitToJson: true)
class DealModel {
  final String id;
  final String productId;
  final String productTitle;
  final String? productImageUrl;
  final String buyerId;
  final String sellerId;
  final int amount;
  final String currencyCode;
  final String method;
  final String status;
  final String confirmationCodeHash;
  final String confirmationCodeMasked;
  
  @JsonKey(fromJson: _dateTimeFromJson, toJson: _dateTimeToJson)
  final DateTime codeExpiresAt;
  
  final int codeAttemptCount;
  final int maxCodeAttempts;

  @JsonKey(fromJson: _nullableDateTimeFromJson, toJson: _nullableDateTimeToJson)
  final DateTime? completedAt;
  final String? completedBy;

  @JsonKey(fromJson: _dateTimeFromJson, toJson: _dateTimeToJson)
  final DateTime createdAt;

  @JsonKey(fromJson: _dateTimeFromJson, toJson: _dateTimeToJson)
  final DateTime updatedAt;

  final Map<String, dynamic>? productSnapshot;

  const DealModel({
    required this.id,
    required this.productId,
    required this.productTitle,
    this.productImageUrl,
    required this.buyerId,
    required this.sellerId,
    required this.amount,
    required this.currencyCode,
    required this.method,
    required this.status,
    required this.confirmationCodeHash,
    required this.confirmationCodeMasked,
    required this.codeExpiresAt,
    required this.codeAttemptCount,
    required this.maxCodeAttempts,
    this.completedAt,
    this.completedBy,
    required this.createdAt,
    required this.updatedAt,
    this.productSnapshot,
  });

  factory DealModel.fromJson(Map<String, dynamic> json) =>
      _$DealModelFromJson(json);
  Map<String, dynamic> toJson() => _$DealModelToJson(this);

  DealModel copyWith({
    String? status,
    int? codeAttemptCount,
    DateTime? completedAt,
    String? completedBy,
    DateTime? updatedAt,
  }) {
    return DealModel(
      id: id,
      productId: productId,
      productTitle: productTitle,
      productImageUrl: productImageUrl,
      buyerId: buyerId,
      sellerId: sellerId,
      amount: amount,
      currencyCode: currencyCode,
      method: method,
      status: status ?? this.status,
      confirmationCodeHash: confirmationCodeHash,
      confirmationCodeMasked: confirmationCodeMasked,
      codeExpiresAt: codeExpiresAt,
      codeAttemptCount: codeAttemptCount ?? this.codeAttemptCount,
      maxCodeAttempts: maxCodeAttempts,
      completedAt: completedAt ?? this.completedAt,
      completedBy: completedBy ?? this.completedBy,
      createdAt: createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      productSnapshot: productSnapshot,
    );
  }
}
