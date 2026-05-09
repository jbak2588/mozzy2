import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../repositories/feed_engagement_repository.dart';
import '../repositories/firestore_feed_engagement_repository.dart';

part 'feed_engagement_provider.g.dart';

@riverpod
FeedEngagementRepository feedEngagementRepository(FeedEngagementRepositoryRef ref) {
  return FirestoreFeedEngagementRepository();
}
