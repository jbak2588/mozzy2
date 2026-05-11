import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../../../core/monitoring/crashlytics_service.dart';
import '../models/report_model.dart';
import '../repositories/report_repository.dart';

class ModerationService {
  final ReportRepository _reportRepository;
  final FirebaseFirestore _firestore;

  ModerationService(this._reportRepository, this._firestore);

  Future<void> submitReport({
    required ReportTargetType targetType,
    required String targetId,
    required String? targetOwnerId,
    required ReportReason reason,
    String? description,
    String? sourceRoute,
  }) async {
    try {
      final user = FirebaseAuth.instance.currentUser;
      if (user == null) {
        throw Exception('User must be logged in to submit a report');
      }

      final report = ReportModel(
        id: '', // Will be assigned by repository
        targetType: targetType,
        targetId: targetId,
        targetOwnerId: targetOwnerId,
        reporterId: user.uid,
        reason: reason,
        description: description,
        createdAt: DateTime.now(),
        sourceRoute: sourceRoute,
      );

      await _reportRepository.createReport(report);
    } catch (e, st) {
      await CrashlyticsService.recordNonFatal(
        e,
        st,
        reason: 'report_submit_failed',
        context: {'target_type': targetType.name, 'target_id': targetId},
      );
      rethrow;
    }
  }

  Future<void> hideContent({
    required ReportTargetType targetType,
    required String targetId,
    required String reason,
    String countryCode = 'ID',
  }) async {
    try {
      final user = FirebaseAuth.instance.currentUser;
      if (user == null) {
        throw Exception('Admin must be logged in');
      }

      DocumentReference targetRef;
      switch (targetType) {
        case ReportTargetType.news:
          targetRef = _firestore.doc('countries/$countryCode/domains/local_news/posts/$targetId');
          break;
        case ReportTargetType.marketplace:
          targetRef = _firestore.doc('countries/$countryCode/domains/marketplace/products/$targetId');
          break;
        case ReportTargetType.jobs:
          targetRef = _firestore.doc('job_posts/$targetId');
          break;
        default:
          throw UnimplementedError('Hiding content for $targetType is not implemented yet.');
      }

      await targetRef.update({
        'moderationStatus': ModerationStatus.hidden.name,
        'hiddenAt': FieldValue.serverTimestamp(),
        'hiddenBy': user.uid,
        'hiddenReason': reason,
      });
    } catch (e, st) {
      await CrashlyticsService.recordNonFatal(
        e,
        st,
        reason: 'hide_content_failed',
        context: {'target_type': targetType.name, 'target_id': targetId},
      );
      rethrow;
    }
  }

  Future<void> dismissReport({
    required String reportId,
    String? adminNote,
  }) async {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) {
      throw Exception('Admin must be logged in');
    }

    await _reportRepository.updateReportStatus(
      reportId,
      ReportStatus.dismissed,
      user.uid,
      adminNote: adminNote,
    );
  }
  
  Future<void> actionTakenReport({
    required String reportId,
    String? adminNote,
  }) async {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) {
      throw Exception('Admin must be logged in');
    }

    await _reportRepository.updateReportStatus(
      reportId,
      ReportStatus.actionTaken,
      user.uid,
      adminNote: adminNote,
    );
  }
}
