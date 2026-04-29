import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/post_model.dart';
import 'post_repository.dart';

class InMemoryPostRepository implements PostRepository {
  final Map<String, PostModel> _posts = {};

  @override
  String postsCollectionPath([String? country]) {
    return 'countries/ID/domains/local_news/posts';
  }

  @override
  CollectionReference get postsCollection => throw UnimplementedError('InMemory: no collection ref');

  @override
  Future<void> createPost(PostModel post) async {
    _posts[post.id] = post;
  }

  @override
  Future<PostModel?> getPostById(String postId) async {
    return _posts[postId];
  }

  @override
  Future<List<PostModel>> fetchByKecamatan({
    required String kecamatan,
    int limit = 20,
    DocumentSnapshot? startAfter,
  }) async {
    final list = _posts.values
        .where((p) => !p.isDeleted && p.location.idAddress?.kecamatan == kecamatan)
        .toList();
    list.sort((a, b) => b.createdAt.compareTo(a.createdAt));
    return list.take(limit).toList();
  }

  @override
  Future<List<PostModel>> fetchByCategory({
    required String category,
    int limit = 20,
    DocumentSnapshot? startAfter,
  }) async {
    final list = _posts.values
        .where((p) => !p.isDeleted && p.category == category)
        .toList();
    list.sort((a, b) => b.createdAt.compareTo(a.createdAt));
    return list.take(limit).toList();
  }

  @override
  Future<List<PostModel>> fetchByKecamatanAndCategory({
    required String kecamatan,
    required String category,
    int limit = 20,
    DocumentSnapshot? startAfter,
  }) async {
    final list = _posts.values
        .where((p) => !p.isDeleted && p.location.idAddress?.kecamatan == kecamatan)
        .where((p) => category == 'all' || p.category == category)
        .toList();
    list.sort((a, b) => b.createdAt.compareTo(a.createdAt));
    return list.take(limit).toList();
  }

  @override
  Future<void> updatePost(PostModel post) async {
    _posts[post.id] = post;
  }

  @override
  Future<void> softDeletePost(String postId) async {
    final p = _posts[postId];
    if (p != null) {
      _posts[postId] = p.copyWith(isDeleted: true);
    }
  }
}
