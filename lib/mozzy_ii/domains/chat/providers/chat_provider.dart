import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../../../app/auth/auth_service.dart';
import '../repositories/chat_repository.dart';
import '../models/chat_room_model.dart';
import '../models/chat_message_model.dart';

final chatRepositoryProvider = Provider<ChatRepository>((ref) {
  return FirestoreChatRepository(FirebaseFirestore.instance);
});

final chatRoomProvider = StreamProvider.family<ChatRoomModel?, String>((ref, roomId) {
  final repo = ref.watch(chatRepositoryProvider);
  return repo.watchChatRoom(roomId);
});

final chatMessagesProvider = StreamProvider.family<List<ChatMessageModel>, String>((ref, roomId) {
  final repo = ref.watch(chatRepositoryProvider);
  return repo.watchMessages(roomId);
});

final userChatRoomsProvider = FutureProvider<List<ChatRoomModel>>((ref) {
  final user = ref.watch(authStateProvider).value;
  if (user == null) return [];
  final repo = ref.watch(chatRepositoryProvider);
  return repo.fetchUserChatRooms(user.uid);
});

final currentChatUserIdProvider = Provider<String?>((ref) {
  return ref.watch(authStateProvider).value?.uid;
});
