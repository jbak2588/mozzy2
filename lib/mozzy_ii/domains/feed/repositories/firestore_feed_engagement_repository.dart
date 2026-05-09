import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/feed_engagement_summary.dart';
import '../models/feed_item_model.dart';
import 'feed_engagement_repository.dart';
import 'package:rxdart/rxdart.dart';

class FirestoreFeedEngagementRepository implements FeedEngagementRepository {
  final FirebaseFirestore _firestore;

  FirestoreFeedEngagementRepository({FirebaseFirestore? firestore})
      : _firestore = firestore ?? FirebaseFirestore.instance;

  @override
  Stream<Map<String, FeedEngagementSummary>> watchEngagementSummaries({
    required List<FeedItemModel> items,
  }) {
    if (items.isEmpty) return Stream.value({});

    // Build unique summary IDs: {sourceType}_{sourceId}
    final summaryIds = items.map((item) => '${item.type.name}_${item.sourceId}').toSet().toList();

    // Firestore whereIn supports up to 30 elements (v2) but common safe limit is 10-30.
    // User requested 10 unit chunking.
    final chunks = <List<String>>[];
    for (var i = 0; i < summaryIds.length; i += 10) {
      chunks.add(summaryIds.sublist(i, i + 10 > summaryIds.length ? summaryIds.length : i + 10));
    }

    final streams = chunks.map((chunk) {
      return _firestore
          .collection('feed_engagement_summaries')
          .where(FieldPath.documentId, whereIn: chunk)
          .snapshots()
          .map((snapshot) {
        return {
          for (var doc in snapshot.docs)
            doc.id: FeedEngagementSummary.fromJson(doc.data())
        };
      });
    });

    return CombineLatestStream.list(streams).map((list) {
      final merged = <String, FeedEngagementSummary>{};
      for (var map in list) {
        merged.addAll(map);
      }
      return merged;
    });
  }
}
