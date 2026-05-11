import 'package:cloud_functions/cloud_functions.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'dart:io';
import 'package:flutter/foundation.dart';
import '../../../core/monitoring/crashlytics_service.dart';
import '../../../core/monitoring/performance_monitoring_service.dart';

class AccountDeletionService {
  final FirebaseFunctions _functions;

  AccountDeletionService(this._functions);

  Future<void> requestAccountDeletion({String? reason}) async {
    return await PerformanceMonitoringService.trace(
      name: 'account_deletion_request',
      action: () async {
        try {
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

          final countryCode = 'ID'; // Default for Beta 1

          final callable = _functions.httpsCallable('requestAccountDeletion');
          await callable.call({
            'reason': reason,
            'appVersion': appVersion,
            'platform': platform,
            'countryCode': countryCode,
          });

          // Successfully requested. The user will be logged out by the AuthGate 
          // once the trigger deletes the user, or we can sign out here.
          await FirebaseAuth.instance.signOut();
        } catch (e, st) {
          await CrashlyticsService.recordNonFatal(
            e,
            st,
            reason: 'account_deletion_request_failed',
          );
          rethrow;
        }
      },
    );
  }
}
