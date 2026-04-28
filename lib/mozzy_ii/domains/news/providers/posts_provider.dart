import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../repositories/post_repository.dart';
import '../models/post_model.dart';

final postRepositoryProvider = Provider<PostRepository>(
  (ref) => PostRepository(),
);

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
