// ============================================================================
// Mozzy DocHeader
// Module        : Marketplace Domain
// File          : lib/mozzy_ii/domains/marketplace/repositories/in_memory_ai_verification_report_repository.dart
// Purpose       : 테스트 및 통합 테스트를 위한 인메모리 AI 리포트 저장소.
// ============================================================================

import 'dart:async';
import '../models/ai_verification_report_model.dart';
import '../models/ai_review_queue_item_model.dart';
import 'ai_verification_report_repository.dart';

class InMemoryAiVerificationReportRepository
    implements AiVerificationReportRepository {
  final Map<String, List<AiVerificationReportModel>> _reports = {};
  final Map<String, AiReviewQueueItemModel> _queue = {};

  @override
  Future<void> saveReport(AiVerificationReportModel report) async {
    if (!_reports.containsKey(report.productId)) {
      _reports[report.productId] = [];
    }
    _reports[report.productId]!.add(report);
  }

  @override
  Future<List<AiVerificationReportModel>> fetchReportsByProduct(
    String productId, {
    int limit = 20,
  }) async {
    final list = _reports[productId] ?? [];
    final sorted = List<AiVerificationReportModel>.from(list)
      ..sort((a, b) => b.createdAt.compareTo(a.createdAt));
    return sorted.take(limit).toList();
  }

  @override
  Future<void> enqueueReviewIfNeeded({
    required AiVerificationReportModel report,
  }) async {
    if (report.status == 'passed') return;

    final queueItem = AiReviewQueueItemModel(
      id: report.id,
      productId: report.productId,
      sellerId: report.sellerId,
      reportId: report.id,
      status: report.status,
      reason: report.summary,
      priority: report.status == 'error' ? 'high' : 'normal',
      createdAt: DateTime.now().toUtc(),
    );

    _queue[queueItem.id] = queueItem;
  }

  @override
  Future<List<AiReviewQueueItemModel>> fetchOpenReviewQueue({
    int limit = 50,
  }) async {
    final openItems = _queue.values
        .where((item) => item.reviewStatus == 'open')
        .toList();

    final sorted = openItems
      ..sort((a, b) => b.createdAt.compareTo(a.createdAt));

    return sorted.take(limit).toList();
  }

  @override
  Future<void> resolveReviewItem({
    required String itemId,
    required String reviewerId,
    required String decision, // approved | rejected | dismissed
    String? note,
  }) async {
    final item = _queue[itemId];
    if (item == null) return;

    _queue[itemId] = item.copyWith(
      reviewStatus: decision == 'dismissed' ? 'dismissed' : 'resolved',
      reviewerId: reviewerId,
      reviewerDecision: decision,
      reviewerNote: note,
      resolvedAt: DateTime.now().toUtc(),
    );
  }

  // 테스트를 위한 편의용
  List<AiReviewQueueItemModel> get queueItems => _queue.values.toList();

  void clear() {
    _reports.clear();
    _queue.clear();
  }
}
