// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_ProductModel _$ProductModelFromJson(
  Map<String, dynamic> json,
) => _ProductModel(
  id: json['id'] as String,
  userId: json['sellerId'] as String,
  title: json['title'] as String,
  description: json['description'] as String,
  category: json['category'] as String,
  price: (json['price'] as num).toInt(),
  currencyCode: json['currencyCode'] as String? ?? 'IDR',
  imageUrls:
      (json['imageUrls'] as List<dynamic>?)?.map((e) => e as String).toList() ??
      const [],
  geoScope:
      $enumDecodeNullable(_$GeoScopeEnumMap, json['geoScope']) ??
      GeoScope.neighborhood,
  reachMode:
      $enumDecodeNullable(_$ReachModeEnumMap, json['reachMode']) ??
      ReachMode.localOnly,
  translationState:
      (json['translationState'] as Map<String, dynamic>?)?.map(
        (k, e) => MapEntry(k, e as String),
      ) ??
      const {},
  trustScore: (json['trustScore'] as num?)?.toDouble() ?? 0.3,
  signalScore: (json['signalScore'] as num?)?.toDouble() ?? 0.0,
  geoPath: json['geoPath'] as String,
  discoveryChannels:
      (json['discoveryChannels'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList() ??
      const <String>['feed', 'map', 'search'],
  mapVisibility: json['mapVisibility'] as bool? ?? true,
  locationParts: json['locationParts'] == null
      ? null
      : LocationParts.fromJson(json['locationParts'] as Map<String, dynamic>),
  countryCode: json['countryCode'] as String? ?? 'ID',
  isAiVerified: json['isAiVerified'] as bool? ?? false,
  aiVerificationStatus:
      json['aiVerificationStatus'] as String? ?? 'not_requested',
  aiVerificationScore: (json['aiVerificationScore'] as num?)?.toDouble(),
  aiVerificationSummary: json['aiVerificationSummary'] as String?,
  aiDetectedIssues:
      (json['aiDetectedIssues'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList() ??
      const [],
  aiSuggestedCategory: json['aiSuggestedCategory'] as String?,
  aiConditionLabel: json['aiConditionLabel'] as String?,
  aiVerifiedAt: const OptionalSafeDateTimeConverter().fromJson(
    json['aiVerifiedAt'],
  ),
  aiVerificationPaymentId: json['aiVerificationPaymentId'] as String?,
  aiVerificationRequestedAt: const OptionalSafeDateTimeConverter().fromJson(
    json['aiVerificationRequestedAt'],
  ),
  aiVerificationPaidAt: const OptionalSafeDateTimeConverter().fromJson(
    json['aiVerificationPaidAt'],
  ),
  aiVerificationError: json['aiVerificationError'] as String?,
  isPromoted: json['isPromoted'] as bool? ?? false,
  boostStatus: json['boostStatus'] as String? ?? 'none',
  boostPaymentId: json['boostPaymentId'] as String?,
  boostPackageId: json['boostPackageId'] as String?,
  boostStartedAt: const OptionalSafeDateTimeConverter().fromJson(
    json['boostStartedAt'],
  ),
  boostActiveUntil: const OptionalSafeDateTimeConverter().fromJson(
    json['boostActiveUntil'],
  ),
  boostDurationDays: (json['boostDurationDays'] as num?)?.toInt() ?? 0,
  boostSignalScore: (json['boostSignalScore'] as num?)?.toDouble() ?? 0.0,
  lastBoostedAt: const OptionalSafeDateTimeConverter().fromJson(
    json['lastBoostedAt'],
  ),
  createdAt: const SafeDateTimeConverter().fromJson(json['createdAt']),
  updatedAt: const OptionalSafeDateTimeConverter().fromJson(json['updatedAt']),
  isDeleted: json['isDeleted'] as bool? ?? false,
  status:
      $enumDecodeNullable(_$ProductStatusEnumMap, json['status']) ??
      ProductStatus.available,
  viewsCount: (json['viewsCount'] as num?)?.toInt() ?? 0,
  likesCount: (json['likesCount'] as num?)?.toInt() ?? 0,
  chatsCount: (json['chatsCount'] as num?)?.toInt() ?? 0,
);

Map<String, dynamic> _$ProductModelToJson(
  _ProductModel instance,
) => <String, dynamic>{
  'id': instance.id,
  'sellerId': instance.userId,
  'title': instance.title,
  'description': instance.description,
  'category': instance.category,
  'price': instance.price,
  'currencyCode': instance.currencyCode,
  'imageUrls': instance.imageUrls,
  'geoScope': _$GeoScopeEnumMap[instance.geoScope]!,
  'reachMode': _$ReachModeEnumMap[instance.reachMode]!,
  'translationState': instance.translationState,
  'trustScore': instance.trustScore,
  'signalScore': instance.signalScore,
  'geoPath': instance.geoPath,
  'discoveryChannels': instance.discoveryChannels,
  'mapVisibility': instance.mapVisibility,
  'locationParts': instance.locationParts?.toJson(),
  'countryCode': instance.countryCode,
  'isAiVerified': instance.isAiVerified,
  'aiVerificationStatus': instance.aiVerificationStatus,
  'aiVerificationScore': instance.aiVerificationScore,
  'aiVerificationSummary': instance.aiVerificationSummary,
  'aiDetectedIssues': instance.aiDetectedIssues,
  'aiSuggestedCategory': instance.aiSuggestedCategory,
  'aiConditionLabel': instance.aiConditionLabel,
  'aiVerifiedAt': const OptionalSafeDateTimeConverter().toJson(
    instance.aiVerifiedAt,
  ),
  'aiVerificationPaymentId': instance.aiVerificationPaymentId,
  'aiVerificationRequestedAt': const OptionalSafeDateTimeConverter().toJson(
    instance.aiVerificationRequestedAt,
  ),
  'aiVerificationPaidAt': const OptionalSafeDateTimeConverter().toJson(
    instance.aiVerificationPaidAt,
  ),
  'aiVerificationError': instance.aiVerificationError,
  'isPromoted': instance.isPromoted,
  'boostStatus': instance.boostStatus,
  'boostPaymentId': instance.boostPaymentId,
  'boostPackageId': instance.boostPackageId,
  'boostStartedAt': const OptionalSafeDateTimeConverter().toJson(
    instance.boostStartedAt,
  ),
  'boostActiveUntil': const OptionalSafeDateTimeConverter().toJson(
    instance.boostActiveUntil,
  ),
  'boostDurationDays': instance.boostDurationDays,
  'boostSignalScore': instance.boostSignalScore,
  'lastBoostedAt': const OptionalSafeDateTimeConverter().toJson(
    instance.lastBoostedAt,
  ),
  'createdAt': const SafeDateTimeConverter().toJson(instance.createdAt),
  'updatedAt': const OptionalSafeDateTimeConverter().toJson(instance.updatedAt),
  'isDeleted': instance.isDeleted,
  'status': _$ProductStatusEnumMap[instance.status]!,
  'viewsCount': instance.viewsCount,
  'likesCount': instance.likesCount,
  'chatsCount': instance.chatsCount,
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

const _$ProductStatusEnumMap = {
  ProductStatus.available: 'available',
  ProductStatus.reserved: 'reserved',
  ProductStatus.sold: 'sold',
};
