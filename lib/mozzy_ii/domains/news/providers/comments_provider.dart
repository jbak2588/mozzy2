import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/config/integration_test_config.dart';
import '../models/comment_model.dart';
import '../repositories/comment_repository.dart';
import '../repositories/in_memory_comment_repository.dart';

// Use a singleton instance for in-memory repo so state is retained across reads
final _inMemoryCommentRepo = InMemoryCommentRepository();

final commentRepositoryProvider = Provider<CommentRepository>((ref) {
  if (IntegrationTestConfig.enabled) {
    return _inMemoryCommentRepo;
  }
  return CommentRepository();
});

final commentsByPostProvider =
    FutureProvider.family.autoDispose<List<CommentModel>, String>((ref, postId) {
  final repo = ref.read(commentRepositoryProvider);
  return repo.fetchComments(postId);
});

class CreateCommentAction {
  final CommentRepository _repo;
  CreateCommentAction(this._repo);

  Future<void> call(CommentModel comment) => _repo.createComment(comment);
}

final createCommentProvider = Provider<CreateCommentAction>((ref) {
  return CreateCommentAction(ref.read(commentRepositoryProvider));
});
