// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'feed_engagement_summary.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_FeedEngagementSummary _$FeedEngagementSummaryFromJson(
  Map<String, dynamic> json,
) => _FeedEngagementSummary(
  id: json['id'] as String,
  sourceType: json['sourceType'] as String,
  sourceId: json['sourceId'] as String,
  feedItemId: json['feedItemId'] as String?,
  impressionCount: (json['impressionCount'] as num?)?.toInt() ?? 0,
  cardTapCount: (json['cardTapCount'] as num?)?.toInt() ?? 0,
  detailOpenCount: (json['detailOpenCount'] as num?)?.toInt() ?? 0,
  ctaTapCount: (json['ctaTapCount'] as num?)?.toInt() ?? 0,
  semanticIntentCount: (json['semanticIntentCount'] as num?)?.toInt() ?? 0,
  totalInteractions: (json['totalInteractions'] as num?)?.toInt() ?? 0,
  uniqueSessionCount: (json['uniqueSessionCount'] as num?)?.toInt() ?? 0,
  engagementScore: (json['engagementScore'] as num?)?.toDouble() ?? 0.0,
  lastInteractionAt: const OptionalSafeDateTimeConverter().fromJson(
    json['lastInteractionAt'],
  ),
  lastAggregatedAt: const OptionalSafeDateTimeConverter().fromJson(
    json['lastAggregatedAt'],
  ),
  window: json['window'] as String? ?? 'all_time',
);

Map<String, dynamic> _$FeedEngagementSummaryToJson(
  _FeedEngagementSummary instance,
) => <String, dynamic>{
  'id': instance.id,
  'sourceType': instance.sourceType,
  'sourceId': instance.sourceId,
  'feedItemId': instance.feedItemId,
  'impressionCount': instance.impressionCount,
  'cardTapCount': instance.cardTapCount,
  'detailOpenCount': instance.detailOpenCount,
  'ctaTapCount': instance.ctaTapCount,
  'semanticIntentCount': instance.semanticIntentCount,
  'totalInteractions': instance.totalInteractions,
  'uniqueSessionCount': instance.uniqueSessionCount,
  'engagementScore': instance.engagementScore,
  'lastInteractionAt': const OptionalSafeDateTimeConverter().toJson(
    instance.lastInteractionAt,
  ),
  'lastAggregatedAt': const OptionalSafeDateTimeConverter().toJson(
    instance.lastAggregatedAt,
  ),
  'window': instance.window,
};
