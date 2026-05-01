// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'admin_audit_log_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_AdminAuditLogModel _$AdminAuditLogModelFromJson(Map<String, dynamic> json) =>
    _AdminAuditLogModel(
      id: json['id'] as String,
      action: json['action'] as String,
      queueItemId: json['queueItemId'] as String,
      productId: json['productId'] as String,
      reportId: json['reportId'] as String?,
      reviewerId: json['reviewerId'] as String,
      reviewerRole: json['reviewerRole'] as String,
      previousReviewStatus: json['previousReviewStatus'] as String,
      newReviewStatus: json['newReviewStatus'] as String,
      decision: json['decision'] as String,
      noteSummary: json['noteSummary'] as String?,
      createdAt: DateTime.parse(json['createdAt'] as String),
      source: json['source'] as String? ?? 'admin_review_screen',
    );

Map<String, dynamic> _$AdminAuditLogModelToJson(_AdminAuditLogModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'action': instance.action,
      'queueItemId': instance.queueItemId,
      'productId': instance.productId,
      'reportId': instance.reportId,
      'reviewerId': instance.reviewerId,
      'reviewerRole': instance.reviewerRole,
      'previousReviewStatus': instance.previousReviewStatus,
      'newReviewStatus': instance.newReviewStatus,
      'decision': instance.decision,
      'noteSummary': instance.noteSummary,
      'createdAt': instance.createdAt.toIso8601String(),
      'source': instance.source,
    };
