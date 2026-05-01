import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/config/integration_test_config.dart';
import '../repositories/post_repository.dart';
import '../repositories/in_memory_post_repository.dart';
import '../models/post_model.dart';

final postRepositoryProvider = Provider<PostRepository>((ref) {
  if (IntegrationTestConfig.enabled) {
    return InMemoryPostRepository();
  }
  return PostRepository();
});

final postsByKecamatanProvider = FutureProvider.family
    .autoDispose<List<PostModel>, String>((ref, kecamatan) async {
      final repo = ref.read(postRepositoryProvider);
      return repo.fetchByKecamatan(kecamatan: kecamatan);
    });

final postsByCategoryProvider = FutureProvider.family
    .autoDispose<List<PostModel>, String>((ref, category) async {
      final repo = ref.read(postRepositoryProvider);
      return repo.fetchByCategory(category: category);
    });

/// Query object for list screen provider
class PostsQuery {
  final String category;
  final String? kecamatan;
  const PostsQuery({required this.category, this.kecamatan});

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PostsQuery &&
          runtimeType == other.runtimeType &&
          category == other.category &&
          kecamatan == other.kecamatan;

  @override
  int get hashCode => category.hashCode ^ kecamatan.hashCode;
}

final postsByCategoryAndKecamatanProvider = FutureProvider.family
    .autoDispose<List<PostModel>, PostsQuery>((ref, q) async {
      final repo = ref.read(postRepositoryProvider);
      final kec = q.kecamatan;
      if (kec == null) {
        // if no kecamatan known, fallback to category-only
        if (q.category == 'all') return [];
        return repo.fetchByCategory(category: q.category);
      }

      return repo.fetchByKecamatanAndCategory(
        kecamatan: kec,
        category: q.category,
      );
    });

class CreateLocalNewsPostAction {
  final PostRepository _repo;
  CreateLocalNewsPostAction(this._repo);

  Future<void> call(PostModel post) => _repo.createPost(post);
}

final createLocalNewsPostProvider = Provider<CreateLocalNewsPostAction>((ref) {
  return CreateLocalNewsPostAction(ref.read(postRepositoryProvider));
});

final postByIdProvider = FutureProvider.family.autoDispose<PostModel?, String>((
  ref,
  postId,
) {
  final repo = ref.read(postRepositoryProvider);
  return repo.getPostById(postId);
});
