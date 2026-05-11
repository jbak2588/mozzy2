// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'feedback_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_FeedbackModel _$FeedbackModelFromJson(Map<String, dynamic> json) =>
    _FeedbackModel(
      id: json['id'] as String,
      userId: json['userId'] as String,
      type: $enumDecode(_$FeedbackTypeEnumMap, json['type']),
      message: json['message'] as String,
      contactPreference:
          $enumDecodeNullable(
            _$FeedbackContactPreferenceEnumMap,
            json['contactPreference'],
          ) ??
          FeedbackContactPreference.none,
      contactValue: json['contactValue'] as String?,
      appVersion: json['appVersion'] as String,
      platform: json['platform'] as String,
      appEnv: json['appEnv'] as String,
      status:
          $enumDecodeNullable(_$FeedbackStatusEnumMap, json['status']) ??
          FeedbackStatus.open,
      priority:
          $enumDecodeNullable(_$FeedbackPriorityEnumMap, json['priority']) ??
          FeedbackPriority.low,
      createdAt: const SafeDateTimeConverter().fromJson(json['createdAt']),
      updatedAt: const SafeDateTimeConverter().fromJson(json['updatedAt']),
      adminNote: json['adminNote'] as String?,
      resolvedBy: json['resolvedBy'] as String?,
      resolvedAt: const OptionalSafeDateTimeConverter().fromJson(
        json['resolvedAt'],
      ),
    );

Map<String, dynamic> _$FeedbackModelToJson(_FeedbackModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'userId': instance.userId,
      'type': _$FeedbackTypeEnumMap[instance.type]!,
      'message': instance.message,
      'contactPreference':
          _$FeedbackContactPreferenceEnumMap[instance.contactPreference]!,
      'contactValue': instance.contactValue,
      'appVersion': instance.appVersion,
      'platform': instance.platform,
      'appEnv': instance.appEnv,
      'status': _$FeedbackStatusEnumMap[instance.status]!,
      'priority': _$FeedbackPriorityEnumMap[instance.priority]!,
      'createdAt': const SafeDateTimeConverter().toJson(instance.createdAt),
      'updatedAt': const SafeDateTimeConverter().toJson(instance.updatedAt),
      'adminNote': instance.adminNote,
      'resolvedBy': instance.resolvedBy,
      'resolvedAt': const OptionalSafeDateTimeConverter().toJson(
        instance.resolvedAt,
      ),
    };

const _$FeedbackTypeEnumMap = {
  FeedbackType.bug: 'bug',
  FeedbackType.suggestion: 'suggestion',
  FeedbackType.usability: 'usability',
  FeedbackType.payment: 'payment',
  FeedbackType.account: 'account',
  FeedbackType.safety: 'safety',
  FeedbackType.other: 'other',
};

const _$FeedbackContactPreferenceEnumMap = {
  FeedbackContactPreference.none: 'none',
  FeedbackContactPreference.whatsapp: 'whatsapp',
  FeedbackContactPreference.email: 'email',
};

const _$FeedbackStatusEnumMap = {
  FeedbackStatus.open: 'open',
  FeedbackStatus.inReview: 'inReview',
  FeedbackStatus.resolved: 'resolved',
  FeedbackStatus.dismissed: 'dismissed',
};

const _$FeedbackPriorityEnumMap = {
  FeedbackPriority.low: 'low',
  FeedbackPriority.medium: 'medium',
  FeedbackPriority.high: 'high',
};
