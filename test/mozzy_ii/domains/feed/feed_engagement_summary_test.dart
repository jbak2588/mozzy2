import 'package:flutter_test/flutter_test.dart';
import 'package:mozzy/mozzy_ii/domains/feed/models/feed_engagement_summary.dart';

void main() {
  group('FeedEngagementSummary', () {
    test('fromJson should parse correctly', () {
      final json = {
        'id': 'job_123',
        'sourceType': 'job',
        'sourceId': '123',
        'feedItemId': 'fi1',
        'impressionCount': 100,
        'cardTapCount': 10,
        'detailOpenCount': 5,
        'ctaTapCount': 2,
        'semanticIntentCount': 3,
        'totalInteractions': 120,
        'uniqueSessionCount': 50,
        'engagementScore': 15.5,
        'lastInteractionAt': '2026-05-10T00:00:00Z',
        'lastAggregatedAt': '2026-05-10T01:00:00Z',
        'window': 'all_time',
      };

      final summary = FeedEngagementSummary.fromJson(json);

      expect(summary.id, 'job_123');
      expect(summary.engagementScore, 15.5);
      expect(summary.impressionCount, 100);
      expect(summary.lastInteractionAt, isNotNull);
    });

    test('should use default values for missing fields', () {
      final json = {
        'id': 'job_123',
        'sourceType': 'job',
        'sourceId': '123',
      };

      final summary = FeedEngagementSummary.fromJson(json);

      expect(summary.engagementScore, 0.0);
      expect(summary.impressionCount, 0);
      expect(summary.window, 'all_time');
    });
  });
}
