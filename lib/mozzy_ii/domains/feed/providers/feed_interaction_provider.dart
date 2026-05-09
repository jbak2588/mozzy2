import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../repositories/feed_interaction_repository.dart';
import '../repositories/cloud_functions_feed_interaction_repository.dart';

final feedInteractionRepositoryProvider = Provider<FeedInteractionRepository>((ref) {
  return CloudFunctionsFeedInteractionRepository();
});

final seenItemsProvider = Provider.autoDispose<ValueNotifier<Set<String>>>((ref) {
  final notifier = ValueNotifier<Set<String>>({});
  ref.onDispose(notifier.dispose);
  return notifier;
});
