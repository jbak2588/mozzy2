// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ai_review_queue_item_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_AiReviewQueueItemModel _$AiReviewQueueItemModelFromJson(
  Map<String, dynamic> json,
) => _AiReviewQueueItemModel(
  id: json['id'] as String,
  productId: json['productId'] as String,
  sellerId: json['sellerId'] as String,
  reportId: json['reportId'] as String,
  status: json['status'] as String,
  reason: json['reason'] as String? ?? '',
  priority: json['priority'] as String? ?? 'normal',
  createdAt: DateTime.parse(json['createdAt'] as String),
  resolvedAt: json['resolvedAt'] == null
      ? null
      : DateTime.parse(json['resolvedAt'] as String),
  reviewStatus: json['reviewStatus'] as String? ?? 'open',
  assignedTo: json['assignedTo'] as String?,
);

Map<String, dynamic> _$AiReviewQueueItemModelToJson(
  _AiReviewQueueItemModel instance,
) => <String, dynamic>{
  'id': instance.id,
  'productId': instance.productId,
  'sellerId': instance.sellerId,
  'reportId': instance.reportId,
  'status': instance.status,
  'reason': instance.reason,
  'priority': instance.priority,
  'createdAt': instance.createdAt.toIso8601String(),
  'resolvedAt': instance.resolvedAt?.toIso8601String(),
  'reviewStatus': instance.reviewStatus,
  'assignedTo': instance.assignedTo,
};
