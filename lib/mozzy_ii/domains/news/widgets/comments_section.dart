import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:easy_localization/easy_localization.dart';

import '../models/comment_model.dart';
import '../providers/comments_provider.dart';

class CommentsSection extends ConsumerStatefulWidget {
  final String postId;
  final String postOwnerId;

  const CommentsSection({super.key, required this.postId, required this.postOwnerId});

  @override
  ConsumerState<CommentsSection> createState() => _CommentsSectionState();
}

class _CommentsSectionState extends ConsumerState<CommentsSection> {
  final _controller = TextEditingController();
  final _focusNode = FocusNode();
  bool _isSubmitting = false;
  String? _replyingToCommentId;
  String? _replyingToOwnerId;
  bool _isSecret = false;

  @override
  void dispose() {
    _controller.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  Future<void> _submitComment() async {
    final content = _controller.text.trim();
    if (content.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('news.commentRequired'.tr())),
      );
      return;
    }

    final userId = ref.read(currentCommentUserIdProvider);
    if (userId.isEmpty) {
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

      final visibleIds = {
        userId,
        widget.postOwnerId,
        _replyingToOwnerId,
      }.whereType<String>().toList();

      final comment = CommentModel(
        id: newId,
        postId: widget.postId,
        userId: userId,
        content: content,
        createdAt: DateTime.now().toUtc(),
        parentCommentId: _replyingToCommentId,
        isSecret: _isSecret,
        postOwnerId: widget.postOwnerId,
        parentCommentOwnerId: _replyingToOwnerId,
        visibleToUserIds: visibleIds,
      );

      final action = ref.read(createCommentProvider);
      await action(comment);

      _controller.clear();
      _focusNode.unfocus();

      final parentIdToInvalidate = _replyingToCommentId;
      
      setState(() {
        _replyingToCommentId = null;
        _replyingToOwnerId = null;
        _isSecret = false;
      });

      if (parentIdToInvalidate == null) {
        ref.invalidate(visibleTopLevelCommentsProvider(VisibleCommentsQuery(postId: widget.postId, currentUserId: userId)));
      } else {
        ref.invalidate(visibleRepliesByCommentProvider(VisibleRepliesQuery(
          postId: widget.postId,
          parentCommentId: parentIdToInvalidate,
          currentUserId: userId,
        )));
      }
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

  void _onReplyPressed(String commentId, String ownerId) {
    setState(() {
      _replyingToCommentId = commentId;
      _replyingToOwnerId = ownerId;
    });
    _focusNode.requestFocus();
  }

  void _onCancelReply() {
    setState(() {
      _replyingToCommentId = null;
      _replyingToOwnerId = null;
    });
    _focusNode.unfocus();
  }

  @override
  Widget build(BuildContext context) {
    final userId = ref.watch(currentCommentUserIdProvider);
    final commentsAsync = ref.watch(visibleTopLevelCommentsProvider(VisibleCommentsQuery(postId: widget.postId, currentUserId: userId)));

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
                    style: const TextStyle(color: Colors.grey)),
              );
            }
            return ListView.builder(
              key: const Key('commentList'),
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: comments.length,
              itemBuilder: (context, index) {
                final c = comments[index];
                return _CommentItem(
                  comment: c,
                  currentUserId: userId,
                  onReplyPressed: () => _onReplyPressed(c.id, c.userId),
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
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (_replyingToCommentId != null)
                Container(
                  key: const Key('replyModeLabel'),
                  padding: const EdgeInsets.only(bottom: 8.0),
                  child: Row(
                    children: [
                      Text(
                        'news.replyingTo'.tr(),
                        style: const TextStyle(
                            fontStyle: FontStyle.italic, color: Colors.blue),
                      ),
                      const Spacer(),
                      InkWell(
                        onTap: _onCancelReply,
                        child: Text(
                          'news.cancelReply'.tr(),
                          style: const TextStyle(color: Colors.red),
                        ),
                      )
                    ],
                  ),
                ),
              Row(
                children: [
                  Checkbox(
                    key: const Key('commentSecretToggle'),
                    value: _isSecret,
                    onChanged: (val) => setState(() => _isSecret = val ?? false),
                  ),
                  Text('news.secret'.tr()),
                  const SizedBox(width: 8),
                  Expanded(
                    child: TextField(
                      key: const Key('commentInputField'),
                      controller: _controller,
                      focusNode: _focusNode,
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
            ],
          ),
        ),
      ],
    );
  }
}

class _CommentItem extends ConsumerWidget {
  final CommentModel comment;
  final String currentUserId;
  final VoidCallback onReplyPressed;

  const _CommentItem({
    required this.comment,
    required this.currentUserId,
    required this.onReplyPressed,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final repliesAsync = ref.watch(visibleRepliesByCommentProvider(VisibleRepliesQuery(
      postId: comment.postId,
      parentCommentId: comment.id,
      currentUserId: currentUserId,
    )));

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        ListTile(
          title: Row(
            children: [
              if (comment.isSecret)
                Padding(
                  padding: const EdgeInsets.only(right: 8.0),
                  child: Icon(Icons.lock, size: 16, color: Colors.amber, key: Key('secretBadge_${comment.id}')),
                ),
              Expanded(child: Text(comment.content)),
            ],
          ),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                comment.createdAt.toLocal().toString().split('.')[0],
                style: const TextStyle(fontSize: 12),
              ),
              InkWell(
                key: Key('commentReplyButton_${comment.id}'),
                onTap: onReplyPressed,
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 4.0),
                  child: Text(
                    'news.reply'.tr(),
                    style: const TextStyle(
                        fontSize: 12, fontWeight: FontWeight.bold),
                  ),
                ),
              )
            ],
          ),
          trailing: Text('Trust: ${comment.trustScore.toStringAsFixed(1)}'),
        ),
        repliesAsync.when(
          data: (replies) {
            if (replies.isEmpty) return const SizedBox.shrink();
            return Padding(
              padding: const EdgeInsets.only(left: 32.0),
              child: Column(
                children: replies.map((r) {
                  return ListTile(
                    key: Key('replyItem_${r.id}'),
                    title: Row(
                      children: [
                        if (r.isSecret)
                          Padding(
                            padding: const EdgeInsets.only(right: 8.0),
                            child: Icon(Icons.lock, size: 14, color: Colors.amber, key: Key('secretBadge_${r.id}')),
                          ),
                        Expanded(child: Text(r.content)),
                      ],
                    ),
                    subtitle: Text(
                      r.createdAt.toLocal().toString().split('.')[0],
                      style: const TextStyle(fontSize: 12),
                    ),
                  );
                }).toList(),
              ),
            );
          },
          loading: () => const SizedBox.shrink(),
          error: (e, st) => const SizedBox.shrink(),
        ),
        const Divider(),
      ],
    );
  }
}
