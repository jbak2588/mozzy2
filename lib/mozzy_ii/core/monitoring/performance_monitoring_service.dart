import 'package:firebase_performance/firebase_performance.dart';
import 'package:flutter/foundation.dart';

class PerformanceMonitoringService {
  PerformanceMonitoringService._();

  @visibleForTesting
  static FirebasePerformance? mockInstance;

  static FirebasePerformance get _instance => mockInstance ?? FirebasePerformance.instance;

  static Future<void> initialize({
    required bool enabled,
  }) async {
    await _instance.setPerformanceCollectionEnabled(enabled);
  }

  static Future<T> trace<T>({
    required String name,
    required Future<T> Function() action,
    Map<String, String> attributes = const {},
  }) async {
    final trace = _instance.newTrace(name);
    for (final entry in attributes.entries) {
      trace.putAttribute(entry.key, entry.value);
    }

    await trace.start();
    try {
      return await action();
    } finally {
      await trace.stop();
    }
  }
}
