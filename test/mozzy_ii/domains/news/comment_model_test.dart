import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mozzy/mozzy_ii/domains/news/models/comment_model.dart';

void main() {
  group('CommentModel', () {
    test('toJson and fromJson work correctly with DateTime', () {
      final now = DateTime.now().toUtc();
      final comment = CommentModel(
        id: 'c1',
        postId: 'p1',
        userId: 'u1',
        content: 'test content',
        createdAt: now,
      );

      final json = comment.toJson();
      expect(json['id'], 'c1');
      expect(json['createdAt'], now.toIso8601String());

      final parsed = CommentModel.fromJson(json);
      expect(parsed.id, 'c1');
      expect(parsed.createdAt, now);
      expect(parsed.isDeleted, false);
      expect(parsed.reportCount, 0);
    });

    test('fromJson handles Firestore Timestamp', () {
      final now = DateTime.now();
      final timestamp = Timestamp.fromDate(now);

      final json = {
        'id': 'c2',
        'postId': 'p1',
        'userId': 'u1',
        'content': 'test',
        'createdAt': timestamp,
      };

      final parsed = CommentModel.fromJson(json);
      expect(parsed.createdAt, now);
    });

    test('parentCommentId nullable for top-level, isReply is false', () {
      final comment = CommentModel(
        id: 'c1',
        postId: 'p1',
        userId: 'u1',
        content: 'hello',
        createdAt: DateTime.now(),
      );
      expect(comment.parentCommentId, isNull);
      expect(comment.isReply, false);
    });

    test('parentCommentId populated for reply, isReply is true', () {
      final comment = CommentModel(
        id: 'c1',
        postId: 'p1',
        userId: 'u1',
        content: 'hello',
        createdAt: DateTime.now(),
        parentCommentId: 'parent1',
      );
      expect(comment.parentCommentId, 'parent1');
      expect(comment.isReply, true);
    });
  });
}
