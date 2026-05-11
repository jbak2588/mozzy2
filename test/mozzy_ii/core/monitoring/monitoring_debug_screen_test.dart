import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:mockito/annotations.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:firebase_performance/firebase_performance.dart';
import 'package:mozzy/mozzy_ii/core/monitoring/screens/monitoring_debug_screen.dart';
import 'package:mozzy/mozzy_ii/core/monitoring/crashlytics_service.dart';
import 'package:mozzy/mozzy_ii/core/monitoring/performance_monitoring_service.dart';

@GenerateMocks([FirebaseCrashlytics, FirebasePerformance])
import 'monitoring_debug_screen_test.mocks.dart';

void main() {
  testWidgets('MonitoringDebugScreen renders buttons', (WidgetTester tester) async {
    final mockCrash = MockFirebaseCrashlytics();
    final mockPerf = MockFirebasePerformance();
    
    CrashlyticsService.mockInstance = mockCrash;
    PerformanceMonitoringService.mockInstance = mockPerf;
    
    // Setup expectations
    when(mockCrash.isCrashlyticsCollectionEnabled).thenReturn(true);
    when(mockPerf.isPerformanceCollectionEnabled()).thenAnswer((_) async => true);

    await tester.pumpWidget(
      const MaterialApp(
        home: MonitoringDebugScreen(),
      ),
    );

    // Verify title
    expect(find.text('Monitoring Debug'), findsOneWidget);

    // Verify buttons exist
    expect(find.text('Send test non-fatal error'), findsOneWidget);
    expect(find.text('Force test crash'), findsOneWidget);
    expect(find.text('Run performance test trace'), findsOneWidget);
    
    // Status indicators
    expect(find.text('Crashlytics Status'), findsOneWidget);
    expect(find.text('Performance Status'), findsOneWidget);
  });
}
