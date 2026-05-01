// ============================================================================
// Mozzy DocHeader
// Module        : Marketplace Domain
// File          : lib/mozzy_ii/domains/marketplace/models/admin_audit_log_model.dart
// Purpose       : 관리자 작업 감사 로그(Audit Log) 데이터 모델.
// ============================================================================

import 'package:freezed_annotation/freezed_annotation.dart';

part 'admin_audit_log_model.freezed.dart';
part 'admin_audit_log_model.g.dart';

@freezed
abstract class AdminAuditLogModel with _$AdminAuditLogModel {
  const AdminAuditLogModel._();

  const factory AdminAuditLogModel({
    required String id,
    required String action, // approve | reject | dismiss
    required String queueItemId,
    required String productId,
    String? reportId,
    required String reviewerId,
    required String reviewerRole,
    required String previousReviewStatus,
    required String newReviewStatus,
    required String decision,
    String? noteSummary,
    required DateTime createdAt,
    @Default('admin_review_screen') String source,
  }) = _AdminAuditLogModel;

  factory AdminAuditLogModel.fromJson(Map<String, dynamic> json) =>
      _$AdminAuditLogModelFromJson(json);
}
