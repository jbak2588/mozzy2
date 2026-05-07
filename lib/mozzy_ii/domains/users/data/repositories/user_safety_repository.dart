import 'package:cloud_firestore/cloud_firestore.dart';

class UserSafetyRepository {
  final FirebaseFirestore _firestore;

  UserSafetyRepository(this._firestore);

  CollectionReference _blockedUsersRef(String userId) =>
      _firestore.collection('users').doc(userId).collection('blocked_users');

  Future<void> blockUser({
    required String currentUserId,
    required String targetUserId,
    String? reason,
    String source = 'chat',
  }) async {
    await _blockedUsersRef(currentUserId).doc(targetUserId).set({
      'blockedUserId': targetUserId,
      'blockedAt': FieldValue.serverTimestamp(),
      'reason': reason,
      'source': source,
    });
  }

  Future<void> unblockUser(String currentUserId, String targetUserId) async {
    await _blockedUsersRef(currentUserId).doc(targetUserId).delete();
  }

  Future<bool> isBlocked(String currentUserId, String targetUserId) async {
    final doc = await _blockedUsersRef(currentUserId).doc(targetUserId).get();
    return doc.exists;
  }

  Future<bool> isBlockedByOther(String currentUserId, String targetUserId) async {
    final doc = await _blockedUsersRef(targetUserId).doc(currentUserId).get();
    return doc.exists;
  }

  Future<void> reportUser({
    required String reporterId,
    required String reportedUserId,
    String? chatRoomId,
    String? dealId,
    String? productId,
    required String reason,
    String? description,
    String countryCode = 'ID',
  }) async {
    await _firestore.collection('reports').add({
      'type': 'chat_problem',
      'reporterId': reporterId,
      'reportedUserId': reportedUserId,
      'chatRoomId': chatRoomId,
      'dealId': dealId,
      'productId': productId,
      'reason': reason,
      'description': description,
      'status': 'open',
      'createdAt': FieldValue.serverTimestamp(),
      'countryCode': countryCode,
    });
  }
}
