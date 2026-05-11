import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'notification_navigation_service.dart';
import 'fcm_token_service.dart';
import '../auth/auth_service.dart';
import '../navigation/app_router.dart';

final notificationServiceProvider = Provider<NotificationService>((ref) {
  return NotificationService(ref);
});

class NotificationService {
  final Ref _ref;

  NotificationService(this._ref);

  Future<void> initialize() async {
    final messaging = FirebaseMessaging.instance;

    // 1. Listen for auth changes to manage tokens
    _ref.listen(authStateProvider, (previous, next) async {
      final user = next.value;
      if (user != null) {
        // User logged in, initialize token management
        await _ref.read(fcmTokenServiceProvider).initialize(user.uid);
      } else if (previous?.value != null) {
        // User logged out, deactivate token
        await _ref.read(fcmTokenServiceProvider).deactivateToken(previous!.value!.uid);
      }
    });

    // 2. Handle background message opened app
    FirebaseMessaging.onMessageOpenedApp.listen(_handleMessage);

    // 3. Handle initial message (terminated state)
    final initialMessage = await messaging.getInitialMessage();
    if (initialMessage != null) {
      _handleMessage(initialMessage);
    }

    // 4. Foreground message handling
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      // In foreground, we might show a toast or just let the badge update
      debugPrint('Got a message whilst in the foreground!');
      debugPrint('Message data: ${message.data}');
      if (message.notification != null) {
        debugPrint('Message also contained a notification: ${message.notification}');
      }
    });
  }

  void _handleMessage(RemoteMessage message) {
    final router = _ref.read(routerProvider);
    final navService = NotificationNavigationService(router);
    navService.handleFcmPayload(message.data);
  }
}
