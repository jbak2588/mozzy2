import 'package:flutter_test/flutter_test.dart';
import 'package:mozzy/mozzy_ii/domains/feed/models/semantic_ranking_payload.dart';
import 'package:mozzy/mozzy_ii/domains/feed/services/feed_semantic_sanitizer.dart';
import 'package:mozzy/mozzy_ii/domains/feed/models/feed_item_model.dart';
import 'package:mozzy/mozzy_ii/domains/feed/models/feed_item_type.dart';

void main() {
  group('SemanticRankingPayload Privacy Tests', () {
    test('toSafeJson should only contain allowed fields', () {
      const payload = SemanticRankingPayload(
        feedItemId: 'item123',
        sourceId: 'src456',
        type: 'job',
        title: 'Software Engineer',
        publicSummary: 'Build great things',
        category: 'Engineering',
        locationHint: 'Jakarta',
        isPromoted: true,
        isTrusted: true,
        ageBucket: 'new',
        languageCode: 'id',
      );

      final json = payload.toSafeJson();

      // Allowed fields
      expect(json['feedItemId'], 'item123');
      expect(json['sourceId'], 'src456');
      expect(json['type'], 'job');
      expect(json['title'], 'Software Engineer');
      expect(json['publicSummary'], 'Build great things');
      expect(json['category'], 'Engineering');
      expect(json['locationHint'], 'Jakarta');
      expect(json['isPromoted'], isTrue);
      expect(json['isTrusted'], isTrue);
      expect(json['ageBucket'], 'new');
      expect(json['languageCode'], 'id');

      // Check for forbidden fields (sanity check)
      final forbiddenFields = [
        'userId',
        'ownerId',
        'email',
        'phone',
        'NIK',
        'fcmToken',
        'paymentId',
        'auditId',
        'rawPrompt',
        'exactAddress'
      ];

      for (final field in forbiddenFields) {
        expect(json.containsKey(field), isFalse, reason: 'Field $field should not be in payload');
      }
    });

    test('sanitizer should remove email and phone patterns', () {
      final sanitizer = FeedSemanticSanitizer();
      final item = FeedItemModel(
        id: '1',
        sourceId: '1',
        type: FeedItemType.job,
        title: 'T',
        description: 'Call 0812345678 or mail me@test.com',
        createdAt: DateTime.now(),
        route: '/r',
      );

      final payload = sanitizer.sanitize(item);
      expect(payload.publicSummary, isNot(contains('0812345678')));
      expect(payload.publicSummary, isNot(contains('me@test.com')));
      expect(payload.publicSummary, contains('[PHONE]'));
      expect(payload.publicSummary, contains('[EMAIL]'));
    });
  });
}
