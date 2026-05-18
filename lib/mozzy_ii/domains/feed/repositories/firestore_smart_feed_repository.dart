import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:rxdart/rxdart.dart';
import '../models/feed_item_model.dart';
import '../mappers/job_feed_mapper.dart';
import '../mappers/product_feed_mapper.dart';
import '../mappers/news_feed_mapper.dart';
import '../../jobs/models/job_post_model.dart';
import '../../marketplace/models/product_model.dart';
import '../../news/models/post_model.dart';
import '../../../geo/models/location_parts.dart';
import 'smart_feed_repository.dart';

class FirestoreSmartFeedRepository implements SmartFeedRepository {
  final FirebaseFirestore _firestore;

  FirestoreSmartFeedRepository({FirebaseFirestore? firestore})
      : _firestore = firestore ?? FirebaseFirestore.instance;

  @override
  Stream<List<FeedItemModel>> getSmartFeed({LocationParts? locationFilter, int limit = 60}) {
    // 1. Jobs Stream
    Query jobsQuery = _firestore.collection('job_posts')
        .where('isDeleted', isEqualTo: false)
        .where('status', isEqualTo: 'open')
        .orderBy('createdAt', descending: true)
        .limit(limit ~/ 3);

    // 2. Products Stream
    Query productsQuery = _firestore.collectionGroup('products')
        .where('isDeleted', isEqualTo: false)
        .where('status', isEqualTo: 'available')
        .orderBy('createdAt', descending: true)
        .limit(limit ~/ 3);

    // 3. News Stream
    Query newsQuery = _firestore.collection('posts')
        .where('isDeleted', isEqualTo: false)
        .orderBy('createdAt', descending: true)
        .limit(limit ~/ 3);

    // Combine using RxDart with error handling for individual streams
    return Rx.combineLatest3(
      jobsQuery.snapshots().map<QuerySnapshot?>((s) => s).onErrorReturn(null),
      productsQuery.snapshots().map<QuerySnapshot?>((s) => s).onErrorReturn(null),
      newsQuery.snapshots().map<QuerySnapshot?>((s) => s).onErrorReturn(null),
      (QuerySnapshot? jobsSnap, QuerySnapshot? productsSnap, QuerySnapshot? newsSnap) {
        final jobs = jobsSnap?.docs.where((doc) {
          final data = doc.data() as Map<String, dynamic>;
          final mStatus = data['moderationStatus'] as String?;
          return mStatus != 'hidden' && mStatus != 'removed';
        }).map((doc) {
          final data = doc.data() as Map<String, dynamic>;
          return JobFeedMapper.map(JobPostModel.fromJson({...data, 'id': doc.id}));
        }).toList() ?? [];

        final products = productsSnap?.docs.where((doc) {
          final data = doc.data() as Map<String, dynamic>;
          final mStatus = data['moderationStatus'] as String?;
          return mStatus != 'hidden' && mStatus != 'removed';
        }).map((doc) {
          final data = doc.data() as Map<String, dynamic>;
          return ProductFeedMapper.map(ProductModel.fromJson({...data, 'id': doc.id}));
        }).toList() ?? [];

        final news = newsSnap?.docs.where((doc) {
          final data = doc.data() as Map<String, dynamic>;
          final mStatus = data['moderationStatus'] as String?;
          return mStatus != 'hidden' && mStatus != 'removed';
        }).map((doc) {
          final data = doc.data() as Map<String, dynamic>;
          return NewsFeedMapper.map(PostModel.fromJson({...data, 'id': doc.id}));
        }).toList() ?? [];

        return [...jobs, ...products, ...news];
      },
    );
  }
}
