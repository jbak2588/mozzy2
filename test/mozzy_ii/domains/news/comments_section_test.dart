import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mozzy/mozzy_ii/domains/news/models/comment_model.dart';
import 'package:mozzy/mozzy_ii/domains/news/providers/comments_provider.dart';
import 'package:mozzy/mozzy_ii/domains/news/widgets/comments_section.dart';

void main() {
  testWidgets('CommentsSection renders correctly when empty', (tester) async {
    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          currentCommentUserIdProvider.overrideWith((ref) => 'u1'),
          visibleTopLevelCommentsProvider(const VisibleCommentsQuery(postId: 'p1', currentUserId: 'u1'))
              .overrideWith((ref) => []),
        ],
        child: const MaterialApp(
          home: Scaffold(
            body: CommentsSection(postId: 'p1', postOwnerId: 'o1'),
          ),
        ),
      ),
    );

    await tester.pump();
    await tester.pump(const Duration(milliseconds: 500));

    expect(find.byKey(const Key('commentsSection')), findsOneWidget);
    expect(find.byKey(const Key('commentInputField')), findsOneWidget);
    expect(find.byKey(const Key('commentSubmitButton')), findsOneWidget);
  });

  testWidgets('CommentsSection renders public comments', (tester) async {
    final comment = CommentModel(
      id: 'c1',
      postId: 'p1',
      userId: 'u1',
      content: 'Public comment',
      createdAt: DateTime.now(),
      isSecret: false,
    );

    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          currentCommentUserIdProvider.overrideWith((ref) => 'u1'),
          visibleTopLevelCommentsProvider(const VisibleCommentsQuery(postId: 'p1', currentUserId: 'u1'))
              .overrideWith((ref) => [comment]),
          visibleRepliesByCommentProvider(const VisibleRepliesQuery(postId: 'p1', parentCommentId: 'c1', currentUserId: 'u1'))
              .overrideWith((ref) => []),
        ],
        child: const MaterialApp(
          home: Scaffold(
            body: CommentsSection(postId: 'p1', postOwnerId: 'o1'),
          ),
        ),
      ),
    );

    await tester.pump();
    await tester.pump(const Duration(milliseconds: 500));

    expect(find.text('Public comment'), findsOneWidget);
    expect(find.byKey(const Key('secretBadge_c1')), findsNothing);
  });

  testWidgets('CommentsSection renders secret badge for secret comments', (tester) async {
    final comment = CommentModel(
      id: 'c1',
      postId: 'p1',
      userId: 'u1',
      content: 'Secret comment',
      createdAt: DateTime.now(),
      isSecret: true,
    );

    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          currentCommentUserIdProvider.overrideWith((ref) => 'u1'),
          visibleTopLevelCommentsProvider(const VisibleCommentsQuery(postId: 'p1', currentUserId: 'u1'))
              .overrideWith((ref) => [comment]),
          visibleRepliesByCommentProvider(const VisibleRepliesQuery(postId: 'p1', parentCommentId: 'c1', currentUserId: 'u1'))
              .overrideWith((ref) => []),
        ],
        child: const MaterialApp(
          home: Scaffold(
            body: CommentsSection(postId: 'p1', postOwnerId: 'o1'),
          ),
        ),
      ),
    );

    await tester.pump();
    await tester.pump(const Duration(milliseconds: 500));

    expect(find.text('Secret comment'), findsOneWidget);
    expect(find.byKey(const Key('secretBadge_c1')), findsOneWidget);
  });

  testWidgets('CommentsSection reply flow works', (tester) async {
    final comment = CommentModel(
      id: 'c1',
      postId: 'p1',
      userId: 'u1',
      content: 'Parent comment',
      createdAt: DateTime.now(),
    );

    final reply = CommentModel(
      id: 'r1',
      postId: 'p1',
      userId: 'u1',
      content: 'Reply comment',
      createdAt: DateTime.now(),
      parentCommentId: 'c1',
    );

    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          currentCommentUserIdProvider.overrideWith((ref) => 'u1'),
          visibleTopLevelCommentsProvider(const VisibleCommentsQuery(postId: 'p1', currentUserId: 'u1'))
              .overrideWith((ref) => [comment]),
          visibleRepliesByCommentProvider(const VisibleRepliesQuery(postId: 'p1', parentCommentId: 'c1', currentUserId: 'u1'))
              .overrideWith((ref) => [reply]),
        ],
        child: const MaterialApp(
          home: Scaffold(
            body: CommentsSection(postId: 'p1', postOwnerId: 'o1'),
          ),
        ),
      ),
    );

    await tester.pump();
    await tester.pump(const Duration(milliseconds: 500));

    expect(find.text('Parent comment'), findsOneWidget);
    expect(find.text('Reply comment'), findsOneWidget);

    // Tap reply button
    await tester.tap(find.byKey(const Key('commentReplyButton_c1')));
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 500));

    // Reply mode label should appear
    expect(find.byKey(const Key('replyModeLabel')), findsOneWidget);

    // Tap cancel
    await tester.tap(find.text('news.cancelReply'));
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 500));

    // Reply mode label should disappear
    expect(find.byKey(const Key('replyModeLabel')), findsNothing);
  });
}
