// ============================================================================
// Mozzy DocHeader
// Module        : Marketplace Domain
// File          : lib/mozzy_ii/domains/marketplace/repositories/ai_verification_report_repository.dart
// Purpose       : AI 검수 리포트 및 검토 대기열 Firestore 저장소.
// ============================================================================

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import '../models/ai_verification_report_model.dart';
import '../models/ai_review_queue_item_model.dart';

class AiVerificationReportRepository {
  final FirebaseFirestore _firestore;

  AiVerificationReportRepository({FirebaseFirestore? firestore})
      : _firestore = firestore ?? FirebaseFirestore.instance;

  /// AI 리포트 저장 (상품 하위 컬렉션)
  Future<void> saveReport(AiVerificationReportModel report) async {
    try {
      await _firestore
          .collection('countries')
          .doc('ID')
          .collection('domains')
          .doc('marketplace')
          .collection('products')
          .doc(report.productId)
          .collection('ai_reports')
          .doc(report.id)
          .set(report.toJson());
    } catch (e) {
      debugPrint('Error saving AI report: $e');
      // non-blocking
    }
  }

  /// 특정 상품의 AI 리포트 이력 조회
  Future<List<AiVerificationReportModel>> fetchReportsByProduct(
    String productId, {
    int limit = 20,
  }) async {
    try {
      final snapshot = await _firestore
          .collection('countries')
          .doc('ID')
          .collection('domains')
          .doc('marketplace')
          .collection('products')
          .doc(productId)
          .collection('ai_reports')
          .orderBy('createdAt', descending: true)
          .limit(limit)
          .get();

      return snapshot.docs
          .map((doc) => AiVerificationReportModel.fromJson(doc.data()))
          .toList();
    } catch (e) {
      debugPrint('Error fetching AI reports: $e');
      return [];
    }
  }

  /// 필요 시 검토 대기열에 추가 (status가 passed가 아닌 경우)
  Future<void> enqueueReviewIfNeeded({
    required AiVerificationReportModel report,
  }) async {
    if (report.status == 'passed') return;

    try {
      final queueItem = AiReviewQueueItemModel(
        id: report.id, // 리포트 ID와 동일하게 설정하여 중복 방지
        productId: report.productId,
        sellerId: report.sellerId,
        reportId: report.id,
        status: report.status,
        reason: report.summary,
        priority: _determinePriority(report),
        createdAt: DateTime.now().toUtc(),
      );

      await _firestore
          .collection('countries')
          .doc('ID')
          .collection('domains')
          .doc('marketplace')
          .collection('ai_review_queue')
          .doc(queueItem.id)
          .set(queueItem.toJson());
    } catch (e) {
      debugPrint('Error enqueuing AI review: $e');
      // non-blocking
    }
  }

  /// 관리자 검토 대기열 조회
  Future<List<AiReviewQueueItemModel>> fetchOpenReviewQueue({
    int limit = 50,
  }) async {
    try {
      final snapshot = await _firestore
          .collection('countries')
          .doc('ID')
          .collection('domains')
          .doc('marketplace')
          .collection('ai_review_queue')
          .where('reviewStatus', isEqualTo: 'open')
          .orderBy('createdAt', descending: true)
          .limit(limit)
          .get();

      return snapshot.docs
          .map((doc) => AiReviewQueueItemModel.fromJson(doc.data()))
          .toList();
    } catch (e) {
      debugPrint('Error fetching AI review queue: $e');
      return [];
    }
  }

  /// 검토 항목 처리 (승인/거절/무시)
  Future<void> resolveReviewItem({
    required String itemId,
    required String reviewerId,
    required String decision, // approved | rejected | dismissed
    String? note,
  }) async {
    try {
      final now = DateTime.now().toUtc();
      await _firestore
          .collection('countries')
          .doc('ID')
          .collection('domains')
          .doc('marketplace')
          .collection('ai_review_queue')
          .doc(itemId)
          .update({
        'reviewStatus': decision == 'dismissed' ? 'dismissed' : 'resolved',
        'reviewerId': reviewerId,
        'reviewerDecision': decision,
        'reviewerNote': note,
        'resolvedAt': now,
      });
    } catch (e) {
      debugPrint('Error resolving AI review item: $e');
      rethrow;
    }
  }

  String _determinePriority(AiVerificationReportModel report) {
    if (report.status == 'error') return 'high';
    if (report.score < 0.3) return 'high';
    return 'normal';
  }
}
