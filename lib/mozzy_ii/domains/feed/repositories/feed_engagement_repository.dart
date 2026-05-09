import '../models/feed_engagement_summary.dart';
import '../models/feed_item_model.dart';

abstract class FeedEngagementRepository {
  Stream<Map<String, FeedEngagementSummary>> watchEngagementSummaries({
    required List<FeedItemModel> items,
  });
}
