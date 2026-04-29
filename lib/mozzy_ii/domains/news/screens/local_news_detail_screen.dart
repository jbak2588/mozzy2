import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../providers/posts_provider.dart';
import '../widgets/cross_link_section.dart';
import '../widgets/comments_section.dart';

class LocalNewsDetailScreen extends ConsumerWidget {
  final String postId;

  const LocalNewsDetailScreen({super.key, required this.postId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final postAsync = ref.watch(postByIdProvider(postId));

    return Scaffold(
      key: const Key('localNewsDetailScreen'),
      appBar: AppBar(
        title: const Text('news.detailTitle').tr(),
      ),
      body: postAsync.when(
        data: (post) {
          if (post == null) {
            return Center(
              child: const Text('news.notFound').tr(),
            );
          }

          return SingleChildScrollView(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (post.imageUrls.isNotEmpty)
                  SizedBox(
                    height: 200,
                    width: double.infinity,
                    child: Image.network(
                      post.imageUrls.first,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) => Container(color: Colors.grey.shade300),
                    ),
                  )
                else
                  Container(
                    height: 200,
                    width: double.infinity,
                    color: Colors.grey.shade300,
                    child: const Center(child: Icon(Icons.image_not_supported, size: 50, color: Colors.grey)),
                  ),
                const SizedBox(height: 16),
                Chip(
                  label: Text(post.category),
                ),
                const SizedBox(height: 8),
                Text(
                  post.title,
                  style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8),
                Text(
                  '${'news.postedAt'.tr()}: ${DateFormat('yyyy-MM-dd HH:mm').format(post.createdAt.toLocal())}',
                  style: const TextStyle(fontSize: 12, color: Colors.grey),
                ),
                Text(
                  '${'news.location'.tr()}: ${post.location.idAddress?.kecamatan ?? ''}, ${post.location.idAddress?.kabupaten ?? ''}',
                  style: const TextStyle(fontSize: 12, color: Colors.grey),
                ),
                const SizedBox(height: 16),
                Text(
                  post.content,
                  style: const TextStyle(fontSize: 16),
                ),
                const SizedBox(height: 24),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('${'news.signal'.tr()}: ${post.signalScore.toStringAsFixed(2)}', style: const TextStyle(fontSize: 12)),
                    Text('${'news.scope'.tr()}: ${post.geoScope.name}', style: const TextStyle(fontSize: 12)),
                  ],
                ),
                Text('Trust Score: ${post.trustScore.toStringAsFixed(2)}', style: const TextStyle(fontSize: 12)),
                const SizedBox(height: 24),
                const Divider(),
                const SizedBox(height: 16),
                const CrossLinkSection(),
                const SizedBox(height: 24),
                CommentsSection(postId: post.id, postOwnerId: post.userId),
                const SizedBox(height: 40),
              ],
            ),
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (err, stack) => Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(err.toString()),
              ElevatedButton(
                onPressed: () => ref.refresh(postByIdProvider(postId)),
                child: Text('news.retry'.tr()),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
