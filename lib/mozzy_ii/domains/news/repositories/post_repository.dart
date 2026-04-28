import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import '../models/post_model.dart';

class PostRepository {
  final FirebaseFirestore _fs;
  static const String countryId = 'ID';
  static const String domainId = 'local_news';

  PostRepository([FirebaseFirestore? fs])
    : _fs = fs ?? FirebaseFirestore.instance;

  String postsCollectionPath([String? country]) {
    final c = country ?? countryId;
    return 'countries/$c/domains/$domainId/posts';
  }

  CollectionReference get postsCollection =>
      _fs.collection(postsCollectionPath());

  Future<void> createPost(PostModel post) async {
    final docRef = postsCollection.doc(post.id);
    await docRef.set(post.toJson());
  }

  Future<PostModel?> getPostById(String postId) async {
    final doc = await postsCollection.doc(postId).get();
    if (!doc.exists) return null;
    final data = doc.data() as Map<String, dynamic>;
    return PostModel.fromJson({...data, 'id': doc.id});
  }

  Future<List<PostModel>> fetchByKecamatan({
    required String kecamatan,
    int limit = 20,
    DocumentSnapshot? startAfter,
  }) async {
    Query query = postsCollection
        .where('isDeleted', isEqualTo: false)
        .where('location.idAddress.kecamatan', isEqualTo: kecamatan)
        .orderBy('createdAt', descending: true)
        .limit(limit);

    if (startAfter != null) query = query.startAfterDocument(startAfter);

    final snap = await query.get();
    return snap.docs
        .map(
          (d) => PostModel.fromJson({
            ...d.data() as Map<String, dynamic>,
            'id': d.id,
          }),
        )
        .toList();
  }

  Future<List<PostModel>> fetchByCategory({
    required String category,
    int limit = 20,
    DocumentSnapshot? startAfter,
  }) async {
    Query query = postsCollection
        .where('isDeleted', isEqualTo: false)
        .where('category', isEqualTo: category)
        .orderBy('createdAt', descending: true)
        .limit(limit);

    if (startAfter != null) query = query.startAfterDocument(startAfter);

    final snap = await query.get();
    return snap.docs
        .map(
          (d) => PostModel.fromJson({
            ...d.data() as Map<String, dynamic>,
            'id': d.id,
          }),
        )
        .toList();
  }

  Future<void> updatePost(PostModel post) async {
    final docRef = postsCollection.doc(post.id);
    await docRef.set(post.toJson(), SetOptions(merge: true));
  }

  Future<void> softDeletePost(String postId) async {
    final now = DateTime.now().toUtc();
    await postsCollection.doc(postId).set({
      'isDeleted': true,
      'updatedAt': now,
    }, SetOptions(merge: true));
  }
}
