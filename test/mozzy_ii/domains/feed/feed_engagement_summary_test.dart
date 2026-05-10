import 'package:flutter_test/flutter_test.dart';
import 'package:mozzy/mozzy_ii/domains/feed/models/feed_engagement_summary.dart';

void main() {
  group('FeedEngagementSummary', () {
    test('fromJson should parse correctly with all fields', () {
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
      expect(summary.sourceType, 'job');
      expect(summary.sourceId, '123');
      expect(summary.engagementScore, 15.5);
      expect(summary.impressionCount, 100);
      expect(summary.ctaTapCount, 2);
      expect(summary.lastInteractionAt, isNotNull);
      expect(summary.lastAggregatedAt, isNotNull);
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
      expect(summary.cardTapCount, 0);
      expect(summary.detailOpenCount, 0);
      expect(summary.ctaTapCount, 0);
      expect(summary.semanticIntentCount, 0);
      expect(summary.totalInteractions, 0);
      expect(summary.uniqueSessionCount, 0);
      expect(summary.window, 'all_time');
    });

    test('should handle missing engagementScore by defaulting to 0.0', () {
      final json = {
        'id': 'job_123',
        'sourceType': 'job',
        'sourceId': '123',
      };
      final summary = FeedEngagementSummary.fromJson(json);
      expect(summary.engagementScore, 0.0);
    });

    test('ctaTapCount should be correctly mapped from JSON ctaTapCount', () {
      final json = {
        'id': 'job_123',
        'sourceType': 'job',
        'sourceId': '123',
        'ctaTapCount': 5,
      };
      final summary = FeedEngagementSummary.fromJson(json);
      expect(summary.ctaTapCount, 5);
    });
  });
}
