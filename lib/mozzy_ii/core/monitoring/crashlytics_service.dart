import 'dart:async';
import 'dart:ui';

import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/foundation.dart';

class CrashlyticsService {
  CrashlyticsService._();

  @visibleForTesting
  static FirebaseCrashlytics? mockInstance;

  static FirebaseCrashlytics get _instance => mockInstance ?? FirebaseCrashlytics.instance;

  static Future<void> initialize({
    required String appEnv,
    required bool enabled,
  }) async {
    await _instance.setCrashlyticsCollectionEnabled(enabled);

    await _instance.setCustomKey('app_env', appEnv);
    await _instance.setCustomKey('private_beta', true);

    FlutterError.onError = (FlutterErrorDetails details) {
      FlutterError.presentError(details);
      _instance.recordFlutterFatalError(details);
    };

    PlatformDispatcher.instance.onError = (Object error, StackTrace stack) {
      _instance.recordError(
        error,
        stack,
        fatal: true,
      );
      return true;
    };
  }

  static Future<void> recordNonFatal(
    Object error,
    StackTrace stack, {
    String? reason,
    Map<String, Object?> context = const {},
  }) async {
    for (final entry in context.entries) {
      final value = entry.value;
      if (value == null) continue;
      await _instance.setCustomKey(entry.key, value);
    }

    await _instance.recordError(
      error,
      stack,
      reason: reason,
      fatal: false,
    );
  }
}
