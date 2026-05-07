import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:mockito/annotations.dart';
import 'package:go_router/go_router.dart';
import 'package:mozzy/mozzy_ii/app/notifications/notification_navigation_service.dart';
import 'package:mozzy/mozzy_ii/domains/notifications/models/mozzy_notification_model.dart';

@GenerateNiceMocks([MockSpec<GoRouter>()])
import 'jobs_notification_navigation_test.mocks.dart';

void main() {
  late NotificationNavigationService service;
  late MockGoRouter mockRouter;

  setUp(() {
    mockRouter = MockGoRouter();
    service = NotificationNavigationService(mockRouter);
  });

  group('NotificationNavigationService - Jobs', () {
    test('should navigate to applicants list on job_application_received', () {
      final notification = MozzyNotificationModel(
        id: '1',
        recipientId: 'owner1',
        notificationType: 'job_application_received',
        titleKey: 'key',
        bodyKey: 'key',
        jobId: 'job123',
        createdAt: DateTime.now(),
      );

      service.handleNotificationClick(notification);

      verify(mockRouter.push('/jobs/job123/applicants')).called(1);
    });

    test('should navigate to job detail on job_applicant_status_updated', () {
      final notification = MozzyNotificationModel(
        id: '1',
        recipientId: 'app1',
        notificationType: 'job_applicant_status_updated',
        titleKey: 'key',
        bodyKey: 'key',
        jobId: 'job123',
        createdAt: DateTime.now(),
      );

      service.handleNotificationClick(notification);

      verify(mockRouter.push('/jobs/job123')).called(1);
    });

    test('should handle FCM payload for Jobs', () {
      final data = {
        'type': 'job_application_received',
        'jobId': 'job123',
      };

      service.handleFcmPayload(data);

      verify(mockRouter.push('/jobs/job123/applicants')).called(1);
    });
  });
}
