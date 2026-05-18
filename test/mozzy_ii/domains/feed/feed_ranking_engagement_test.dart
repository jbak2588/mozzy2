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
    test('calculateEngagementScore should reflect raw counts', () {
      final item = FeedItemModel(
        id: '1',
        sourceId: 's1',
        type: FeedItemType.job,
        title: 'Job 1',
        createdAt: now.subtract(const Duration(days: 10)),
        likesCount: 10, // 10*3 = 30
        commentsCount: 5, // 5*5 = 25
        // Total 55 -> Normalized 1.0
        route: '/jobs/1',
      );

      expect(rankingService.calculateEngagementScore(item), 1.0);
    });

    test('rankItems should prioritize item with higher engagement counts', () {
      final item1 = FeedItemModel(
        id: '1',
        sourceId: 's1',
        type: FeedItemType.job,
        title: 'Low Engagement',
        createdAt: now.subtract(const Duration(days: 1)),
        viewsCount: 2, // 2*1 = 2 -> Normalized 0.25
        route: '/jobs/1',
      );

      final item2 = FeedItemModel(
        id: '2',
        sourceId: 's2',
        type: FeedItemType.job,
        title: 'High Engagement',
        createdAt: now.subtract(const Duration(days: 1)),
        likesCount: 20, // 20*3 = 60 -> Normalized 1.0
        route: '/jobs/2',
      );

      final ranked = rankingService.rankItems([item1, item2], now: now);

      expect(ranked.first.id, '2');
      expect(ranked.last.id, '1');
    });

    test('engagement should not override boostScore', () {
      final item1 = FeedItemModel(
        id: '1',
        sourceId: 's1',
        type: FeedItemType.job,
        title: 'High Engagement No Boost',
        createdAt: now.subtract(const Duration(hours: 1)),
        likesCount: 100, // Max engagement signal
        isPromoted: false,
        route: '/jobs/1',
      );

      final item2 = FeedItemModel(
        id: '2',
        sourceId: 's2',
        type: FeedItemType.job,
        title: 'Low Engagement With Boost',
        createdAt: now.subtract(const Duration(hours: 1)),
        likesCount: 0,
        isPromoted: true, // +100 bonus
        route: '/jobs/2',
      );

      final ranked = rankingService.rankItems([item1, item2], now: now);

      expect(ranked.first.id, '2'); // Boosted item wins
    });
  });
}
