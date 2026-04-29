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
  locationParts: json['locationParts'] == null
      ? null
      : LocationParts.fromJson(json['locationParts'] as Map<String, dynamic>),
  countryCode: json['countryCode'] as String? ?? 'ID',
  isAiVerified: json['isAiVerified'] as bool? ?? false,
  aiVerificationStatus:
      json['aiVerificationStatus'] as String? ?? 'not_requested',
  createdAt: const SafeDateTimeConverter().fromJson(json['createdAt']),
  updatedAt: const OptionalSafeDateTimeConverter().fromJson(json['updatedAt']),
  isDeleted: json['isDeleted'] as bool? ?? false,
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
  'locationParts': instance.locationParts?.toJson(),
  'countryCode': instance.countryCode,
  'isAiVerified': instance.isAiVerified,
  'aiVerificationStatus': instance.aiVerificationStatus,
  'createdAt': const SafeDateTimeConverter().toJson(instance.createdAt),
  'updatedAt': const OptionalSafeDateTimeConverter().toJson(instance.updatedAt),
  'isDeleted': instance.isDeleted,
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
