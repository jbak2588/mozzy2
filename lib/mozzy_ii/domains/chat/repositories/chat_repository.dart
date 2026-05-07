import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/chat_room_model.dart';
import '../models/chat_message_model.dart';

abstract class ChatRepository {
  Stream<ChatRoomModel?> watchChatRoom(String roomId);
  Stream<List<ChatMessageModel>> watchMessages(String roomId);
  Future<ChatRoomModel> getOrCreateDealChatRoom({
    required String buyerId,
    required String sellerId,
    required String productId,
    required String dealId,
    required String productTitle,
    String? productImageUrl,
  });
  Future<({ChatRoomModel room, bool wasCreated})> getOrCreateJobChatRoom({
    required String applicantId,
    required String ownerId,
    required String jobId,
    required String jobTitle,
  });
  Future<void> sendTextMessage({
    required String roomId,
    required String senderId,
    required String text,
  });
  Future<void> markRoomAsRead(String roomId, String userId);
  Future<List<ChatRoomModel>> fetchUserChatRooms(String userId);
}

class FirestoreChatRepository implements ChatRepository {
  final FirebaseFirestore _firestore;

  FirestoreChatRepository(this._firestore);

  @override
  Stream<ChatRoomModel?> watchChatRoom(String roomId) {
    return _firestore.collection('chat_rooms').doc(roomId).snapshots().map((snapshot) {
      if (!snapshot.exists) return null;
      final data = snapshot.data();
      if (data == null) return null;
      return ChatRoomModel.fromJson({'id': snapshot.id, ...data});
    });
  }

  @override
  Stream<List<ChatMessageModel>> watchMessages(String roomId) {
    return _firestore
        .collection('chat_rooms')
        .doc(roomId)
        .collection('messages')
        .orderBy('createdAt', descending: true)
        .snapshots()
        .map((snapshot) {
      return snapshot.docs
          .map((doc) => ChatMessageModel.fromJson({'id': doc.id, ...doc.data()}))
          .toList();
    });
  }

  @override
  Future<ChatRoomModel> getOrCreateDealChatRoom({
    required String buyerId,
    required String sellerId,
    required String productId,
    required String dealId,
    required String productTitle,
    String? productImageUrl,
  }) async {
    // Search for existing room for this deal
    final existing = await _firestore
        .collection('chat_rooms')
        .where('dealId', isEqualTo: dealId)
        .where('buyerId', isEqualTo: buyerId)
        .where('sellerId', isEqualTo: sellerId)
        .limit(1)
        .get();

    if (existing.docs.isNotEmpty) {
      final doc = existing.docs.first;
      return ChatRoomModel.fromJson({'id': doc.id, ...doc.data()});
    }

    // Create new room
    final docRef = _firestore.collection('chat_rooms').doc();
    final now = DateTime.now();
    final room = ChatRoomModel(
      id: docRef.id,
      participants: [buyerId, sellerId],
      buyerId: buyerId,
      sellerId: sellerId,
      productId: productId,
      dealId: dealId,
      productTitle: productTitle,
      productImageUrl: productImageUrl,
      createdAt: now,
      updatedAt: now,
      unreadCountByUser: {
        buyerId: 0,
        sellerId: 0,
      },
    );

    await docRef.set(room.toJson());
    return room;
  }

  @override
  Future<({ChatRoomModel room, bool wasCreated})> getOrCreateJobChatRoom({
    required String applicantId,
    required String ownerId,
    required String jobId,
    required String jobTitle,
  }) async {
    // Search for existing room for this job between these two users
    final existing = await _firestore
        .collection('chat_rooms')
        .where('type', isEqualTo: 'job_inquiry')
        .where('jobId', isEqualTo: jobId)
        .where('participants', arrayContains: applicantId)
        .get();

    final match = existing.docs.where((doc) {
      final participants = List<String>.from(doc.data()['participants'] ?? []);
      return participants.contains(ownerId);
    });

    if (match.isNotEmpty) {
      final doc = match.first;
      return (
        room: ChatRoomModel.fromJson({'id': doc.id, ...doc.data()}),
        wasCreated: false,
      );
    }

    // Create new room
    final docRef = _firestore.collection('chat_rooms').doc();
    final now = DateTime.now();
    final room = ChatRoomModel(
      id: docRef.id,
      type: 'job_inquiry',
      participants: [applicantId, ownerId],
      jobId: jobId,
      jobTitle: jobTitle,
      createdAt: now,
      updatedAt: now,
      unreadCountByUser: {
        applicantId: 0,
        ownerId: 0,
      },
    );

    await docRef.set(room.toJson());
    return (room: room, wasCreated: true);
  }

  @override
  Future<void> sendTextMessage({
    required String roomId,
    required String senderId,
    required String text,
  }) async {
    if (text.trim().isEmpty) return;

    final roomRef = _firestore.collection('chat_rooms').doc(roomId);
    final messageRef = roomRef.collection('messages').doc();

    final now = DateTime.now();
    final message = ChatMessageModel(
      id: messageRef.id,
      roomId: roomId,
      senderId: senderId,
      text: text,
      createdAt: now,
    );

    // We use a transaction to ensure atomic update of message and room metadata
    await _firestore.runTransaction((transaction) async {
      final roomDoc = await transaction.get(roomRef);
      if (!roomDoc.exists) throw Exception('Room not found');
      
      final data = roomDoc.data()!;
      final participants = List<String>.from(data['participants'] ?? []);
      final recipientId = participants.firstWhere((id) => id != senderId, orElse: () => '');

      if (recipientId.isEmpty) throw Exception('Recipient not found');

      transaction.set(messageRef, message.toJson());
      
      transaction.update(roomRef, {
        'lastMessage': text,
        'lastMessageType': 'text',
        'lastMessageAt': Timestamp.fromDate(now.toUtc()),
        'lastSenderId': senderId,
        'updatedAt': Timestamp.fromDate(now.toUtc()),
        'unreadCountByUser.$recipientId': FieldValue.increment(1),
      });
    });
  }

  @override
  Future<void> markRoomAsRead(String roomId, String userId) async {
    await _firestore.collection('chat_rooms').doc(roomId).update({
      'unreadCountByUser.$userId': 0,
    });
  }

  @override
  Future<List<ChatRoomModel>> fetchUserChatRooms(String userId) async {
    final query = await _firestore
        .collection('chat_rooms')
        .where('participants', arrayContains: userId)
        .orderBy('updatedAt', descending: true)
        .get();

    return query.docs
        .map((doc) => ChatRoomModel.fromJson({'id': doc.id, ...doc.data()}))
        .toList();
  }
}
