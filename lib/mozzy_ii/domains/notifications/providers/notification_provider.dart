import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../repositories/notification_repository.dart';
import '../models/mozzy_notification_model.dart';
import '../../../app/auth/auth_service.dart';

final notificationRepositoryProvider = Provider<NotificationRepository>((ref) {
  return FirestoreNotificationRepository(FirebaseFirestore.instance);
});

final notificationsStreamProvider = StreamProvider<List<MozzyNotificationModel>>((ref) {
  final authState = ref.watch(authStateProvider);
  final user = authState.value;
  if (user == null) return Stream.value([]);
  
  return ref.watch(notificationRepositoryProvider).watchNotifications(user.uid);
});

final unreadNotificationsCountProvider = Provider<int>((ref) {
  final notifications = ref.watch(notificationsStreamProvider).value ?? [];
  return notifications.where((n) => !n.isRead).length;
});
