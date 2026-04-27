// ============================================================================
// Mozzy DocHeader
// Module        : Local News Domain
// File          : lib/mozzy_ii/domains/news/repositories/post_repository.dart
// Purpose       : Firestore 기반의 뉴스 게시글 CRUD 및 쿼리를 담당합니다.
//                 Path-sharding 아키텍처를 준수합니다.
// ============================================================================

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mozzy/mozzy_ii/core/config/firebase_constants.dart';
import 'package:mozzy/mozzy_ii/domains/news/models/post_model.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'post_repository.g.dart';

class PostRepository {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  /// 뉴스 게시글 컬렉션 참조 획득 (Sharded Path)
  CollectionReference<Map<String, dynamic>> _newsCollection(String countryId) {
    return _firestore
        .collection(FirebaseConstants.countries)
        .doc(countryId)
        .collection(FirebaseConstants.domains)
        .doc('news')
        .collection(FirebaseConstants.posts);
  }

  /// 게시글 작성
  Future<void> createPost(String countryId, PostModel post) async {
    await _newsCollection(countryId).doc(post.id).set(post.toJson());
  }

  /// 게시글 단건 조회
  Future<PostModel?> getPost(String countryId, String postId) async {
    final doc = await _newsCollection(countryId).doc(postId).get();
    if (doc.exists) {
      return PostModel.fromJson(doc.data()!);
    }
    return null;
  }

  /// 동네 뉴스 피드 조회 (GeoPath 기반 Prefix Match)
  /// [geoPath] 예: "ID#JB#Bandung#Coblong"
  Future<List<PostModel>> getPostsByGeoPath({
    required String countryId,
    required String geoPath,
    int limit = 20,
    DocumentSnapshot? startAfter,
  }) async {
    var query = _newsCollection(countryId)
        .where(FirebaseConstants.fieldGeoPath, isGreaterThanOrEqualTo: geoPath)
        .where(FirebaseConstants.fieldGeoPath, isLessThan: '$geoPath\uf8ff')
        .orderBy(FirebaseConstants.fieldGeoPath)
        .orderBy(FirebaseConstants.fieldCreatedAt, descending: true)
        .limit(limit);

    if (startAfter != null) {
      query = query.startAfterDocument(startAfter);
    }

    final snapshot = await query.get();
    return snapshot.docs.map((doc) => PostModel.fromJson(doc.data())).toList();
  }
}

@riverpod
PostRepository postRepository(Ref ref) {
  return PostRepository();
}
