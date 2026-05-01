// ============================================================================
// Mozzy DocHeader
// Module        : Marketplace Domain
// File          : lib/mozzy_ii/domains/marketplace/repositories/in_memory_admin_audit_log_repository.dart
// Purpose       : 테스트 및 통합 테스트를 위한 인메모리 감사 로그 저장소.
// ============================================================================

import '../models/admin_audit_log_model.dart';
import 'admin_audit_log_repository.dart';

class InMemoryAdminAuditLogRepository implements AdminAuditLogRepository {
  final List<AdminAuditLogModel> _logs = [];

  List<AdminAuditLogModel> get logs => List.unmodifiable(_logs);

  @override
  Future<void> recordModerationAction(AdminAuditLogModel log) async {
    _logs.add(log);
    // Sort newest first
    _logs.sort((a, b) => b.createdAt.compareTo(a.createdAt));
  }

  @override
  Future<List<AdminAuditLogModel>> fetchAuditLogsByProduct({
    required String productId,
    int limit = 20,
  }) async {
    return _logs
        .where((log) => log.productId == productId)
        .take(limit)
        .toList();
  }

  @override
  Future<List<AdminAuditLogModel>> fetchRecentAuditLogs({
    int limit = 50,
  }) async {
    return _logs.take(limit).toList();
  }

  void clear() {
    _logs.clear();
  }
}
