import 'package:flutter_test/flutter_test.dart';
import 'package:mozzy/mozzy_ii/domains/feed/models/feed_interaction_event.dart';
import 'package:mozzy/mozzy_ii/domains/feed/models/feed_interaction_type.dart';

void main() {
  group('FeedInteractionEvent', () {
    test('toSafeJson should use wireValue for eventType (snake_case)', () {
      final event = FeedInteractionEvent(
        eventType: FeedInteractionType.cardTap,
        feedItemId: 'item-123',
        sourceId: 'source-456',
        sourceType: 'job',
        position: 5,
      );

      final json = event.toSafeJson();
      expect(json['eventType'], 'card_tap');
    });

    test('toSafeJson should include all required fields', () {
      final event = FeedInteractionEvent(
        eventType: FeedInteractionType.cardTap,
        feedItemId: 'item-123',
        sourceId: 'source-456',
        sourceType: 'job',
        route: '/jobs/source-456',
        position: 5,
        isPromoted: true,
        hasSemanticIntent: true,
        intentLengthBucket: 'short',
        sessionId: 'session-789',
        clientCreatedAt: DateTime(2026, 5, 9, 23, 30),
        metadata: {'extra': 'info'},
      );

      final json = event.toSafeJson();

      expect(json['eventType'], 'card_tap');
      expect(json['feedItemId'], 'item-123');
      expect(json['sourceId'], 'source-456');
      expect(json['sourceType'], 'job');
      expect(json['route'], '/jobs/source-456');
      expect(json['position'], 5);
      expect(json['isPromoted'], true);
      expect(json['hasSemanticIntent'], true);
      expect(json['intentLengthBucket'], 'short');
      expect(json['sessionId'], 'session-789');
      expect(json['clientCreatedAt'], '2026-05-09T23:30:00.000');
      expect(json['metadata']['extra'], 'info');
    });

    test('toSafeJson should filter out forbidden metadata keys', () {
      final event = FeedInteractionEvent(
        eventType: FeedInteractionType.impression,
        feedItemId: 'item-1',
        sourceId: 's-1',
        sourceType: 'p',
        position: 0,
        metadata: {
          'safe_key': 'safe_value',
          'intent': 'raw intent',
          'email': 'user@test.com',
          'phone': '123',
          'userId': 'uid',
        },
      );

      final json = event.toSafeJson();
      final sanitizedMetadata = json['metadata'] as Map<String, dynamic>;

      expect(sanitizedMetadata['safe_key'], 'safe_value');
      expect(sanitizedMetadata.containsKey('intent'), isFalse);
      expect(sanitizedMetadata.containsKey('email'), isFalse);
      expect(sanitizedMetadata.containsKey('phone'), isFalse);
      expect(sanitizedMetadata.containsKey('userId'), isFalse);
    });

    test('toSafeJson should handle null optional fields', () {
      final event = FeedInteractionEvent(
        eventType: FeedInteractionType.impression,
        feedItemId: 'item-1',
        sourceId: 's-1',
        sourceType: 'p',
        position: 0,
      );

      final json = event.toSafeJson();

      expect(json['route'], isNull);
      expect(json['intentLengthBucket'], isNull);
      expect(json['sessionId'], isNull);
      expect(json['metadata'], isEmpty); // _safeMetadata returns empty map for null
      expect(json['isPromoted'], false);
    });
  });
}
