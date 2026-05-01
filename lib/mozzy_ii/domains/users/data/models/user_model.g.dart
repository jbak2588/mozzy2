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
  createdAt: _dateTimeFromJson(json['createdAt']),
  updatedAt: _dateTimeFromJson(json['updatedAt']),
  lastLoginAt: _nullableDateTimeFromJson(json['lastLoginAt']),
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
  'createdAt': _dateTimeToJson(instance.createdAt),
  'updatedAt': _dateTimeToJson(instance.updatedAt),
  'lastLoginAt': _nullableDateTimeToJson(instance.lastLoginAt),
};
