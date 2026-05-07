// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'job_post_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_JobPostModel _$JobPostModelFromJson(Map<String, dynamic> json) =>
    _JobPostModel(
      id: json['id'] as String,
      title: json['title'] as String,
      description: json['description'] as String,
      companyName: json['companyName'] as String,
      ownerId: json['ownerId'] as String,
      ownerName: json['ownerName'] as String,
      ownerPhotoUrl: json['ownerPhotoUrl'] as String?,
      shopId: json['shopId'] as String?,
      category: json['category'] as String,
      jobType: $enumDecode(_$JobTypeEnumMap, json['jobType']),
      workType: $enumDecode(_$WorkTypeEnumMap, json['workType']),
      salaryType: $enumDecode(_$SalaryTypeEnumMap, json['salaryType']),
      salaryMin: (json['salaryMin'] as num).toInt(),
      salaryMax: (json['salaryMax'] as num).toInt(),
      currency: json['currency'] as String? ?? 'IDR',
      locationParts: LocationParts.fromJson(
        json['locationParts'] as Map<String, dynamic>,
      ),
      geoScope:
          $enumDecodeNullable(_$GeoScopeEnumMap, json['geoScope']) ??
          GeoScope.neighborhood,
      reachMode:
          $enumDecodeNullable(_$ReachModeEnumMap, json['reachMode']) ??
          ReachMode.localOnly,
      trustScore: (json['trustScore'] as num?)?.toDouble() ?? 0.5,
      signalScore: (json['signalScore'] as num?)?.toDouble() ?? 0.0,
      discoveryChannels:
          (json['discoveryChannels'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const ['feed', 'map', 'search'],
      mapVisibility: json['mapVisibility'] as bool? ?? true,
      translationState:
          (json['translationState'] as Map<String, dynamic>?)?.map(
            (k, e) => MapEntry(k, e as String),
          ) ??
          const {},
      status: json['status'] as String? ?? 'open',
      applicantCount: (json['applicantCount'] as num?)?.toInt() ?? 0,
      chatCount: (json['chatCount'] as num?)?.toInt() ?? 0,
      viewCount: (json['viewCount'] as num?)?.toInt() ?? 0,
      isDeleted: json['isDeleted'] as bool? ?? false,
      isClosed: json['isClosed'] as bool? ?? false,
      createdAt: const SafeDateTimeConverter().fromJson(json['createdAt']),
      updatedAt: const SafeDateTimeConverter().fromJson(json['updatedAt']),
      expiresAt: const SafeDateTimeConverter().fromJson(json['expiresAt']),
    );

Map<String, dynamic> _$JobPostModelToJson(_JobPostModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'description': instance.description,
      'companyName': instance.companyName,
      'ownerId': instance.ownerId,
      'ownerName': instance.ownerName,
      'ownerPhotoUrl': instance.ownerPhotoUrl,
      'shopId': instance.shopId,
      'category': instance.category,
      'jobType': _$JobTypeEnumMap[instance.jobType]!,
      'workType': _$WorkTypeEnumMap[instance.workType]!,
      'salaryType': _$SalaryTypeEnumMap[instance.salaryType]!,
      'salaryMin': instance.salaryMin,
      'salaryMax': instance.salaryMax,
      'currency': instance.currency,
      'locationParts': instance.locationParts.toJson(),
      'geoScope': _$GeoScopeEnumMap[instance.geoScope]!,
      'reachMode': _$ReachModeEnumMap[instance.reachMode]!,
      'trustScore': instance.trustScore,
      'signalScore': instance.signalScore,
      'discoveryChannels': instance.discoveryChannels,
      'mapVisibility': instance.mapVisibility,
      'translationState': instance.translationState,
      'status': instance.status,
      'applicantCount': instance.applicantCount,
      'chatCount': instance.chatCount,
      'viewCount': instance.viewCount,
      'isDeleted': instance.isDeleted,
      'isClosed': instance.isClosed,
      'createdAt': const SafeDateTimeConverter().toJson(instance.createdAt),
      'updatedAt': const SafeDateTimeConverter().toJson(instance.updatedAt),
      'expiresAt': const SafeDateTimeConverter().toJson(instance.expiresAt),
    };

const _$JobTypeEnumMap = {
  JobType.fullTime: 'fullTime',
  JobType.partTime: 'partTime',
  JobType.freelance: 'freelance',
  JobType.internship: 'internship',
  JobType.daily: 'daily',
};

const _$WorkTypeEnumMap = {
  WorkType.onsite: 'onsite',
  WorkType.hybrid: 'hybrid',
  WorkType.remote: 'remote',
};

const _$SalaryTypeEnumMap = {
  SalaryType.monthly: 'monthly',
  SalaryType.daily: 'daily',
  SalaryType.hourly: 'hourly',
  SalaryType.negotiable: 'negotiable',
};

const _$GeoScopeEnumMap = {
  GeoScope.neighborhood: 'neighborhood',
  GeoScope.city: 'city',
  GeoScope.country: 'country',
  GeoScope.global: 'global',
};

const _$ReachModeEnumMap = {
  ReachMode.localOnly: 'localOnly',
  ReachMode.progressive: 'progressive',
  ReachMode.globalRelay: 'globalRelay',
};
