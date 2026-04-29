import 'package:firebase_auth/firebase_auth.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../../core/config/integration_test_config.dart';
import '../models/comment_model.dart';
import '../repositories/comment_repository.dart';
import '../repositories/in_memory_comment_repository.dart';

part 'comments_provider.g.dart';

// Use a singleton instance for in-memory repo so state is retained across reads
final _inMemoryCommentRepo = InMemoryCommentRepository();

@Riverpod(keepAlive: true)
CommentRepository commentRepository(Ref ref) {
  if (IntegrationTestConfig.enabled) {
    return _inMemoryCommentRepo;
  }
  return CommentRepository();
}

@riverpod
String currentCommentUserId(Ref ref) {
  if (IntegrationTestConfig.enabled) {
    return IntegrationTestConfig.testUserId;
  }
  return FirebaseAuth.instance.currentUser?.uid ?? '';
}

class VisibleCommentsQuery {
  final String postId;
  final String currentUserId;

  const VisibleCommentsQuery({required this.postId, required this.currentUserId});

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is VisibleCommentsQuery &&
          runtimeType == other.runtimeType &&
          postId == other.postId &&
          currentUserId == other.currentUserId;

  @override
  int get hashCode => postId.hashCode ^ currentUserId.hashCode;
}

@riverpod
Future<List<CommentModel>> visibleTopLevelComments(Ref ref, VisibleCommentsQuery query) async {
  final repo = ref.read(commentRepositoryProvider);
  return repo.fetchVisibleTopLevelComments(
    postId: query.postId,
    currentUserId: query.currentUserId,
  );
}

class VisibleRepliesQuery {
  final String postId;
  final String parentCommentId;
  final String currentUserId;

  const VisibleRepliesQuery({required this.postId, required this.parentCommentId, required this.currentUserId});

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is VisibleRepliesQuery &&
          runtimeType == other.runtimeType &&
          postId == other.postId &&
          parentCommentId == other.parentCommentId &&
          currentUserId == other.currentUserId;

  @override
  int get hashCode => postId.hashCode ^ parentCommentId.hashCode ^ currentUserId.hashCode;
}

@riverpod
Future<List<CommentModel>> visibleRepliesByComment(Ref ref, VisibleRepliesQuery query) async {
  final repo = ref.read(commentRepositoryProvider);
  return repo.fetchVisibleReplies(
    postId: query.postId,
    parentCommentId: query.parentCommentId,
    currentUserId: query.currentUserId,
  );
}

@riverpod
CreateCommentAction createComment(Ref ref) {
  return CreateCommentAction(ref.read(commentRepositoryProvider));
}

class CreateCommentAction {
  final CommentRepository _repo;
  CreateCommentAction(this._repo);

  Future<void> call(CommentModel comment) => _repo.createComment(comment);
}
