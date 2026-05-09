import '../models/feed_item_model.dart';
import '../../../geo/models/location_parts.dart';

abstract class SmartFeedRepository {
  Stream<List<FeedItemModel>> getSmartFeed({LocationParts? locationFilter, int limit = 60});
}
