import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../repositories/monetization_audit_repository.dart';
import '../models/monetization_audit_log_model.dart';

part 'monetization_audit_provider.g.dart';

@riverpod
MonetizationAuditRepository monetizationAuditRepository(Ref ref) {
  return MonetizationAuditRepository();
}

@riverpod
Stream<List<MonetizationAuditLogModel>> recentAuditLogs(Ref ref, {int limit = 50}) {
  return ref
      .watch(monetizationAuditRepositoryProvider)
      .watchRecentAuditLogs(limit: limit);
}

@riverpod
Stream<List<MonetizationAuditLogModel>> auditLogsByType(Ref ref, String type,
    {int limit = 50}) {
  return ref
      .watch(monetizationAuditRepositoryProvider)
      .watchAuditLogsByType(type, limit: limit);
}

@riverpod
Stream<List<MonetizationAuditLogModel>> jobBoostAuditLogs(Ref ref, String jobId) {
  return ref.watch(monetizationAuditRepositoryProvider).watchLogsByJobId(jobId);
}

@riverpod
Stream<List<MonetizationAuditLogModel>> paymentAuditLogs(Ref ref, String paymentId) {
  return ref.watch(monetizationAuditRepositoryProvider).watchLogsByPaymentId(paymentId);
}
