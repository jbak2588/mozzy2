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
