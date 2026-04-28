import 'package:json_annotation/json_annotation.dart';
import 'package:mozzy/mozzy_ii/geo/models/location_parts.dart';

part 'user_model.g.dart';

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
  final DateTime createdAt;
  final DateTime updatedAt;
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
