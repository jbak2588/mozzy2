import 'package:freezed_annotation/freezed_annotation.dart';
import '../../marketplace/models/product_model.dart'; // For SafeDateTimeConverter

part 'monetization_audit_log_model.freezed.dart';
part 'monetization_audit_log_model.g.dart';

@freezed
abstract class MonetizationAuditLogModel with _$MonetizationAuditLogModel {
  const factory MonetizationAuditLogModel({
    required String id,
    required String type, // payment_created, payment_status_changed, job_boost_activated, job_boost_expired
    required String relatedDomain, // payments, jobs
    required String relatedId,
    String? paymentId,
    String? jobId,
    required String actorType, // system, user, webhook, scheduler
    String? actorId,
    String? beforeStatus,
    String? afterStatus,
    int? amount,
    String? currency,
    @Default({}) Map<String, dynamic> metadata,
    @SafeDateTimeConverter() required DateTime createdAt,
  }) = _MonetizationAuditLogModel;

  const MonetizationAuditLogModel._();

  bool get isPaymentEvent =>
      type.startsWith('payment_') || relatedDomain == 'payments';
  bool get isJobBoostEvent =>
      type.startsWith('job_boost_') || relatedDomain == 'jobs';

  String get displayTypeKey => 'admin.$type';

  factory MonetizationAuditLogModel.fromJson(Map<String, dynamic> json) =>
      _$MonetizationAuditLogModelFromJson(json);
}
