// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'post_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_PostModel _$PostModelFromJson(Map<String, dynamic> json) => _PostModel(
  id: json['id'] as String,
  userId: json['userId'] as String,
  title: json['title'] as String,
  content: json['content'] as String,
  imageUrls:
      (json['imageUrls'] as List<dynamic>?)?.map((e) => e as String).toList() ??
      const [],
  category: json['category'] as String,
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
  trustScore: (json['trustScore'] as num?)?.toDouble() ?? 0.0,
  signalScore: (json['signalScore'] as num?)?.toDouble() ?? 0.0,
  geoPath: json['geoPath'] as String,
  location: LocationParts.fromJson(json['location'] as Map<String, dynamic>),
  createdAt: DateTime.parse(json['createdAt'] as String),
  updatedAt: json['updatedAt'] == null
      ? null
      : DateTime.parse(json['updatedAt'] as String),
);

Map<String, dynamic> _$PostModelToJson(_PostModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'userId': instance.userId,
      'title': instance.title,
      'content': instance.content,
      'imageUrls': instance.imageUrls,
      'category': instance.category,
      'geoScope': _$GeoScopeEnumMap[instance.geoScope]!,
      'reachMode': _$ReachModeEnumMap[instance.reachMode]!,
      'translationState': instance.translationState,
      'trustScore': instance.trustScore,
      'signalScore': instance.signalScore,
      'geoPath': instance.geoPath,
      'location': instance.location,
      'createdAt': instance.createdAt.toIso8601String(),
      'updatedAt': instance.updatedAt?.toIso8601String(),
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
