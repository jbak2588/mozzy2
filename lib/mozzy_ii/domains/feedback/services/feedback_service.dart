import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:package_info_plus/package_info_plus.dart';
import '../../../core/monitoring/crashlytics_service.dart';
import '../../../core/monitoring/performance_monitoring_service.dart';
import '../models/feedback_model.dart';
import '../repositories/feedback_repository.dart';

class FeedbackService {
  final FeedbackRepository _feedbackRepository;

  FeedbackService(this._feedbackRepository);

  Future<void> submitFeedback({
    required FeedbackType type,
    required String message,
    FeedbackContactPreference contactPreference = FeedbackContactPreference.none,
    String? contactValue,
  }) async {
    return await PerformanceMonitoringService.trace(
      name: 'feedback_submit',
      action: () async {
        try {
          final user = FirebaseAuth.instance.currentUser;
          if (user == null) {
            throw Exception('User must be logged in to submit feedback');
          }

          final packageInfo = await PackageInfo.fromPlatform();
          final appVersion = '${packageInfo.version}+${packageInfo.buildNumber}';
          
          String platform = 'unknown';
          if (kIsWeb) {
            platform = 'web';
          } else if (Platform.isAndroid) {
            platform = 'android';
          } else if (Platform.isIOS) {
            platform = 'ios';
          }

          final appEnv = const String.fromEnvironment('APP_ENV', defaultValue: 'staging');

          final feedback = FeedbackModel(
            id: '', // Assigned by repository
            userId: user.uid,
            type: type,
            message: message,
            contactPreference: contactPreference,
            contactValue: contactValue,
            appVersion: appVersion,
            platform: platform,
            appEnv: appEnv,
            createdAt: DateTime.now(),
            updatedAt: DateTime.now(),
          );

          await _feedbackRepository.createFeedback(feedback);
        } catch (e, st) {
          await CrashlyticsService.recordNonFatal(
            e,
            st,
            reason: 'feedback_submit_failed',
            context: {
              'feedback_type': type.name,
              'app_env': const String.fromEnvironment('APP_ENV', defaultValue: 'staging'),
            },
          );
          rethrow;
        }
      },
    );
  }

  Stream<List<FeedbackModel>> watchOpenFeedback() {
    return _feedbackRepository.watchOpenFeedback();
  }

  Future<void> updateFeedbackStatus({
    required String feedbackId,
    required FeedbackStatus status,
    String? adminNote,
  }) async {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) {
      throw Exception('Admin must be logged in');
    }

    await _feedbackRepository.updateFeedbackStatus(
      feedbackId,
      status,
      user.uid,
      adminNote: adminNote,
    );
  }
}
