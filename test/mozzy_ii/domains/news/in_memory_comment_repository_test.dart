import 'package:flutter_test/flutter_test.dart';
import 'package:mozzy/mozzy_ii/domains/news/models/comment_model.dart';
import 'package:mozzy/mozzy_ii/domains/news/repositories/in_memory_comment_repository.dart';

void main() {
  group('InMemoryCommentRepository', () {
    late InMemoryCommentRepository repo;

    setUp(() {
      repo = InMemoryCommentRepository();
    });

    test('createComment and fetchComments work correctly', () async {
      final comment = CommentModel(
        id: 'c1',
        postId: 'p1',
        userId: 'u1',
        content: 'hello',
        createdAt: DateTime.now().toUtc(),
      );

      await repo.createComment(comment);
      final comments = await repo.fetchComments('p1');
      
      expect(comments.length, 1);
      expect(comments.first.id, 'c1');
    });

    test('softDeleteComment hides comment from fetchComments', () async {
      final comment = CommentModel(
        id: 'c1',
        postId: 'p1',
        userId: 'u1',
        content: 'hello',
        createdAt: DateTime.now().toUtc(),
      );

      await repo.createComment(comment);
      await repo.softDeleteComment(postId: 'p1', commentId: 'c1');
      
      final comments = await repo.fetchComments('p1');
      expect(comments.isEmpty, true);
    });
  });
}
