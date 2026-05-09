import 'package:flutter_test/flutter_test.dart';
import 'package:mozzy/mozzy_ii/domains/feed/models/feed_item_model.dart';
import 'package:mozzy/mozzy_ii/domains/feed/models/feed_item_type.dart';
import 'package:mozzy/mozzy_ii/domains/feed/services/feed_ranking_service.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void main() {
  late FeedRankingService rankingService;
  late DateTime now;

  setUp(() {
    final container = ProviderContainer();
    rankingService = container.read(feedRankingServiceProvider.notifier);
    now = DateTime(2026, 5, 10, 12, 0);
  });

  group('FeedRankingService Engagement Integration', () {
    test('calculateEngagementScore should multiply engagementScore by multiplier', () {
      final item = FeedItemModel(
        id: '1',
        sourceId: 's1',
        type: FeedItemType.job,
        title: 'Job 1',
        createdAt: now.subtract(const Duration(days: 10)), // No freshness bonus
        engagementScore: 10.0,
        route: '/jobs/1',
      );

      // engagementMultiplier is 1.0 in current FeedRankingSignal
      expect(rankingService.calculateEngagementScore(item), 10.0);
    });

    test('rankItems should prioritize item with higher engagementScore', () {
      final item1 = FeedItemModel(
        id: '1',
        sourceId: 's1',
        type: FeedItemType.job,
        title: 'Low Engagement',
        createdAt: now.subtract(const Duration(days: 10)),
        engagementScore: 5.0,
        route: '/jobs/1',
      );

      final item2 = FeedItemModel(
        id: '2',
        sourceId: 's2',
        type: FeedItemType.job,
        title: 'High Engagement',
        createdAt: now.subtract(const Duration(days: 10)),
        engagementScore: 25.0,
        route: '/jobs/2',
      );

      final ranked = rankingService.rankItems([item1, item2], now: now);

      expect(ranked.first.id, '2');
      expect(ranked.first.engagementScore, 25.0);
      expect(ranked.last.id, '1');
    });

    test('engagementScore should not override boostScore', () {
      final item1 = FeedItemModel(
        id: '1',
        sourceId: 's1',
        type: FeedItemType.job,
        title: 'High Engagement No Boost',
        createdAt: now.subtract(const Duration(days: 10)),
        engagementScore: 30.0, // Max engagement
        isPromoted: false,
        route: '/jobs/1',
      );

      final item2 = FeedItemModel(
        id: '2',
        sourceId: 's2',
        type: FeedItemType.job,
        title: 'Low Engagement With Boost',
        createdAt: now.subtract(const Duration(days: 10)),
        engagementScore: 0.0,
        isPromoted: true, // +100 bonus
        route: '/jobs/2',
      );

      final ranked = rankingService.rankItems([item1, item2], now: now);

      expect(ranked.first.id, '2'); // Boosted item wins
    });
  });
}
