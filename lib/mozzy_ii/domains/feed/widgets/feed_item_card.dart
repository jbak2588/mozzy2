import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/feed_item_model.dart';
import '../models/feed_item_type.dart';
import '../models/feed_interaction_event.dart';
import '../models/feed_interaction_type.dart';
import '../providers/feed_interaction_provider.dart';
import '../providers/feed_session_provider.dart';

class FeedItemCard extends ConsumerWidget {
  final FeedItemModel item;
  final int position;
  final bool hasSemanticIntent;
  final String? intentLengthBucket;

  const FeedItemCard({
    super.key,
    required this.item,
    required this.position,
    this.hasSemanticIntent = false,
    this.intentLengthBucket,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      elevation: 2,
      child: InkWell(
        onTap: () {
          // Log interaction
          final event = FeedInteractionEvent(
            eventType: FeedInteractionType.cardTap,
            feedItemId: item.id,
            sourceId: item.sourceId,
            sourceType: item.type.name,
            route: item.route,
            position: position,
            isPromoted: item.isPromoted,
            hasSemanticIntent: hasSemanticIntent,
            intentLengthBucket: intentLengthBucket,
            sessionId: ref.read(feedSessionIdProvider),
            clientCreatedAt: DateTime.now(),
          );
          ref.read(feedInteractionRepositoryProvider).logInteraction(event);

          // Navigate
          context.push(item.route);
        },
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Image Thumbnail
              _buildThumbnail(),
              const SizedBox(width: 12),
              // Content
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        _buildTypeBadge(),
                        if (item.isPromoted) _buildPromotedBadge(),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Text(
                      item.title,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    if (item.subtitle != null) ...[
                      const SizedBox(height: 4),
                      Text(
                        item.subtitle!,
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.grey[700],
                        ),
                      ),
                    ],
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        const Icon(Icons.location_on_outlined, size: 14, color: Colors.grey),
                        const SizedBox(width: 4),
                        Text(
                          item.locationText ?? 'feed.unknownLocation'.tr(),
                          style: const TextStyle(fontSize: 12, color: Colors.grey),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildThumbnail() {
    return Container(
      width: 80,
      height: 80,
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(8),
        image: item.imageUrl != null
            ? DecorationImage(
                image: NetworkImage(item.imageUrl!),
                fit: BoxFit.cover,
              )
            : null,
      ),
      child: item.imageUrl == null
          ? Icon(
              item.type == FeedItemType.job ? Icons.work_outline : Icons.shopping_bag_outlined,
              color: Colors.grey[400],
            )
          : null,
    );
  }

  Widget _buildTypeBadge() {
    String label = 'feed.${item.type.name}'.tr();
    Color color = item.type == FeedItemType.job ? Colors.blue : Colors.orange;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(4),
        border: Border.all(color: color.withValues(alpha: 0.5)),
      ),
      child: Text(
        label,
        style: TextStyle(
          fontSize: 10,
          color: color,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget _buildPromotedBadge() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
      decoration: BoxDecoration(
        color: Colors.purple.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(4),
        border: Border.all(color: Colors.purple.withValues(alpha: 0.5)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(Icons.bolt, size: 10, color: Colors.purple),
          Text(
            'feed.promoted'.tr(),
            style: const TextStyle(
              fontSize: 10,
              color: Colors.purple,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
