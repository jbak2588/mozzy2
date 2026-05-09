import 'package:freezed_annotation/freezed_annotation.dart';
import 'feed_item_type.dart';
import '../../../geo/models/location_parts.dart';
import '../../../core/utils/datetime_converter.dart';

part 'feed_item_model.freezed.dart';
part 'feed_item_model.g.dart';

@freezed
abstract class FeedItemModel with _$FeedItemModel {
  const factory FeedItemModel({
    required String id,
    required String sourceId,
    required FeedItemType type,
    required String title,
    String? subtitle,
    String? description,
    String? imageUrl,
    String? ownerId,
    String? locationText,
    @Default('ID') String countryCode,
    LocationParts? locationParts,
    @SafeDateTimeConverter() required DateTime createdAt,
    @OptionalSafeDateTimeConverter() DateTime? updatedAt,
    @Default(false) bool isPromoted,
    @OptionalSafeDateTimeConverter() DateTime? boostActiveUntil,
    
    // Ranking Signals
    @Default(0.0) double trustScore,
    @Default(0.0) double freshnessScore,
    @Default(0.0) double distanceScore,
    @Default(0.0) double boostScore,
    @Default(0.0) double engagementScore,
    @Default(0.0) double semanticScore,
    String? semanticReason,
    @OptionalSafeDateTimeConverter() DateTime? semanticScoredAt,
    @Default(0.0) double finalScore,
    
    required String route,
  }) = _FeedItemModel;

  factory FeedItemModel.fromJson(Map<String, dynamic> json) => _$FeedItemModelFromJson(json);
}
