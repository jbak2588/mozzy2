// ============================================================================
// Mozzy DocHeader
// Module        : Marketplace Domain
// File          : lib/mozzy_ii/domains/marketplace/models/ai_review_queue_item_model.dart
// Purpose       : 관리자 검토 대기열 항목 데이터 모델.
// ============================================================================

import 'package:freezed_annotation/freezed_annotation.dart';

part 'ai_review_queue_item_model.freezed.dart';
part 'ai_review_queue_item_model.g.dart';

@freezed
abstract class AiReviewQueueItemModel with _$AiReviewQueueItemModel {
  const AiReviewQueueItemModel._();

  const factory AiReviewQueueItemModel({
    required String id,
    required String productId,
    required String sellerId,
    required String reportId,
    required String status, // needs_review | failed | error
    @Default('') String reason,
    @Default('normal') String priority, // low | normal | high | urgent
    required DateTime createdAt,
    DateTime? resolvedAt,
    @Default('open') String reviewStatus, // open | resolved | dismissed
    String? assignedTo,
  }) = _AiReviewQueueItemModel;

  factory AiReviewQueueItemModel.fromJson(Map<String, dynamic> json) =>
      _$AiReviewQueueItemModelFromJson(json);
}
