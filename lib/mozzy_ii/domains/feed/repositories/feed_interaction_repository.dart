import '../models/feed_interaction_event.dart';

abstract class FeedInteractionRepository {
  Future<void> logInteraction(FeedInteractionEvent event);
}
