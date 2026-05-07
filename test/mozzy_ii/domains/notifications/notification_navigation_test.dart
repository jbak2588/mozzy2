import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:mockito/annotations.dart';
import 'package:go_router/go_router.dart';
import 'package:mozzy/mozzy_ii/app/notifications/notification_navigation_service.dart';
import 'package:mozzy/mozzy_ii/domains/notifications/models/mozzy_notification_model.dart';

@GenerateMocks([GoRouter])
import 'notification_navigation_test.mocks.dart';

void main() {
  late MockGoRouter mockRouter;
  late NotificationNavigationService navService;

  setUp(() {
    mockRouter = MockGoRouter();
    // GoRouter.push returns a Future<T?>
    when(mockRouter.push(any)).thenAnswer((_) => Future.value(null));
    navService = NotificationNavigationService(mockRouter);
  });

  group('NotificationNavigationService Tests', () {
    test('handleFcmPayload should navigate to chat room when type is marketplace_chat_message', () {
      final payload = {
        'type': 'marketplace_chat_message',
        'chatRoomId': 'room123',
      };

      navService.handleFcmPayload(payload);

      verify(mockRouter.push('/chat/room123')).called(1);
    });

    test('handleFcmPayload should navigate to deal detail when type is marketplace_deal_update', () {
      final payload = {
        'type': 'marketplace_deal_update',
        'dealId': 'deal456',
      };

      navService.handleFcmPayload(payload);

      verify(mockRouter.push('/marketplace/deals/deal456')).called(1);
    });

    test('handleNotificationClick should navigate using explicit route if provided', () {
      final notification = MozzyNotificationModel(
        id: '1',
        recipientId: 'user1',
        notificationType: 'custom',
        titleKey: 'title',
        bodyKey: 'body',
        titleParams: {},
        bodyParams: {},
        isRead: false,
        route: '/custom/path',
        createdAt: DateTime.now(),
      );

      navService.handleNotificationClick(notification);

      verify(mockRouter.push('/custom/path')).called(1);
    });
  });
}
