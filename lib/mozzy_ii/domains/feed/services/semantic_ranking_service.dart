import '../models/feed_item_model.dart';
import 'semantic_ranking_adapter.dart';
import 'feed_semantic_sanitizer.dart';
import 'feed_ranking_service.dart';

class SemanticRankingService {
  final SemanticRankingAdapter adapter;
  final FeedSemanticSanitizer sanitizer;
  final FeedRankingService rankingService;

  SemanticRankingService({
    required this.adapter,
    required this.sanitizer,
    required this.rankingService,
  });

  /// Applies semantic scores to a list of FeedItemModels based on user intent.
  Future<List<FeedItemModel>> applySemanticScores({
    required List<FeedItemModel> items,
    required String userIntent,
    String languageCode = 'id',
  }) async {
    if (userIntent.isEmpty || items.isEmpty) {
      return items;
    }

    try {
      // 1. Sanitize items into safe payloads
      final payloads = items.map((item) => sanitizer.sanitize(item, languageCode: languageCode)).toList();

      // 2. Call adapter to get scores
      final results = await adapter.rank(
        payloads: payloads,
        userIntent: userIntent,
        languageCode: languageCode,
      );

      // 3. Map results back to items
      final resultMap = {for (var r in results) r.feedItemId: r};

      final updatedItems = items.map((item) {
        final result = resultMap[item.id];
        if (result == null) return item;

        // Apply semantic score and metadata
        final updatedItem = item.copyWith(
          semanticScore: result.score,
          semanticReason: result.reason,
          semanticScoredAt: DateTime.now(),
        );

        // Recalculate final score with the new semantic component
        return updatedItem.copyWith(
          finalScore: rankingService.calculateFinalScore(updatedItem),
        );
      }).toList();

      // 4. Re-rank based on new scores
      return rankingService.rankItems(updatedItems);
    } catch (e) {
      // Fallback: return original items if AI ranking fails
      return items;
    }
  }
}
