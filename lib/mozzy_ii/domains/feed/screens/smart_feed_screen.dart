import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:easy_localization/easy_localization.dart';
import '../providers/smart_feed_provider.dart';
import '../widgets/feed_item_card.dart';
import '../widgets/feed_type_chip_bar.dart';
import '../widgets/smart_feed_search_bar.dart';

import '../models/feed_interaction_event.dart';
import '../models/feed_interaction_type.dart';
import '../providers/feed_interaction_provider.dart';
import '../providers/feed_session_provider.dart';

class SmartFeedScreen extends ConsumerWidget {
  const SmartFeedScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final feedAsync = ref.watch(smartFeedProvider);
    final filteredItems = ref.watch(filteredSmartFeedProvider);
    final searchIntent = ref.watch(smartFeedSearchIntentProvider);
    final hasIntent = searchIntent.isNotEmpty;
    final intentLengthBucket = hasIntent 
        ? (searchIntent.length <= 10 ? 'short' : (searchIntent.length <= 30 ? 'medium' : 'long'))
        : 'none';

    return Scaffold(
      appBar: AppBar(
        title: Text('feed.title'.tr()),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () => ref.invalidate(smartFeedProvider),
          ),
        ],
      ),
      body: Column(
        children: [
          const SmartFeedSearchBar(),
          const FeedTypeChipBar(),
          Expanded(
            child: feedAsync.when(
              data: (items) {
                if (items.isEmpty) {
                  return Center(
                    child: Text('feed.empty'.tr()),
                  );
                }
                
                if (filteredItems.isEmpty) {
                  return Center(
                    child: Text('feed.noFilteredItems'.tr()),
                  );
                }

                return RefreshIndicator(
                  onRefresh: () async => ref.invalidate(smartFeedProvider),
                  child: ListView.builder(
                    itemCount: filteredItems.length,
                    itemBuilder: (context, index) {
                      final item = filteredItems[index];
                      
                      // Log impression once per item per screen session
                      WidgetsBinding.instance.addPostFrameCallback((_) {
                        final seenItems = ref.read(seenItemsProvider);
                        if (!seenItems.value.contains(item.id)) {
                          seenItems.value = {...seenItems.value, item.id};
                          
                          final event = FeedInteractionEvent(
                            eventType: FeedInteractionType.impression,
                            feedItemId: item.id,
                            sourceId: item.sourceId,
                            sourceType: item.type.name,
                            position: index,
                            isPromoted: item.isPromoted,
                            hasSemanticIntent: hasIntent,
                            intentLengthBucket: intentLengthBucket,
                            sessionId: ref.read(feedSessionIdProvider),
                            clientCreatedAt: DateTime.now(),
                          );
                          unawaited(
                            ref.read(feedInteractionRepositoryProvider).logInteraction(event),
                          );
                        }
                      });

                      return FeedItemCard(
                        item: item,
                        position: index,
                        hasSemanticIntent: hasIntent,
                        intentLengthBucket: intentLengthBucket,
                      );
                    },
                  ),
                );
              },
              loading: () => const Center(child: CircularProgressIndicator()),
              error: (err, stack) => Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('feed.error'.tr()),
                    const SizedBox(height: 8),
                    ElevatedButton(
                      onPressed: () => ref.invalidate(smartFeedProvider),
                      child: Text('feed.refresh'.tr()),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
