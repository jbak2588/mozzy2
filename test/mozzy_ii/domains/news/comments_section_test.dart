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
          commentsByPostProvider('p1').overrideWith((ref) => []),
        ],
        child: const MaterialApp(
          home: Scaffold(
            body: CommentsSection(postId: 'p1'),
          ),
        ),
      ),
    );

    await tester.pumpAndSettle();

    expect(find.byKey(const Key('commentsSection')), findsOneWidget);
    expect(find.byKey(const Key('commentInputField')), findsOneWidget);
    expect(find.byKey(const Key('commentSubmitButton')), findsOneWidget);
    // Since localization might not be active, the key is rendered directly
    expect(find.text('news.noCommentsYet'), findsOneWidget);
  });

  testWidgets('CommentsSection renders comments', (tester) async {
    final comment = CommentModel(
      id: 'c1',
      postId: 'p1',
      userId: 'u1',
      content: 'This is a test comment',
      createdAt: DateTime.now(),
    );

    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          commentsByPostProvider('p1').overrideWith((ref) => [comment]),
        ],
        child: const MaterialApp(
          home: Scaffold(
            body: CommentsSection(postId: 'p1'),
          ),
        ),
      ),
    );

    await tester.pumpAndSettle();

    expect(find.byKey(const Key('commentList')), findsOneWidget);
    expect(find.text('This is a test comment'), findsOneWidget);
  });
}
