// ============================================================================
// Mozzy DocHeader
// Module        : Local News Domain
// File          : lib/mozzy_ii/domains/news/models/post_model.dart
// Purpose       : 뉴스 게시글 데이터 모델. MozzyPostContract를 구현하며
//                 인도네시아 Track 1 주소 정보를 포함합니다.
// ============================================================================

import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:mozzy/mozzy_ii/geo/models/location_parts.dart';
import 'package:mozzy/mozzy_ii/shared/contracts/mozzy_post_contract.dart';
import 'package:mozzy/mozzy_ii/core/utils/datetime_converter.dart';

part 'post_model.freezed.dart';
part 'post_model.g.dart';

@freezed
abstract class PostModel with _$PostModel implements MozzyPostContract {
  const PostModel._();

  const factory PostModel({
    required String id,
    required String userId,
    required String title,
    required String content,
    @Default([]) List<String> imageUrls,
    required String category, // Umum, Info, Event, Darurat, Kuliner, Tips Hidup
    // MozzyPostContract 구현 필드
    @Default(GeoScope.neighborhood) GeoScope geoScope,
    @Default(ReachMode.localOnly) ReachMode reachMode,
    @Default({}) Map<String, String> translationState,
    @Default(0.0) double trustScore,
    @Default(0.0) double signalScore,
    required String geoPath,

    // 위치 상세 (Track 1)
    required LocationParts location,

    // Country code redundancy for queries (ISO alpha-2)
    @Default('ID') String countryCode,

    // Soft-delete flag and moderation counters
    @Default(false) bool isDeleted,
    @Default(0) int reportCount,
    @Default(0) int likesCount,
    @Default(0) int commentsCount,
    @Default(0) int viewsCount,

    // Visibility and discovery
    @Default(true) bool mapVisibility,
    @Default(<String>[]) List<String> discoveryChannels,
    @Default(<String>[]) List<String> relayTargets,

    @Default(false) bool isPromoted,
    @Default('none') String boostStatus,
    String? boostPaymentId,
    String? boostPackageId,
    @OptionalSafeDateTimeConverter() DateTime? boostStartedAt,
    @OptionalSafeDateTimeConverter() DateTime? boostActiveUntil,
    @Default(0) int boostDurationDays,
    @Default(0.0) double boostSignalScore,
    @OptionalSafeDateTimeConverter() DateTime? lastBoostedAt,

    @SafeDateTimeConverter() required DateTime createdAt,
    @OptionalSafeDateTimeConverter() DateTime? updatedAt,
  }) = _PostModel;

  bool get isBoostActive =>
      boostStatus == 'active' &&
      boostActiveUntil != null &&
      boostActiveUntil!.isAfter(DateTime.now());

  factory PostModel.fromJson(Map<String, dynamic> json) =>
      _$PostModelFromJson(json);
}
