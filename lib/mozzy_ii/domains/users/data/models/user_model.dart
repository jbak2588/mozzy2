import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:mozzy/mozzy_ii/geo/models/location_parts.dart';

part 'user_model.g.dart';

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
class UserModel {
  final String uid;
  final String? email;
  final String? displayName;
  final String? photoUrl;
  final String authProvider; // e.g. google
  final String countryCode;
  final LocationParts? locationParts;
  final double trustScore;
  final String trustLevel;

  @JsonKey(fromJson: _dateTimeFromJson, toJson: _dateTimeToJson)
  final DateTime createdAt;

  @JsonKey(fromJson: _dateTimeFromJson, toJson: _dateTimeToJson)
  final DateTime updatedAt;

  @JsonKey(fromJson: _nullableDateTimeFromJson, toJson: _nullableDateTimeToJson)
  final DateTime? lastLoginAt;

  const UserModel({
    required this.uid,
    this.email,
    this.displayName,
    this.photoUrl,
    required this.authProvider,
    required this.countryCode,
    this.locationParts,
    required this.trustScore,
    required this.trustLevel,
    required this.createdAt,
    required this.updatedAt,
    this.lastLoginAt,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) =>
      _$UserModelFromJson(json);
  Map<String, dynamic> toJson() => _$UserModelToJson(this);
}
