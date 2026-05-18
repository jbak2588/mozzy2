import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../models/feed_item_model.dart';
import '../models/user_feed_context.dart';
import '../repositories/smart_feed_repository.dart';
import '../repositories/firestore_smart_feed_repository.dart';
import '../services/feed_ranking_service.dart';
import '../services/semantic_ranking_adapter.dart';
import '../services/mock_semantic_ranking_adapter.dart';
import '../services/feed_semantic_sanitizer.dart';
import '../services/semantic_ranking_service.dart';
import '../services/gemini_semantic_ranking_adapter.dart';
import 'feed_engagement_provider.dart';
import 'package:rxdart/rxdart.dart';
import '../../../geo/providers/location_provider.dart';

part 'smart_feed_provider.g.dart';

@riverpod
SmartFeedRepository smartFeedRepository(Ref ref) {
  return FirestoreSmartFeedRepository();
}

@riverpod
SemanticRankingAdapter semanticRankingAdapter(Ref ref) {
  const enableGeminiRanking = bool.fromEnvironment(
    'ENABLE_GEMINI_RANKING',
    defaultValue: false,
  );

  if (enableGeminiRanking) {
    return GeminiSemanticRankingAdapter();
  }
  return MockSemanticRankingAdapter();
}

@riverpod
FeedSemanticSanitizer feedSemanticSanitizer(Ref ref) {
  return FeedSemanticSanitizer();
}

@riverpod
SemanticRankingService semanticRankingService(Ref ref) {
  return SemanticRankingService(
    adapter: ref.watch(semanticRankingAdapterProvider),
    sanitizer: ref.watch(feedSemanticSanitizerProvider),
    rankingService: ref.watch(feedRankingServiceProvider.notifier),
  );
}

@riverpod
class SmartFeedSearchIntent extends _$SmartFeedSearchIntent {
  @override
  String build() => '';
  
  void setIntent(String intent) {
    final normalized = intent.trim();
    if (normalized.length > 100) {
      state = normalized.substring(0, 100);
    } else {
      state = normalized;
    }
  }

  void clearIntent() => state = '';

  bool get hasIntent => state.isNotEmpty;
}

@riverpod
Stream<List<FeedItemModel>> smartFeed(Ref ref) {
  final repository = ref.watch(smartFeedRepositoryProvider);
  final locationAsync = ref.watch(locationProvider);
  final rankingService = ref.watch(feedRankingServiceProvider.notifier);
  final semanticService = ref.watch(semanticRankingServiceProvider);
  final intent = ref.watch(smartFeedSearchIntentProvider);
  final engagementRepo = ref.watch(feedEngagementRepositoryProvider);
  
  final locationParts = locationAsync.value;
  
  // Resolve Timezone based on province (Track 1)
  String timezoneCode = 'WIB';
  final provinsi = locationParts?.idAddress?.provinsi;
  if (provinsi != null) {
    final prov = provinsi.toLowerCase();
    if (prov.contains('bali') || prov.contains('nusa tenggara') || prov.contains('sulawesi') || prov.contains('kalimantan selatan') || prov.contains('kalimantan timur') || prov.contains('kalimantan utara')) {
      timezoneCode = 'WITA';
    } else if (prov.contains('maluku') || prov.contains('papua')) {
      timezoneCode = 'WIT';
    }
  }

  final context = UserFeedContext(
    locationParts: locationParts,
    timezoneCode: timezoneCode,
    recentlyShownTypes: const [], // History tracking can be implemented via session provider
  );

  return repository.getSmartFeed(locationFilter: locationParts).switchMap((items) {
    if (items.isEmpty) return Stream.value([]);
    
    return engagementRepo.watchEngagementSummaries(items: items).asyncMap((summaries) async {
      // Inject engagement scores
      final itemsWithEngagement = items.map((item) {
        final key = '${item.type.name}_${item.sourceId}';
        final summary = summaries[key];
        return item.copyWith(
          engagementScore: summary?.engagementScore ?? 0.0,
        );
      }).toList();
      
      // 1. Initial rule-based ranking (now with engagement scores)
      final rankedItems = rankingService.rankItems(itemsWithEngagement, context: context);
      
      // 2. Apply semantic ranking if intent exists
      if (intent.isNotEmpty) {
        return await semanticService.applySemanticScores(
          items: rankedItems,
          userIntent: intent,
        );
      }
      
      return rankedItems;
    });
  });
}

@riverpod
class FeedFilter extends _$FeedFilter {
  @override
  String? build() => null; // null means 'Semua'

  void setFilter(String? type) {
    state = type;
  }
}

@riverpod
List<FeedItemModel> filteredSmartFeed(Ref ref) {
  final feedAsync = ref.watch(smartFeedProvider);
  final filter = ref.watch(feedFilterProvider);
  
  return feedAsync.when(
    data: (items) {
      if (filter == null) return items;
      return items.where((item) => item.type.name == filter).toList();
    },
    loading: () => [],
    error: (e, s) => [],
  );
}
