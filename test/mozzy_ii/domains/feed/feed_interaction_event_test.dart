import 'package:flutter_test/flutter_test.dart';
import 'package:mozzy/mozzy_ii/domains/feed/models/feed_interaction_event.dart';
import 'package:mozzy/mozzy_ii/domains/feed/models/feed_interaction_type.dart';

void main() {
  group('FeedInteractionEvent', () {
    test('forbidden metadata keys are stripped in toSafeJson', () {
      final event = FeedInteractionEvent(
        eventType: FeedInteractionType.cardTap,
        feedItemId: 'fi1',
        sourceId: 'src1',
        sourceType: 'job',
        position: 0,
        metadata: {
          'allowed_key': 'value',
          'userId': '123',
          'searchQuery': 'loker',
          'email': 'test@test.com',
          'phone': '0123456789',
        },
      );

      final json = event.toSafeJson();
      final metadata = json['metadata'] as Map<String, dynamic>;

      expect(metadata.containsKey('allowed_key'), isTrue);
      expect(metadata.containsKey('userId'), isFalse);
      expect(metadata.containsKey('searchQuery'), isFalse);
      expect(metadata.containsKey('email'), isFalse);
      expect(metadata.containsKey('phone'), isFalse);
    });

    test('impressionMode/visibleRatio/dwellMs serialize correctly', () {
      final event = FeedInteractionEvent(
        eventType: FeedInteractionType.impression,
        feedItemId: 'fi1',
        sourceId: 'src1',
        sourceType: 'job',
        position: 0,
        impressionMode: 'viewport',
        visibleRatio: 0.75,
        dwellMs: 1200,
      );

      final json = event.toSafeJson();

      expect(json['impressionMode'], 'viewport');
      expect(json['visibleRatio'], 0.75);
      expect(json['dwellMs'], 1200);
    });

    test('null optional fields are not serialized', () {
      final event = FeedInteractionEvent(
        eventType: FeedInteractionType.cardTap,
        feedItemId: 'fi1',
        sourceId: 'src1',
        sourceType: 'job',
        position: 0,
      );

      final json = event.toSafeJson();

      expect(json.containsKey('impressionMode'), isFalse);
      expect(json.containsKey('visibleRatio'), isFalse);
      expect(json.containsKey('dwellMs'), isFalse);
      expect(json.containsKey('route'), isTrue);
      expect(json['route'], isNull);
    });
  });
}
