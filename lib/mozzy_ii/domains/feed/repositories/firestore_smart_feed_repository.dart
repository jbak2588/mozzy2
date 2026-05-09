import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:rxdart/rxdart.dart';
import '../models/feed_item_model.dart';
import '../mappers/job_feed_mapper.dart';
import '../mappers/product_feed_mapper.dart';
import '../../jobs/models/job_post_model.dart';
import '../../marketplace/models/product_model.dart';
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
        .limit(limit ~/ 2);

    // 2. Products Stream
    Query productsQuery = _firestore.collectionGroup('products')
        .where('isDeleted', isEqualTo: false)
        .where('status', isEqualTo: 'available')
        .orderBy('createdAt', descending: true)
        .limit(limit ~/ 2);

    // Combine using RxDart
    return Rx.combineLatest2(
      jobsQuery.snapshots(),
      productsQuery.snapshots(),
      (QuerySnapshot jobsSnap, QuerySnapshot productsSnap) {
        final jobs = jobsSnap.docs.map((doc) {
          final data = doc.data() as Map<String, dynamic>;
          return JobFeedMapper.map(JobPostModel.fromJson({...data, 'id': doc.id}));
        }).toList();

        final products = productsSnap.docs.map((doc) {
          final data = doc.data() as Map<String, dynamic>;
          // products are in a subcollection, so we need to handle geoPath correctly if not present
          return ProductFeedMapper.map(ProductModel.fromJson({...data, 'id': doc.id}));
        }).toList();

        return [...jobs, ...products];
      },
    );
  }
}
