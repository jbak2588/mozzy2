import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:easy_localization/easy_localization.dart';
import '../providers/smart_feed_provider.dart';

class SmartFeedSearchBar extends ConsumerStatefulWidget {
  const SmartFeedSearchBar({super.key});

  @override
  ConsumerState<SmartFeedSearchBar> createState() => _SmartFeedSearchBarState();
}

class _SmartFeedSearchBarState extends ConsumerState<SmartFeedSearchBar> {
  late final TextEditingController _controller;
  final FocusNode _focusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(
      text: ref.read(smartFeedSearchIntentProvider),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  void _onSearch() {
    final intent = _controller.text;
    ref.read(smartFeedSearchIntentProvider.notifier).setIntent(intent);
    _focusNode.unfocus();
  }

  void _onClear() {
    _controller.clear();
    ref.read(smartFeedSearchIntentProvider.notifier).clearIntent();
    _focusNode.unfocus();
  }

  @override
  Widget build(BuildContext context) {
    final currentIntent = ref.watch(smartFeedSearchIntentProvider);
    final hasIntent = currentIntent.isNotEmpty;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.surfaceContainerHighest.withOpacity(0.5),
              borderRadius: BorderRadius.circular(12),
            ),
            child: TextField(
              controller: _controller,
              focusNode: _focusNode,
              textInputAction: TextInputAction.search,
              onSubmitted: (_) => _onSearch(),
              decoration: InputDecoration(
                hintText: 'feed.searchHint'.tr(),
                hintStyle: const TextStyle(fontSize: 14),
                prefixIcon: const Icon(Icons.search),
                suffixIcon: hasIntent
                    ? IconButton(
                        icon: const Icon(Icons.clear),
                        onPressed: _onClear,
                      )
                    : null,
                border: InputBorder.none,
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 12,
                ),
              ),
            ),
          ),
          if (hasIntent) ...[
            const SizedBox(height: 8),
            Row(
              children: [
                Chip(
                  label: Text(
                    'feed.semanticRankingActive'.tr(args: [currentIntent]),
                    style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
                  ),
                  backgroundColor: Theme.of(context).colorScheme.primaryContainer,
                  onDeleted: _onClear,
                  deleteIconColor: Theme.of(context).colorScheme.primary,
                  padding: const EdgeInsets.all(0),
                  materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    'feed.semanticRankingInfo'.tr(),
                    style: TextStyle(
                      fontSize: 10,
                      color: Theme.of(context).colorScheme.outline,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
          ],
        ],
      ),
    );
  }
}
