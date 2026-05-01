import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/comment_model.dart';

class CommentRepository {
  final FirebaseFirestore _fs;
  static const String countryId = 'ID';
  static const String domainId = 'local_news';

  CommentRepository([FirebaseFirestore? fs])
    : _fs = fs ?? FirebaseFirestore.instance;

  String commentsCollectionPath(String postId, [String? country]) {
    final c = country ?? countryId;
    return 'countries/$c/domains/$domainId/posts/$postId/comments';
  }

  CollectionReference getCommentsCollection(String postId) =>
      _fs.collection(commentsCollectionPath(postId));

  Future<void> createComment(CommentModel comment) async {
    final docRef = getCommentsCollection(comment.postId).doc(comment.id);
    await docRef.set(comment.toJson());
  }

  Future<List<CommentModel>> fetchVisibleTopLevelComments({
    required String postId,
    required String currentUserId,
    int limit = 50,
  }) async {
    return _fetchVisible(
      postId: postId,
      currentUserId: currentUserId,
      parentCommentId: null,
      limit: limit,
    );
  }

  Future<List<CommentModel>> fetchVisibleReplies({
    required String postId,
    required String parentCommentId,
    required String currentUserId,
    int limit = 50,
  }) async {
    return _fetchVisible(
      postId: postId,
      currentUserId: currentUserId,
      parentCommentId: parentCommentId,
      limit: limit,
    );
  }

  Future<List<CommentModel>> _fetchVisible({
    required String postId,
    required String currentUserId,
    String? parentCommentId,
    required int limit,
  }) async {
    Query baseQuery = getCommentsCollection(
      postId,
    ).where('isDeleted', isEqualTo: false);

    if (parentCommentId == null) {
      baseQuery = baseQuery.where('parentCommentId', isNull: true);
    } else {
      baseQuery = baseQuery.where(
        'parentCommentId',
        isEqualTo: parentCommentId,
      );
    }

    final publicQuery = baseQuery
        .where('isSecret', isEqualTo: false)
        .orderBy('createdAt', descending: false);
    final secretQuery = baseQuery
        .where('isSecret', isEqualTo: true)
        .where('visibleToUserIds', arrayContains: currentUserId)
        .orderBy('createdAt', descending: false);

    final publicDocs = await publicQuery.get();
    final secretDocs = await secretQuery.get();

    final allDocs = [...publicDocs.docs, ...secretDocs.docs];

    final uniqueDocs = <String, QueryDocumentSnapshot>{};
    for (var doc in allDocs) {
      uniqueDocs[doc.id] = doc;
    }

    final results =
        uniqueDocs.values
            .map(
              (d) => CommentModel.fromJson({
                ...d.data() as Map<String, dynamic>,
                'id': d.id,
              }),
            )
            .toList()
          ..sort((a, b) => a.createdAt.compareTo(b.createdAt));

    return results.take(limit).toList();
  }

  Future<List<CommentModel>> fetchTopLevelComments(
    String postId, {
    int limit = 50,
  }) async {
    final query = getCommentsCollection(postId)
        .where('isDeleted', isEqualTo: false)
        .where('parentCommentId', isNull: true)
        .orderBy('createdAt', descending: false)
        .limit(limit);

    final snap = await query.get();
    return snap.docs
        .map(
          (d) => CommentModel.fromJson({
            ...d.data() as Map<String, dynamic>,
            'id': d.id,
          }),
        )
        .toList();
  }

  Future<List<CommentModel>> fetchReplies({
    required String postId,
    required String parentCommentId,
    int limit = 50,
  }) async {
    final query = getCommentsCollection(postId)
        .where('isDeleted', isEqualTo: false)
        .where('parentCommentId', isEqualTo: parentCommentId)
        .orderBy('createdAt', descending: false)
        .limit(limit);

    final snap = await query.get();
    return snap.docs
        .map(
          (d) => CommentModel.fromJson({
            ...d.data() as Map<String, dynamic>,
            'id': d.id,
          }),
        )
        .toList();
  }

  Future<void> softDeleteComment({
    required String postId,
    required String commentId,
  }) async {
    final now = DateTime.now().toUtc();
    await getCommentsCollection(postId).doc(commentId).set({
      'isDeleted': true,
      'updatedAt': now.toIso8601String(),
    }, SetOptions(merge: true));
  }
}
