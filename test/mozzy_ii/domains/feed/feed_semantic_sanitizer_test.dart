import 'package:flutter_test/flutter_test.dart';
import 'package:mozzy/mozzy_ii/domains/feed/models/feed_item_model.dart';
import 'package:mozzy/mozzy_ii/domains/feed/models/feed_item_type.dart';
import 'package:mozzy/mozzy_ii/domains/feed/services/feed_semantic_sanitizer.dart';

void main() {
  late FeedSemanticSanitizer sanitizer;

  setUp(() {
    sanitizer = FeedSemanticSanitizer();
  });

  group('FeedSemanticSanitizer Tests', () {
    test('should sanitize email and phone from description', () {
      final now = DateTime.now();
      final item = FeedItemModel(
        id: '1',
        sourceId: '1',
        type: FeedItemType.job,
        title: 'Test Job',
        description: 'Contact me at test@example.com or 081234567890 for details.',
        createdAt: now,
        route: '/jobs/1',
      );

      final payload = sanitizer.sanitize(item);

      expect(payload.publicSummary, contains('[EMAIL]'));
      expect(payload.publicSummary, contains('[PHONE]'));
      expect(payload.publicSummary, isNot(contains('test@example.com')));
      expect(payload.publicSummary, isNot(contains('081234567890')));
    });

    test('should truncate long description', () {
      final longDesc = 'A' * 500;
      final now = DateTime.now();
      final item = FeedItemModel(
        id: '1',
        sourceId: '1',
        type: FeedItemType.job,
        title: 'Test Job',
        description: longDesc,
        createdAt: now,
        route: '/jobs/1',
      );

      final payload = sanitizer.sanitize(item);

      expect(payload.publicSummary!.length, lessThanOrEqualTo(303)); // 300 + '...'
      expect(payload.publicSummary, endsWith('...'));
    });

    test('should assign correct age bucket', () {
      final now = DateTime.now();
      
      final itemNew = FeedItemModel(
        id: '1', sourceId: '1', type: FeedItemType.job, title: 'New',
        createdAt: now.subtract(const Duration(hours: 1)), route: '/r',
      );
      
      final itemRecent = FeedItemModel(
        id: '2', sourceId: '2', type: FeedItemType.job, title: 'Recent',
        createdAt: now.subtract(const Duration(days: 2)), route: '/r',
      );

      expect(sanitizer.sanitize(itemNew).ageBucket, 'new');
      expect(sanitizer.sanitize(itemRecent).ageBucket, 'recent');
    });
  });
}
