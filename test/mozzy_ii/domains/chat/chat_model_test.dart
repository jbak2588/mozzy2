import 'package:flutter_test/flutter_test.dart';
import 'package:mozzy/mozzy_ii/domains/chat/models/chat_room_model.dart';
import 'package:mozzy/mozzy_ii/domains/chat/models/chat_message_model.dart';

void main() {
  group('Chat Models', () {
    test('ChatRoomModel serialization', () {
      final now = DateTime.now().toUtc();
      final room = ChatRoomModel(
        id: 'room1',
        participants: ['u1', 'u2'],
        buyerId: 'u1',
        sellerId: 'u2',
        productId: 'p1',
        dealId: 'd1',
        productTitle: 'MacBook',
        createdAt: now,
        updatedAt: now,
      );

      final json = room.toJson();
      final restored = ChatRoomModel.fromJson(json);

      expect(restored.id, 'room1');
      expect(restored.participants, ['u1', 'u2']);
      expect(restored.productTitle, 'MacBook');
    });

    test('ChatMessageModel serialization', () {
      final now = DateTime.now().toUtc();
      final message = ChatMessageModel(
        id: 'msg1',
        roomId: 'room1',
        senderId: 'u1',
        text: 'Hello',
        createdAt: now,
      );

      final json = message.toJson();
      final restored = ChatMessageModel.fromJson(json);

      expect(restored.id, 'msg1');
      expect(restored.text, 'Hello');
      expect(restored.senderId, 'u1');
    });
  });
}
