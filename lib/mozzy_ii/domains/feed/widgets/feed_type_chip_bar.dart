import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:easy_localization/easy_localization.dart';
import '../providers/smart_feed_provider.dart';
import '../models/feed_item_type.dart';

class FeedTypeChipBar extends ConsumerWidget {
  const FeedTypeChipBar({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedFilter = ref.watch(feedFilterProvider);

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Row(
        children: [
          _buildChip(ref, null, 'feed.all'.tr(), selectedFilter == null),
          const SizedBox(width: 8),
          _buildChip(ref, FeedItemType.job.name, 'feed.jobs'.tr(), selectedFilter == FeedItemType.job.name),
          const SizedBox(width: 8),
          _buildChip(
            ref,
            FeedItemType.marketplaceProduct.name,
            'feed.marketplace'.tr(),
            selectedFilter == FeedItemType.marketplaceProduct.name,
          ),
          const SizedBox(width: 8),
          _buildChip(
            ref,
            FeedItemType.localNews.name,
            'feed.localNews'.tr(),
            selectedFilter == FeedItemType.localNews.name,
          ),
          // Add more if needed later
        ],
      ),
    );
  }

  Widget _buildChip(WidgetRef ref, String? type, String label, bool isSelected) {
    return ChoiceChip(
      label: Text(label),
      selected: isSelected,
      onSelected: (selected) {
        if (selected) {
          ref.read(feedFilterProvider.notifier).setFilter(type);
        }
      },
    );
  }
}
