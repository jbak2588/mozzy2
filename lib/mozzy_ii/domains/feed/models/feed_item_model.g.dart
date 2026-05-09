// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'feed_item_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_FeedItemModel _$FeedItemModelFromJson(
  Map<String, dynamic> json,
) => _FeedItemModel(
  id: json['id'] as String,
  sourceId: json['sourceId'] as String,
  type: $enumDecode(_$FeedItemTypeEnumMap, json['type']),
  title: json['title'] as String,
  subtitle: json['subtitle'] as String?,
  description: json['description'] as String?,
  imageUrl: json['imageUrl'] as String?,
  ownerId: json['ownerId'] as String?,
  locationText: json['locationText'] as String?,
  countryCode: json['countryCode'] as String? ?? 'ID',
  locationParts: json['locationParts'] == null
      ? null
      : LocationParts.fromJson(json['locationParts'] as Map<String, dynamic>),
  createdAt: const SafeDateTimeConverter().fromJson(json['createdAt']),
  updatedAt: const OptionalSafeDateTimeConverter().fromJson(json['updatedAt']),
  isPromoted: json['isPromoted'] as bool? ?? false,
  boostActiveUntil: const OptionalSafeDateTimeConverter().fromJson(
    json['boostActiveUntil'],
  ),
  trustScore: (json['trustScore'] as num?)?.toDouble() ?? 0.0,
  freshnessScore: (json['freshnessScore'] as num?)?.toDouble() ?? 0.0,
  distanceScore: (json['distanceScore'] as num?)?.toDouble() ?? 0.0,
  boostScore: (json['boostScore'] as num?)?.toDouble() ?? 0.0,
  engagementScore: (json['engagementScore'] as num?)?.toDouble() ?? 0.0,
  finalScore: (json['finalScore'] as num?)?.toDouble() ?? 0.0,
  route: json['route'] as String,
);

Map<String, dynamic> _$FeedItemModelToJson(
  _FeedItemModel instance,
) => <String, dynamic>{
  'id': instance.id,
  'sourceId': instance.sourceId,
  'type': _$FeedItemTypeEnumMap[instance.type]!,
  'title': instance.title,
  'subtitle': instance.subtitle,
  'description': instance.description,
  'imageUrl': instance.imageUrl,
  'ownerId': instance.ownerId,
  'locationText': instance.locationText,
  'countryCode': instance.countryCode,
  'locationParts': instance.locationParts?.toJson(),
  'createdAt': const SafeDateTimeConverter().toJson(instance.createdAt),
  'updatedAt': const OptionalSafeDateTimeConverter().toJson(instance.updatedAt),
  'isPromoted': instance.isPromoted,
  'boostActiveUntil': const OptionalSafeDateTimeConverter().toJson(
    instance.boostActiveUntil,
  ),
  'trustScore': instance.trustScore,
  'freshnessScore': instance.freshnessScore,
  'distanceScore': instance.distanceScore,
  'boostScore': instance.boostScore,
  'engagementScore': instance.engagementScore,
  'finalScore': instance.finalScore,
  'route': instance.route,
};

const _$FeedItemTypeEnumMap = {
  FeedItemType.job: 'job',
  FeedItemType.marketplaceProduct: 'marketplaceProduct',
  FeedItemType.localNews: 'localNews',
  FeedItemType.store: 'store',
  FeedItemType.community: 'community',
};
