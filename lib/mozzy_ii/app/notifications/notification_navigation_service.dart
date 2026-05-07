import 'package:go_router/go_router.dart';
import '../../domains/notifications/models/mozzy_notification_model.dart';

class NotificationNavigationService {
  final GoRouter _router;

  NotificationNavigationService(this._router);

  void handleNotificationClick(MozzyNotificationModel notification) {
    if (notification.route != null) {
      _router.push(notification.route!);
    } else if (notification.notificationType == 'marketplace_chat_message') {
      if (notification.chatRoomId != null) {
        _router.push('/chat/${notification.chatRoomId}');
      }
    } else if (notification.notificationType == 'marketplace_deal_update') {
      if (notification.dealId != null) {
        _router.push('/marketplace/deals/${notification.dealId}');
      }
    } else if (notification.notificationType == 'job_application_received') {
      if (notification.jobId != null) {
        _router.push('/jobs/${notification.jobId}/applicants');
      }
    } else if (notification.notificationType == 'job_applicant_status_updated') {
      if (notification.jobId != null) {
        _router.push('/jobs/${notification.jobId}');
      }
    }
  }

  void handleFcmPayload(Map<String, dynamic> data) {
    final route = data['route'] as String?;
    final type = data['type'] as String?;
    final chatRoomId = data['chatRoomId'] as String?;
    final dealId = data['dealId'] as String?;

    if (route != null) {
      _router.push(route);
    } else if (type == 'marketplace_chat_message') {
      if (chatRoomId != null) {
        _router.push('/chat/$chatRoomId');
      }
    } else if (type == 'marketplace_deal_update') {
      if (dealId != null) {
        _router.push('/marketplace/deals/$dealId');
      }
    } else if (type == 'job_application_received') {
      final jobId = data['jobId'] as String?;
      if (jobId != null) {
        _router.push('/jobs/$jobId/applicants');
      }
    } else if (type == 'job_applicant_status_updated') {
      final jobId = data['jobId'] as String?;
      if (jobId != null) {
        _router.push('/jobs/$jobId');
      }
    }
  }
}
