import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:easy_localization/easy_localization.dart';
import '../providers/smart_feed_provider.dart';
import '../widgets/feed_item_card.dart';
import '../widgets/feed_type_chip_bar.dart';
import '../widgets/smart_feed_search_bar.dart';

class SmartFeedScreen extends ConsumerWidget {
  const SmartFeedScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final feedAsync = ref.watch(smartFeedProvider);
    final filteredItems = ref.watch(filteredSmartFeedProvider);

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
                      return FeedItemCard(item: filteredItems[index]);
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
