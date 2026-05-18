import 'package:flutter_test/flutter_test.dart';
import 'package:mozzy/mozzy_ii/domains/feed/models/feed_item_model.dart';
import 'package:mozzy/mozzy_ii/domains/feed/models/feed_item_type.dart';
import 'package:mozzy/mozzy_ii/domains/feed/models/user_feed_context.dart';
import 'package:mozzy/mozzy_ii/domains/feed/services/feed_ranking_service.dart';
import 'package:mozzy/mozzy_ii/geo/models/location_parts.dart';

class MockFeedRankingService extends FeedRankingService {
  MockFeedRankingService() : super();
}

void main() {
  late FeedRankingService service;
  final now = DateTime(2026, 5, 9, 16, 0);

  setUp(() {
    service = MockFeedRankingService();
  });

  group('FeedRankingService Official Formula', () {
    test('calculateRecencyScore returns 1.0 for fresh items (<1h)', () {
      final fresh = now.subtract(const Duration(minutes: 30));
      expect(service.calculateRecencyScore(fresh, now), 1.0);
    });

    test('calculateRecencyScore returns 0.15 for old items (>7d)', () {
      final old = now.subtract(const Duration(days: 10));
      expect(service.calculateRecencyScore(old, now), 0.15);
    });

    test('calculateRelevanceScore returns 1.0 for same Kelurahan', () {
      const location = LocationParts(
        countryCode: 'ID',
        latitude: 0,
        longitude: 0,
        geoHash: 'abc',
        idAddress: IndonesiaGeoAddress(
          provinsi: 'DKI Jakarta',
          kabupaten: 'Jakarta Selatan',
          kecamatan: 'Kebayoran Baru',
          kelurahan: 'Senayan',
        ),
      );
      final context = UserFeedContext(locationParts: location);
      final item = FeedItemModel(
        id: '1',
        sourceId: '1',
        type: FeedItemType.job,
        title: 'Title',
        createdAt: now,
        locationParts: location,
        route: '/',
      );

      expect(service.calculateRelevanceScore(item: item, context: context), 1.0);
    });

    test('calculateEngagementScore reflects likes and comments', () {
      final item = FeedItemModel(
        id: '1',
        sourceId: '1',
        type: FeedItemType.job,
        title: 'Title',
        createdAt: now,
        likesCount: 10, // 10*3 = 30
        commentsCount: 5, // 5*5 = 25
        // total = 55 -> >50 should be 1.0
        route: '/',
      );
      expect(service.calculateEngagementScore(item), 1.0);
    });

    test('calculateDiversityScore penalizes repeated types', () {
      expect(service.calculateDiversityScore(
        sourceType: 'job',
        recentlyShownTypes: ['job', 'job', 'job'],
      ), 0.4);
    });

    test('calculateSignalScore produces value between 0.0 and 1.0', () {
      final item = FeedItemModel(
        id: '1',
        sourceId: '1',
        type: FeedItemType.job,
        title: 'Title',
        createdAt: now,
        trustScore: 0.8,
        route: '/',
      );
      final score = service.calculateSignalScore(item: item, now: now);
      expect(score, greaterThanOrEqualTo(0.0));
      expect(score, lessThanOrEqualTo(1.0));
    });

    test('rankItems sorts by signalScore then createdAt', () {
      final itemLow = FeedItemModel(
        id: 'low',
        sourceId: '1',
        type: FeedItemType.job,
        title: 'Low',
        createdAt: now.subtract(const Duration(days: 10)),
        route: '/',
      );
      final itemHigh = FeedItemModel(
        id: 'high',
        sourceId: '2',
        type: FeedItemType.job,
        title: 'High',
        createdAt: now.subtract(const Duration(hours: 1)),
        trustScore: 1.0,
        route: '/',
      );

      final ranked = service.rankItems([itemLow, itemHigh], now: now);
      expect(ranked.first.id, 'high');
      expect(ranked.last.id, 'low');
    });
  });
}
