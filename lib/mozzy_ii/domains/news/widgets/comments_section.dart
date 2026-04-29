import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:easy_localization/easy_localization.dart';

import '../../../core/config/integration_test_config.dart';
import '../models/comment_model.dart';
import '../providers/comments_provider.dart';

class CommentsSection extends ConsumerStatefulWidget {
  final String postId;

  const CommentsSection({super.key, required this.postId});

  @override
  ConsumerState<CommentsSection> createState() => _CommentsSectionState();
}

class _CommentsSectionState extends ConsumerState<CommentsSection> {
  final _controller = TextEditingController();
  bool _isSubmitting = false;

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  String? _getUserId() {
    if (IntegrationTestConfig.enabled) {
      return IntegrationTestConfig.testUserId;
    }
    return FirebaseAuth.instance.currentUser?.uid;
  }

  Future<void> _submitComment() async {
    final content = _controller.text.trim();
    if (content.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('news.commentRequired'.tr())),
      );
      return;
    }

    final userId = _getUserId();
    if (userId == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('news.loginRequired'.tr())),
      );
      return;
    }

    setState(() => _isSubmitting = true);

    try {
      final repo = ref.read(commentRepositoryProvider);
      String newId;
      try {
        newId = repo.getCommentsCollection(widget.postId).doc().id;
      } catch (_) {
        newId = 'integration-comment-${DateTime.now().millisecondsSinceEpoch}';
      }

      final comment = CommentModel(
        id: newId,
        postId: widget.postId,
        userId: userId,
        content: content,
        createdAt: DateTime.now().toUtc(),
      );

      final action = ref.read(createCommentProvider);
      await action(comment);

      _controller.clear();
      FocusManager.instance.primaryFocus?.unfocus();

      ref.invalidate(commentsByPostProvider(widget.postId));
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('news.commentCreateFailed'.tr())),
        );
      }
    } finally {
      if (mounted) {
        setState(() => _isSubmitting = false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final commentsAsync = ref.watch(commentsByPostProvider(widget.postId));

    return Column(
      key: const Key('commentsSection'),
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
          child: Text(
            'news.comments'.tr(),
            style: Theme.of(context).textTheme.titleLarge,
          ),
        ),
        const Divider(),
        commentsAsync.when(
          data: (comments) {
            if (comments.isEmpty) {
              return Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text('news.noCommentsYet'.tr(),
                    style: TextStyle(color: Colors.grey)),
              );
            }
            return ListView.builder(
              key: const Key('commentList'),
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: comments.length,
              itemBuilder: (context, index) {
                final c = comments[index];
                return ListTile(
                  title: Text(c.content),
                  subtitle: Text(
                    c.createdAt.toLocal().toString().split('.')[0],
                    style: const TextStyle(fontSize: 12),
                  ),
                  trailing: Text('Trust: ${c.trustScore.toStringAsFixed(1)}'),
                );
              },
            );
          },
          loading: () => const Center(child: CircularProgressIndicator()),
          error: (e, st) => Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text('Error: $e'),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            children: [
              Expanded(
                child: TextField(
                  key: const Key('commentInputField'),
                  controller: _controller,
                  decoration: InputDecoration(
                    hintText: 'news.commentHint'.tr(),
                    border: const OutlineInputBorder(),
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 8,
                    ),
                  ),
                  maxLines: null,
                ),
              ),
              const SizedBox(width: 8),
              ElevatedButton(
                key: const Key('commentSubmitButton'),
                onPressed: _isSubmitting ? null : _submitComment,
                child: _isSubmitting
                    ? const SizedBox(
                        width: 16,
                        height: 16,
                        child: CircularProgressIndicator(strokeWidth: 2),
                      )
                    : Text('news.commentSubmit'.tr()),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
