import 'package:flutter_test/flutter_test.dart';
import 'package:mozzy/mozzy_ii/domains/feed/models/feed_item_model.dart';
import 'package:mozzy/mozzy_ii/domains/feed/models/feed_item_type.dart';
import 'package:mozzy/mozzy_ii/domains/feed/services/semantic_ranking_service.dart';
import 'package:mozzy/mozzy_ii/domains/feed/services/mock_semantic_ranking_adapter.dart';
import 'package:mozzy/mozzy_ii/domains/feed/services/feed_semantic_sanitizer.dart';
import 'package:mozzy/mozzy_ii/domains/feed/services/feed_ranking_service.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'semantic_ranking_service_test.mocks.dart';

@GenerateMocks([FeedRankingService])
void main() {
  late SemanticRankingService service;
  late MockSemanticRankingAdapter adapter;
  late FeedSemanticSanitizer sanitizer;
  late MockFeedRankingService rankingService;

  setUp(() {
    adapter = MockSemanticRankingAdapter();
    sanitizer = FeedSemanticSanitizer();
    rankingService = MockFeedRankingService();
    service = SemanticRankingService(
      adapter: adapter,
      sanitizer: sanitizer,
      rankingService: rankingService,
    );
  });

  group('SemanticRankingService Tests', () {
    test('should apply semantic scores and re-rank', () async {
      final now = DateTime.now();
      final items = [
        FeedItemModel(
          id: '1', sourceId: '1', type: FeedItemType.job, title: 'Engineer',
          createdAt: now, route: '/r',
        ),
        FeedItemModel(
          id: '2', sourceId: '2', type: FeedItemType.marketplaceProduct, title: 'Chair',
          createdAt: now, route: '/r',
        ),
      ];

      // Mock ranking service to return a simple combined score
      when(rankingService.calculateFinalScore(any)).thenAnswer((inv) {
        final item = inv.positionalArguments[0] as FeedItemModel;
        return item.semanticScore; // Just use semantic score for testing
      });
      
      when(rankingService.rankItems(any)).thenAnswer((inv) {
        final list = inv.positionalArguments[0] as List<FeedItemModel>;
        final sorted = List<FeedItemModel>.from(list);
        sorted.sort((a, b) => b.finalScore.compareTo(a.finalScore));
        return sorted;
      });

      final results = await service.applySemanticScores(
        items: items,
        userIntent: 'job engineer',
      );

      expect(results.first.id, '1');
      expect(results.first.semanticScore, 25.0); // 15 (intent) + 10 (job domain)
      expect(results.first.semanticReason, contains('Job domain match'));
      expect(results.first.semanticScoredAt, isNotNull);
    });

    test('should return original items if intent is empty', () async {
      final items = [
        FeedItemModel(
          id: '1', sourceId: '1', type: FeedItemType.job, title: 'Engineer',
          createdAt: DateTime.now(), route: '/r',
        ),
      ];

      final results = await service.applySemanticScores(
        items: items,
        userIntent: '',
      );

      expect(results, items);
    });
  });
}
