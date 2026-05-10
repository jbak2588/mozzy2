import 'package:freezed_annotation/freezed_annotation.dart';
import '../../../core/utils/datetime_converter.dart';

part 'feed_engagement_summary.freezed.dart';
part 'feed_engagement_summary.g.dart';

@freezed
abstract class FeedEngagementSummary with _$FeedEngagementSummary {
  const FeedEngagementSummary._();

  const factory FeedEngagementSummary({
    required String id,
    required String sourceType,
    required String sourceId,
    String? feedItemId,
    @Default(0) int impressionCount,
    @Default(0) int cardTapCount,
    @Default(0) int detailOpenCount,
    @Default(0) int ctaTapCount,
    @Default(0) int semanticIntentCount,
    @Default(0) int totalInteractions,
    @Default(0) int uniqueSessionCount,
    @Default(0.0) double engagementScore,
    @OptionalSafeDateTimeConverter() DateTime? lastInteractionAt,
    @OptionalSafeDateTimeConverter() DateTime? lastAggregatedAt,
    @Default('all_time') String window,
  }) = _FeedEngagementSummary;

  factory FeedEngagementSummary.fromJson(Map<String, dynamic> json) =>
      _$FeedEngagementSummaryFromJson(json);
}
