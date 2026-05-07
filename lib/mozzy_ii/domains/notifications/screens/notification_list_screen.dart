import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:easy_localization/easy_localization.dart';
import '../providers/notification_provider.dart';
import '../models/mozzy_notification_model.dart';
import '../../../app/notifications/notification_navigation_service.dart';
import '../../../app/navigation/app_router.dart';
import '../../../app/auth/auth_service.dart';

class NotificationListScreen extends ConsumerWidget {
  const NotificationListScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final notificationsAsync = ref.watch(notificationsStreamProvider);
    final navService = NotificationNavigationService(ref.watch(routerProvider));

    return Scaffold(
      appBar: AppBar(
        title: Text('notification.title'.tr()),
        actions: [
          IconButton(
            icon: const Icon(Icons.done_all),
            tooltip: 'notification.markAllRead'.tr(),
            onPressed: () {
              final user = ref.read(authStateProvider).value;
              if (user != null) {
                ref.read(notificationRepositoryProvider).markAllAsRead(user.uid);
              }
            },
          ),
        ],
      ),
      body: notificationsAsync.when(
        data: (notifications) {
          if (notifications.isEmpty) {
            return Center(
              child: Text('notification.empty'.tr()),
            );
          }

          return ListView.separated(
            itemCount: notifications.length,
            separatorBuilder: (context, index) => const Divider(height: 1),
            itemBuilder: (context, index) {
              final notification = notifications[index];
              return ListTile(
                leading: _buildLeading(notification),
                title: Text(
                  notification.titleKey.tr(namedArgs: notification.titleParams),
                  style: TextStyle(
                    fontWeight: notification.isRead ? FontWeight.normal : FontWeight.bold,
                  ),
                ),
                subtitle: Text(
                  notification.bodyKey.tr(namedArgs: notification.bodyParams),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                trailing: Text(
                  _formatDate(notification.createdAt),
                  style: Theme.of(context).textTheme.bodySmall,
                ),
                tileColor: notification.isRead ? null : Colors.red.withAlpha(10),
                onTap: () {
                  if (!notification.isRead) {
                    ref.read(notificationRepositoryProvider).markAsRead(notification.id);
                  }
                  navService.handleNotificationClick(notification);
                },
              );
            },
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (err, stack) => Center(child: Text('common.error'.tr())),
      ),
    );
  }

  Widget _buildLeading(MozzyNotificationModel notification) {
    switch (notification.notificationType) {
      case 'marketplace_chat_message':
        return const CircleAvatar(
          backgroundColor: Colors.blue,
          child: Icon(Icons.chat, color: Colors.white, size: 20),
        );
      case 'marketplace_deal_update':
        return const CircleAvatar(
          backgroundColor: Colors.orange,
          child: Icon(Icons.shopping_bag, color: Colors.white, size: 20),
        );
      case 'job_application_received':
        return const CircleAvatar(
          backgroundColor: Colors.green,
          child: Icon(Icons.person_add, color: Colors.white, size: 20),
        );
      case 'job_applicant_status_updated':
        return const CircleAvatar(
          backgroundColor: Colors.teal,
          child: Icon(Icons.assignment_ind, color: Colors.white, size: 20),
        );
      default:
        return const CircleAvatar(
          backgroundColor: Colors.grey,
          child: Icon(Icons.notifications, color: Colors.white, size: 20),
        );
    }
  }

  String _formatDate(DateTime date) {
    final now = DateTime.now();
    final difference = now.difference(date);

    if (difference.inMinutes < 1) return 'now'.tr();
    if (difference.inHours < 1) return '${difference.inMinutes}m';
    if (difference.inDays < 1) return '${difference.inHours}h';
    if (difference.inDays < 7) return '${difference.inDays}d';
    
    return DateFormat('dd MMM').format(date);
  }
}
