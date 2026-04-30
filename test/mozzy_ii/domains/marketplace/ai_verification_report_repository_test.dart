import 'package:flutter_test/flutter_test.dart';
import 'package:mozzy/mozzy_ii/domains/marketplace/models/ai_verification_report_model.dart';
import 'package:mozzy/mozzy_ii/domains/marketplace/repositories/in_memory_ai_verification_report_repository.dart';

void main() {
  group('InMemoryAiVerificationReportRepository', () {
    late InMemoryAiVerificationReportRepository repo;

    setUp(() {
      repo = InMemoryAiVerificationReportRepository();
    });

    AiVerificationReportModel createSampleReport({
      required String id,
      required String productId,
      String status = 'passed',
      DateTime? createdAt,
      double score = 0.9,
    }) {
      return AiVerificationReportModel(
        id: id,
        productId: productId,
        sellerId: 'u1',
        status: status,
        score: score,
        summary: 'Summary $id',
        createdAt: createdAt ?? DateTime.now().toUtc(),
      );
    }

    test('saveReport and fetchReportsByProduct', () async {
      final r1 = createSampleReport(id: 'r1', productId: 'p1');
      await repo.saveReport(r1);

      final reports = await repo.fetchReportsByProduct('p1');
      expect(reports.length, 1);
      expect(reports.first.id, 'r1');
    });

    test('fetchReportsByProduct returns sorted by createdAt descending', () async {
      final r1 = createSampleReport(id: 'r1', productId: 'p1', createdAt: DateTime.utc(2026, 1, 1));
      final r2 = createSampleReport(id: 'r2', productId: 'p1', createdAt: DateTime.utc(2026, 1, 3));
      final r3 = createSampleReport(id: 'r3', productId: 'p1', createdAt: DateTime.utc(2026, 1, 2));

      await repo.saveReport(r1);
      await repo.saveReport(r2);
      await repo.saveReport(r3);

      final reports = await repo.fetchReportsByProduct('p1');
      expect(reports[0].id, 'r2');
      expect(reports[1].id, 'r3');
      expect(reports[2].id, 'r1');
    });

    test('passed report does not create queue item', () async {
      final r1 = createSampleReport(id: 'r1', productId: 'p1', status: 'passed');
      await repo.enqueueReviewIfNeeded(report: r1);

      final queue = await repo.fetchOpenReviewQueue();
      expect(queue.isEmpty, isTrue);
    });

    test('needs_review report creates queue item', () async {
      final r1 = createSampleReport(id: 'r1', productId: 'p1', status: 'needs_review');
      await repo.enqueueReviewIfNeeded(report: r1);

      final queue = await repo.fetchOpenReviewQueue();
      expect(queue.length, 1);
      expect(queue.first.reportId, 'r1');
      expect(queue.first.status, 'needs_review');
      expect(queue.first.reviewStatus, 'open');
    });

    test('failed report creates queue item', () async {
      final r1 = createSampleReport(id: 'r1', productId: 'p1', status: 'failed');
      await repo.enqueueReviewIfNeeded(report: r1);

      final queue = await repo.fetchOpenReviewQueue();
      expect(queue.length, 1);
      expect(queue.first.status, 'failed');
    });

    test('error report creates queue item', () async {
      final r1 = createSampleReport(id: 'r1', productId: 'p1', status: 'error');
      await repo.enqueueReviewIfNeeded(report: r1);

      final queue = await repo.fetchOpenReviewQueue();
      expect(queue.length, 1);
      expect(queue.first.status, 'error');
    });

    test('fetchOpenReviewQueue returns only open items and sorted', () async {
      final r1 = createSampleReport(id: 'r1', productId: 'p1', status: 'needs_review', createdAt: DateTime.utc(2026, 1, 1));
      final r2 = createSampleReport(id: 'r2', productId: 'p2', status: 'failed', createdAt: DateTime.utc(2026, 1, 2));
      
      await repo.enqueueReviewIfNeeded(report: r1);
      await Future.delayed(const Duration(milliseconds: 10));
      await repo.enqueueReviewIfNeeded(report: r2);

      final queue = await repo.fetchOpenReviewQueue();
      expect(queue.length, 2);
      expect(queue[0].reportId, 'r2');
      expect(queue[1].reportId, 'r1');
    });
  });
}
