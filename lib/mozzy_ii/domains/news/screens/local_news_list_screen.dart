import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:go_router/go_router.dart';
import '../providers/posts_provider.dart';
import '../../../geo/providers/location_provider.dart';
import '../widgets/local_news_card.dart';

class LocalNewsListScreen extends ConsumerStatefulWidget {
  const LocalNewsListScreen({super.key});

  @override
  ConsumerState<LocalNewsListScreen> createState() =>
      _LocalNewsListScreenState();
}

class _LocalNewsListScreenState extends ConsumerState<LocalNewsListScreen> {
  String _selectedCategory = 'all';

  final List<String> categories = [
    'all',
    'umum',
    'info',
    'event',
    'darurat',
    'kuliner',
    'tips',
  ];

  @override
  Widget build(BuildContext context) {
    final locationAsync = ref.watch(locationProvider);

    final kecamatan = locationAsync.maybeWhen(
      data: (loc) => loc?.idAddress?.kecamatan,
      orElse: () => null,
    );

    final postsAsync = ref.watch(
      postsByCategoryAndKecamatanProvider(
        PostsQuery(category: _selectedCategory, kecamatan: kecamatan),
      ),
    );

    return Scaffold(
      key: const Key('localNewsListScreen'),
      appBar: AppBar(title: Text('news.title'.tr())),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    kecamatan != null
                        ? '$kecamatan, ${locationAsync.maybeWhen(data: (loc) => loc?.idAddress?.kabupaten ?? '', orElse: () => '')}'
                        : 'news.locationFallback'.tr(),
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 48,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              itemBuilder: (context, index) {
                final cat = categories[index];
                final label = cat == 'all'
                    ? 'news.all'.tr()
                    : 'news.category.$cat'.tr();
                final selected = cat == _selectedCategory;
                return ChoiceChip(
                  label: Text(label),
                  selected: selected,
                  onSelected: (_) => setState(() => _selectedCategory = cat),
                );
              },
              separatorBuilder: (_, _) => const SizedBox(width: 8),
              itemCount: categories.length,
            ),
          ),
          Expanded(
            child: postsAsync.when(
              data: (posts) {
                if (posts.isEmpty) {
                  return Center(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          'news.emptyTitle'.tr(),
                          style: Theme.of(context).textTheme.titleLarge,
                        ),
                        const SizedBox(height: 8),
                        Text(
                          'news.emptyDescription'.tr(),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  );
                }
                return ListView.separated(
                  itemBuilder: (context, index) =>
                      LocalNewsCard(post: posts[index]),
                  separatorBuilder: (_, _) => const Divider(height: 1),
                  itemCount: posts.length,
                );
              },
              loading: () => const Center(child: CircularProgressIndicator()),
              error: (e, st) => Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(e.toString()),
                    const SizedBox(height: 8),
                    ElevatedButton(
                      onPressed: () => ref.refresh(
                        postsByCategoryAndKecamatanProvider(
                          PostsQuery(
                            category: _selectedCategory,
                            kecamatan: kecamatan,
                          ),
                        ),
                      ),
                      child: Text('news.retry'.tr()),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        key: const Key('localNewsCreateFab'),
        heroTag: 'news_create_fab',
        onPressed: () async {
          await context.push('/news/create');
          ref.invalidate(postsByCategoryAndKecamatanProvider);
        },
        label: Text('news.createPost'.tr()),
        icon: const Icon(Icons.create),
      ),
    );
  }
}
