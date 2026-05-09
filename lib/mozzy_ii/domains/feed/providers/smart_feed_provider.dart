import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../models/feed_item_model.dart';
import '../models/user_location_context.dart';
import '../repositories/smart_feed_repository.dart';
import '../repositories/firestore_smart_feed_repository.dart';
import '../services/feed_ranking_service.dart';
import '../../../geo/providers/location_provider.dart';

part 'smart_feed_provider.g.dart';

@riverpod
SmartFeedRepository smartFeedRepository(Ref ref) {
  return FirestoreSmartFeedRepository();
}

@riverpod
Stream<List<FeedItemModel>> smartFeed(Ref ref) {
  final repository = ref.watch(smartFeedRepositoryProvider);
  final locationAsync = ref.watch(locationProvider);
  final rankingService = ref.watch(feedRankingServiceProvider.notifier);
  
  final locationParts = locationAsync.value;
  final context = locationParts != null ? UserLocationContext(locationParts: locationParts) : null;

  return repository.getSmartFeed(locationFilter: locationParts).map((items) {
    return rankingService.rankItems(items, context: context);
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
    error: (_, __) => [],
  );
}
