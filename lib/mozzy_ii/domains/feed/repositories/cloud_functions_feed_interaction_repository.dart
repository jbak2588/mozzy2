import 'package:cloud_functions/cloud_functions.dart';
import 'package:flutter/foundation.dart';
import '../models/feed_interaction_event.dart';
import 'feed_interaction_repository.dart';

class CloudFunctionsFeedInteractionRepository implements FeedInteractionRepository {
  final FirebaseFunctions _functions;

  CloudFunctionsFeedInteractionRepository({FirebaseFunctions? functions})
      : _functions = functions ?? FirebaseFunctions.instance;

  @override
  Future<void> logInteraction(FeedInteractionEvent event) async {
    try {
      final callable = _functions.httpsCallable('logFeedInteraction');
      await callable.call(event.toSafeJson());
      if (kDebugMode) {
        debugPrint('Logged interaction: ${event.eventType.wireValue} for ${event.feedItemId}');
      }
    } on FirebaseFunctionsException catch (e) {
      if (kDebugMode) {
        debugPrint('Failed to log feed interaction: ${e.code} - ${e.message}');
      }
    } catch (e) {
      if (kDebugMode) {
        debugPrint('Error calling interaction function: $e');
      }
    }
  }
}
