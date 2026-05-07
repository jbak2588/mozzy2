// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'job_applicant_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_JobApplicantModel _$JobApplicantModelFromJson(Map<String, dynamic> json) =>
    _JobApplicantModel(
      id: json['id'] as String,
      jobId: json['jobId'] as String,
      applicantId: json['applicantId'] as String,
      applicantName: json['applicantName'] as String,
      applicantPhotoUrl: json['applicantPhotoUrl'] as String?,
      applicantPhoneMasked: json['applicantPhoneMasked'] as String?,
      chatRoomId: json['chatRoomId'] as String?,
      status:
          $enumDecodeNullable(_$JobApplicantStatusEnumMap, json['status']) ??
          JobApplicantStatus.newApplicant,
      messagePreview: json['messagePreview'] as String?,
      appliedAt: const SafeDateTimeConverter().fromJson(json['appliedAt']),
      updatedAt: const SafeDateTimeConverter().fromJson(json['updatedAt']),
      lastInteractionAt: const SafeDateTimeConverter().fromJson(
        json['lastInteractionAt'],
      ),
      source: json['source'] as String? ?? 'job_detail',
      countryCode: json['countryCode'] as String? ?? 'ID',
    );

Map<String, dynamic> _$JobApplicantModelToJson(_JobApplicantModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'jobId': instance.jobId,
      'applicantId': instance.applicantId,
      'applicantName': instance.applicantName,
      'applicantPhotoUrl': instance.applicantPhotoUrl,
      'applicantPhoneMasked': instance.applicantPhoneMasked,
      'chatRoomId': instance.chatRoomId,
      'status': _$JobApplicantStatusEnumMap[instance.status]!,
      'messagePreview': instance.messagePreview,
      'appliedAt': const SafeDateTimeConverter().toJson(instance.appliedAt),
      'updatedAt': const SafeDateTimeConverter().toJson(instance.updatedAt),
      'lastInteractionAt': _$JsonConverterToJson<dynamic, DateTime>(
        instance.lastInteractionAt,
        const SafeDateTimeConverter().toJson,
      ),
      'source': instance.source,
      'countryCode': instance.countryCode,
    };

const _$JobApplicantStatusEnumMap = {
  JobApplicantStatus.newApplicant: 'new',
  JobApplicantStatus.contacted: 'contacted',
  JobApplicantStatus.shortlisted: 'shortlisted',
  JobApplicantStatus.rejected: 'rejected',
  JobApplicantStatus.hired: 'hired',
};

Json? _$JsonConverterToJson<Json, Value>(
  Value? value,
  Json? Function(Value value) toJson,
) => value == null ? null : toJson(value);
