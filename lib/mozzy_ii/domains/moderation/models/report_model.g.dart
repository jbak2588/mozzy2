// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'report_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_ReportModel _$ReportModelFromJson(Map<String, dynamic> json) => _ReportModel(
  id: json['id'] as String,
  targetType: $enumDecode(_$ReportTargetTypeEnumMap, json['targetType']),
  targetId: json['targetId'] as String,
  targetOwnerId: json['targetOwnerId'] as String?,
  reporterId: json['reporterId'] as String,
  reason: $enumDecode(_$ReportReasonEnumMap, json['reason']),
  description: json['description'] as String?,
  status:
      $enumDecodeNullable(_$ReportStatusEnumMap, json['status']) ??
      ReportStatus.pending,
  severity: json['severity'] as String? ?? 'medium',
  createdAt: const SafeDateTimeConverter().fromJson(json['createdAt']),
  reviewedAt: const OptionalSafeDateTimeConverter().fromJson(
    json['reviewedAt'],
  ),
  reviewedBy: json['reviewedBy'] as String?,
  adminNote: json['adminNote'] as String?,
  countryCode: json['countryCode'] as String? ?? 'ID',
  sourceRoute: json['sourceRoute'] as String?,
);

Map<String, dynamic> _$ReportModelToJson(_ReportModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'targetType': _$ReportTargetTypeEnumMap[instance.targetType]!,
      'targetId': instance.targetId,
      'targetOwnerId': instance.targetOwnerId,
      'reporterId': instance.reporterId,
      'reason': _$ReportReasonEnumMap[instance.reason]!,
      'description': instance.description,
      'status': _$ReportStatusEnumMap[instance.status]!,
      'severity': instance.severity,
      'createdAt': const SafeDateTimeConverter().toJson(instance.createdAt),
      'reviewedAt': const OptionalSafeDateTimeConverter().toJson(
        instance.reviewedAt,
      ),
      'reviewedBy': instance.reviewedBy,
      'adminNote': instance.adminNote,
      'countryCode': instance.countryCode,
      'sourceRoute': instance.sourceRoute,
    };

const _$ReportTargetTypeEnumMap = {
  ReportTargetType.news: 'news',
  ReportTargetType.marketplace: 'marketplace',
  ReportTargetType.jobs: 'jobs',
  ReportTargetType.chat: 'chat',
  ReportTargetType.user: 'user',
};

const _$ReportReasonEnumMap = {
  ReportReason.spam: 'spam',
  ReportReason.scam: 'scam',
  ReportReason.offensive: 'offensive',
  ReportReason.illegal: 'illegal',
  ReportReason.harassment: 'harassment',
  ReportReason.fake: 'fake',
  ReportReason.other: 'other',
};

const _$ReportStatusEnumMap = {
  ReportStatus.pending: 'pending',
  ReportStatus.reviewed: 'reviewed',
  ReportStatus.dismissed: 'dismissed',
  ReportStatus.actionTaken: 'actionTaken',
};
