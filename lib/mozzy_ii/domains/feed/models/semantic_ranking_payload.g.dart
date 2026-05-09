// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'semantic_ranking_payload.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_SemanticRankingPayload _$SemanticRankingPayloadFromJson(
  Map<String, dynamic> json,
) => _SemanticRankingPayload(
  feedItemId: json['feedItemId'] as String,
  sourceId: json['sourceId'] as String,
  type: json['type'] as String,
  title: json['title'] as String,
  publicSummary: json['publicSummary'] as String?,
  category: json['category'] as String?,
  locationHint: json['locationHint'] as String?,
  isPromoted: json['isPromoted'] as bool? ?? false,
  isTrusted: json['isTrusted'] as bool? ?? false,
  ageBucket: json['ageBucket'] as String?,
  languageCode: json['languageCode'] as String?,
);

Map<String, dynamic> _$SemanticRankingPayloadToJson(
  _SemanticRankingPayload instance,
) => <String, dynamic>{
  'feedItemId': instance.feedItemId,
  'sourceId': instance.sourceId,
  'type': instance.type,
  'title': instance.title,
  'publicSummary': instance.publicSummary,
  'category': instance.category,
  'locationHint': instance.locationHint,
  'isPromoted': instance.isPromoted,
  'isTrusted': instance.isTrusted,
  'ageBucket': instance.ageBucket,
  'languageCode': instance.languageCode,
};
