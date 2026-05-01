import 'package:flutter_test/flutter_test.dart';
import 'package:mozzy/mozzy_ii/domains/news/models/comment_model.dart';
import 'package:mozzy/mozzy_ii/domains/news/repositories/in_memory_comment_repository.dart';

void main() {
  group('InMemoryCommentRepository', () {
    late InMemoryCommentRepository repo;

    setUp(() {
      repo = InMemoryCommentRepository();
    });

    test('createComment and fetchTopLevelComments work correctly', () async {
      final comment = CommentModel(
        id: 'c1',
        postId: 'p1',
        userId: 'u1',
        content: 'hello',
        createdAt: DateTime.now().toUtc(),
      );

      await repo.createComment(comment);
      final comments = await repo.fetchTopLevelComments('p1');

      expect(comments.length, 1);
      expect(comments.first.id, 'c1');
    });

    test(
      'softDeleteComment hides comment from fetchTopLevelComments',
      () async {
        final comment = CommentModel(
          id: 'c1',
          postId: 'p1',
          userId: 'u1',
          content: 'hello',
          createdAt: DateTime.now().toUtc(),
        );

        await repo.createComment(comment);
        await repo.softDeleteComment(postId: 'p1', commentId: 'c1');

        final comments = await repo.fetchTopLevelComments('p1');
        expect(comments.isEmpty, true);
      },
    );

    test('fetchTopLevelComments excludes replies', () async {
      final topLevel = CommentModel(
        id: 'c1',
        postId: 'p1',
        userId: 'u1',
        content: 'hello',
        createdAt: DateTime.now().toUtc(),
      );
      final reply = CommentModel(
        id: 'r1',
        postId: 'p1',
        userId: 'u1',
        content: 'reply',
        createdAt: DateTime.now().toUtc(),
        parentCommentId: 'c1',
      );

      await repo.createComment(topLevel);
      await repo.createComment(reply);

      final comments = await repo.fetchTopLevelComments('p1');
      expect(comments.length, 1);
      expect(comments.first.id, 'c1');
    });

    test('fetchReplies returns only replies for parent', () async {
      final reply1 = CommentModel(
        id: 'r1',
        postId: 'p1',
        userId: 'u1',
        content: 'reply1',
        createdAt: DateTime.now().toUtc(),
        parentCommentId: 'c1',
      );
      final reply2 = CommentModel(
        id: 'r2',
        postId: 'p1',
        userId: 'u1',
        content: 'reply2',
        createdAt: DateTime.now().toUtc(),
        parentCommentId: 'c2', // different parent
      );

      await repo.createComment(reply1);
      await repo.createComment(reply2);

      final replies = await repo.fetchReplies(
        postId: 'p1',
        parentCommentId: 'c1',
      );
      expect(replies.length, 1);
      expect(replies.first.id, 'r1');
    });

    test('softDeleteComment hides reply', () async {
      final reply = CommentModel(
        id: 'r1',
        postId: 'p1',
        userId: 'u1',
        content: 'reply1',
        createdAt: DateTime.now().toUtc(),
        parentCommentId: 'c1',
      );
      await repo.createComment(reply);
      await repo.softDeleteComment(postId: 'p1', commentId: 'r1');

      final replies = await repo.fetchReplies(
        postId: 'p1',
        parentCommentId: 'c1',
      );
      expect(replies.isEmpty, true);
    });

    test('fetchVisibleTopLevelComments respects secret visibility', () async {
      final publicComment = CommentModel(
        id: 'pub1',
        postId: 'p1',
        userId: 'u1',
        content: 'public',
        createdAt: DateTime.now().toUtc(),
        isSecret: false,
      );
      final secretComment = CommentModel(
        id: 'sec1',
        postId: 'p1',
        userId: 'u1',
        content: 'secret',
        createdAt: DateTime.now().toUtc(),
        isSecret: true,
        visibleToUserIds: ['u1', 'owner1'],
      );

      await repo.createComment(publicComment);
      await repo.createComment(secretComment);

      // Authorized user u1
      final visibleToU1 = await repo.fetchVisibleTopLevelComments(
        postId: 'p1',
        currentUserId: 'u1',
      );
      expect(visibleToU1.length, 2);

      // Unauthorized user u2
      final visibleToU2 = await repo.fetchVisibleTopLevelComments(
        postId: 'p1',
        currentUserId: 'u2',
      );
      expect(visibleToU2.length, 1);
      expect(visibleToU2.first.id, 'pub1');
    });

    test('fetchVisibleReplies respects secret visibility', () async {
      final secretReply = CommentModel(
        id: 'r1',
        postId: 'p1',
        userId: 'u2',
        content: 'secret reply',
        createdAt: DateTime.now().toUtc(),
        parentCommentId: 'c1',
        isSecret: true,
        visibleToUserIds: ['u2', 'owner1', 'u1'], // u1 is parent owner
      );

      await repo.createComment(secretReply);

      // Authorized user u1
      final visibleToU1 = await repo.fetchVisibleReplies(
        postId: 'p1',
        parentCommentId: 'c1',
        currentUserId: 'u1',
      );
      expect(visibleToU1.length, 1);

      // Unauthorized user u3
      final visibleToU3 = await repo.fetchVisibleReplies(
        postId: 'p1',
        parentCommentId: 'c1',
        currentUserId: 'u3',
      );
      expect(visibleToU3.length, 0);
    });
  });
}
