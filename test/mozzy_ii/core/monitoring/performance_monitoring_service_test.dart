import 'package:flutter_test/flutter_test.dart';
import 'package:firebase_performance/firebase_performance.dart';
import 'package:mockito/mockito.dart';
import 'package:mockito/annotations.dart';
import 'package:mozzy/mozzy_ii/core/monitoring/performance_monitoring_service.dart';

@GenerateMocks([FirebasePerformance, Trace])
import 'performance_monitoring_service_test.mocks.dart';

void main() {
  test('PerformanceMonitoringService trace returns action result', () async {
    final mockPerf = MockFirebasePerformance();
    final mockTrace = MockTrace();
    
    PerformanceMonitoringService.mockInstance = mockPerf;
    
    when(mockPerf.newTrace(any)).thenReturn(mockTrace);
    when(mockTrace.start()).thenAnswer((_) async => {});
    when(mockTrace.stop()).thenAnswer((_) async => {});
    
    final result = await PerformanceMonitoringService.trace<int>(
      name: 'test_trace',
      action: () async {
        return 42;
      },
    );

    expect(result, 42);
    verify(mockPerf.newTrace('test_trace')).called(1);
    verify(mockTrace.start()).called(1);
    verify(mockTrace.stop()).called(1);
  });
}
