// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserModel _$UserModelFromJson(Map<String, dynamic> json) => UserModel(
  uid: json['uid'] as String,
  email: json['email'] as String?,
  displayName: json['displayName'] as String?,
  photoUrl: json['photoUrl'] as String?,
  authProvider: json['authProvider'] as String,
  countryCode: json['countryCode'] as String,
  locationParts: json['locationParts'] == null
      ? null
      : LocationParts.fromJson(json['locationParts'] as Map<String, dynamic>),
  trustScore: (json['trustScore'] as num).toDouble(),
  trustLevel: json['trustLevel'] as String,
  createdAt: DateTime.parse(json['createdAt'] as String),
  updatedAt: DateTime.parse(json['updatedAt'] as String),
  lastLoginAt: json['lastLoginAt'] == null
      ? null
      : DateTime.parse(json['lastLoginAt'] as String),
);

Map<String, dynamic> _$UserModelToJson(UserModel instance) => <String, dynamic>{
  'uid': instance.uid,
  'email': instance.email,
  'displayName': instance.displayName,
  'photoUrl': instance.photoUrl,
  'authProvider': instance.authProvider,
  'countryCode': instance.countryCode,
  'locationParts': instance.locationParts?.toJson(),
  'trustScore': instance.trustScore,
  'trustLevel': instance.trustLevel,
  'createdAt': instance.createdAt.toIso8601String(),
  'updatedAt': instance.updatedAt.toIso8601String(),
  'lastLoginAt': instance.lastLoginAt?.toIso8601String(),
};
