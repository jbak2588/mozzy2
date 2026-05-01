import 'package:flutter_test/flutter_test.dart';
import 'package:mozzy/mozzy_ii/domains/marketplace/models/admin_audit_log_model.dart';
import 'package:mozzy/mozzy_ii/domains/marketplace/repositories/in_memory_admin_audit_log_repository.dart';

void main() {
  late InMemoryAdminAuditLogRepository repo;

  setUp(() {
    repo = InMemoryAdminAuditLogRepository();
  });

  group('AdminAuditLogRepository (InMemory)', () {
    test('recordModerationAction saves and retrieves logs', () async {
      final log = AdminAuditLogModel(
        id: 'l1',
        action: 'approve',
        queueItemId: 'q1',
        productId: 'p1',
        reviewerId: 'a1',
        reviewerRole: 'admin',
        previousReviewStatus: 'open',
        newReviewStatus: 'resolved',
        decision: 'approved',
        createdAt: DateTime.now(),
      );

      await repo.recordModerationAction(log);
      
      final recent = await repo.fetchRecentAuditLogs();
      expect(recent.length, 1);
      expect(recent.first.id, 'l1');
    });

    test('fetchAuditLogsByProduct filters correctly', () async {
      final log1 = AdminAuditLogModel(
        id: 'l1',
        action: 'approve',
        queueItemId: 'q1',
        productId: 'p1',
        reviewerId: 'a1',
        reviewerRole: 'admin',
        previousReviewStatus: 'open',
        newReviewStatus: 'resolved',
        decision: 'approved',
        createdAt: DateTime.now(),
      );
      final log2 = AdminAuditLogModel(
        id: 'l2',
        action: 'reject',
        queueItemId: 'q2',
        productId: 'p2',
        reviewerId: 'a1',
        reviewerRole: 'admin',
        previousReviewStatus: 'open',
        newReviewStatus: 'resolved',
        decision: 'rejected',
        createdAt: DateTime.now().add(const Duration(seconds: 1)),
      );

      await repo.recordModerationAction(log1);
      await repo.recordModerationAction(log2);
      
      final p1Logs = await repo.fetchAuditLogsByProduct(productId: 'p1');
      expect(p1Logs.length, 1);
      expect(p1Logs.first.productId, 'p1');
    });

    test('logs are sorted newest first', () async {
      final now = DateTime.now();
      final log1 = AdminAuditLogModel(
        id: 'l1',
        action: 'approve',
        queueItemId: 'q1',
        productId: 'p1',
        reviewerId: 'a1',
        reviewerRole: 'admin',
        previousReviewStatus: 'open',
        newReviewStatus: 'resolved',
        decision: 'approved',
        createdAt: now,
      );
      final log2 = AdminAuditLogModel(
        id: 'l2',
        action: 'reject',
        queueItemId: 'q2',
        productId: 'p1',
        reviewerId: 'a1',
        reviewerRole: 'admin',
        previousReviewStatus: 'open',
        newReviewStatus: 'resolved',
        decision: 'rejected',
        createdAt: now.add(const Duration(minutes: 5)),
      );

      await repo.recordModerationAction(log1);
      await repo.recordModerationAction(log2);
      
      final recent = await repo.fetchRecentAuditLogs();
      expect(recent.first.id, 'l2');
      expect(recent.last.id, 'l1');
    });
  });
}
