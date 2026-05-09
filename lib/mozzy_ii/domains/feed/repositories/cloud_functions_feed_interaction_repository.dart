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
      // Fire and forget: don't wait for completion to avoid blocking UI
      callable.call(event.toSafeJson()).then((_) {
        if (kDebugMode) {
          print('Logged interaction: ${event.eventType.name} for ${event.feedItemId}');
        }
      }).catchError((e) {
        if (kDebugMode) {
          print('Failed to log interaction: $e');
        }
      });
    } catch (e) {
      if (kDebugMode) {
        print('Error calling interaction function: $e');
      }
    }
  }
}
