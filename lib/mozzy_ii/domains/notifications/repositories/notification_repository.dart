import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/mozzy_notification_model.dart';

abstract class NotificationRepository {
  Stream<List<MozzyNotificationModel>> watchNotifications(String userId);
  Future<void> markAsRead(String notificationId);
  Future<void> markAllAsRead(String userId);
  Future<void> markChatNotificationsAsRead(String userId, String chatRoomId);
  Future<void> deleteNotification(String notificationId);
}

class FirestoreNotificationRepository implements NotificationRepository {
  final FirebaseFirestore _firestore;

  FirestoreNotificationRepository(this._firestore);

  CollectionReference get _notificationsRef => _firestore.collection('notifications');

  @override
  Stream<List<MozzyNotificationModel>> watchNotifications(String userId) {
    return _notificationsRef
        .where('recipientId', isEqualTo: userId)
        .orderBy('createdAt', descending: true)
        .limit(50)
        .snapshots()
        .map((snapshot) => snapshot.docs
            .map((doc) => MozzyNotificationModel.fromJson(doc.data() as Map<String, dynamic>))
            .toList());
  }

  @override
  Future<void> markAsRead(String notificationId) async {
    await _notificationsRef.doc(notificationId).update({'isRead': true});
  }

  @override
  Future<void> markAllAsRead(String userId) async {
    final snapshot = await _notificationsRef
        .where('recipientId', isEqualTo: userId)
        .where('isRead', isEqualTo: false)
        .get();

    final batch = _firestore.batch();
    for (var doc in snapshot.docs) {
      batch.update(doc.reference, {'isRead': true});
    }
    await batch.commit();
  }

  @override
  Future<void> markChatNotificationsAsRead(String userId, String chatRoomId) async {
    final snapshot = await _notificationsRef
        .where('recipientId', isEqualTo: userId)
        .where('chatRoomId', isEqualTo: chatRoomId)
        .where('isRead', isEqualTo: false)
        .get();

    final batch = _firestore.batch();
    for (var doc in snapshot.docs) {
      batch.update(doc.reference, {'isRead': true});
    }
    await batch.commit();
  }

  @override
  Future<void> deleteNotification(String notificationId) async {
    await _notificationsRef.doc(notificationId).delete();
  }
}
