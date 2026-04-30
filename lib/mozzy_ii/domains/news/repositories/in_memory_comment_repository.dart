import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/comment_model.dart';
import 'comment_repository.dart';

class InMemoryCommentRepository implements CommentRepository {
  final Map<String, List<CommentModel>> _commentsByPost = {};

  @override
  String commentsCollectionPath(String postId, [String? country]) => '';

  @override
  CollectionReference<Object?> getCommentsCollection(String postId) => throw UnimplementedError('Not used in memory');

  @override
  Future<void> createComment(CommentModel comment) async {
    _commentsByPost.putIfAbsent(comment.postId, () => []);
    
    // Check if exists to mimic merge
    final index = _commentsByPost[comment.postId]!.indexWhere((c) => c.id == comment.id);
    if (index >= 0) {
      _commentsByPost[comment.postId]![index] = comment;
    } else {
      _commentsByPost[comment.postId]!.add(comment);
    }
  }

  @override
  Future<List<CommentModel>> fetchVisibleTopLevelComments({
    required String postId,
    required String currentUserId,
    int limit = 50,
  }) async {
    return _fetchVisible(postId, currentUserId, null, limit);
  }

  @override
  Future<List<CommentModel>> fetchVisibleReplies({
    required String postId,
    required String parentCommentId,
    required String currentUserId,
    int limit = 50,
  }) async {
    return _fetchVisible(postId, currentUserId, parentCommentId, limit);
  }

  List<CommentModel> _fetchVisible(String postId, String currentUserId, String? parentCommentId, int limit) {
    final comments = _commentsByPost[postId] ?? [];
    
    final filtered = comments.where((c) {
      if (c.isDeleted) return false;
      if (parentCommentId == null) {
        if (c.parentCommentId != null && c.parentCommentId!.isNotEmpty) return false;
      } else {
        if (c.parentCommentId != parentCommentId) return false;
      }
      
      if (c.isSecret) {
        return c.visibleToUserIds.contains(currentUserId);
      }
      return true;
    }).toList();
    
    filtered.sort((a, b) => a.createdAt.compareTo(b.createdAt));
    
    return filtered.take(limit).toList();
  }

  @override
  Future<List<CommentModel>> fetchTopLevelComments(String postId, {int limit = 50}) async {
    final comments = _commentsByPost[postId] ?? [];  
    final filtered = comments.where((c) => !c.isDeleted && (c.parentCommentId == null || c.parentCommentId!.isEmpty)).toList();
    filtered.sort((a, b) => a.createdAt.compareTo(b.createdAt));
    
    if (filtered.length > limit) {
      return filtered.sublist(0, limit);
    }
    return filtered;
  }

  @override
  Future<List<CommentModel>> fetchReplies({
    required String postId,
    required String parentCommentId,
    int limit = 50,
  }) async {
    final comments = _commentsByPost[postId] ?? [];
    
    final filtered = comments.where((c) => !c.isDeleted && c.parentCommentId == parentCommentId).toList();
    filtered.sort((a, b) => a.createdAt.compareTo(b.createdAt));
    
    if (filtered.length > limit) {
      return filtered.sublist(0, limit);
    }
    return filtered;
  }

  @override
  Future<void> softDeleteComment({
    required String postId,
    required String commentId,
  }) async {
    final comments = _commentsByPost[postId] ?? [];
    final index = comments.indexWhere((c) => c.id == commentId);
    
    if (index >= 0) {
      final old = comments[index];
      comments[index] = old.copyWith(
        isDeleted: true,
        updatedAt: DateTime.now().toUtc(),
      );
    }
  }
}
