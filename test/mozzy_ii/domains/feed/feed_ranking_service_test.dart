import 'package:flutter_test/flutter_test.dart';
import 'package:mozzy/mozzy_ii/domains/feed/models/feed_item_model.dart';
import 'package:mozzy/mozzy_ii/domains/feed/models/feed_item_type.dart';
import 'package:mozzy/mozzy_ii/domains/feed/models/user_location_context.dart';
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

  group('FeedRankingService', () {
    test('calculateBoostScore returns 100 for promoted items', () {
      final item = FeedItemModel(
        id: '1',
        sourceId: '1',
        type: FeedItemType.job,
        title: 'Title',
        createdAt: now,
        isPromoted: true,
        route: '/',
      );
      expect(service.calculateBoostScore(item), 100.0);
    });

    test('calculateFreshnessScore returns correct scores', () {
      final item2h = now.subtract(const Duration(hours: 2));
      final item2d = now.subtract(const Duration(days: 2));
      final item5d = now.subtract(const Duration(days: 5));
      final item10d = now.subtract(const Duration(days: 10));

      expect(service.calculateFreshnessScore(item2h, now), 30.0);
      expect(service.calculateFreshnessScore(item2d, now), 20.0);
      expect(service.calculateFreshnessScore(item5d, now), 10.0);
      expect(service.calculateFreshnessScore(item10d, now), 0.0);
    });

    test('calculateDistanceScore returns correct scores for same location', () {
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
      final context = UserLocationContext(locationParts: location);
      
      final itemSameDistrict = FeedItemModel(
        id: '1',
        sourceId: '1',
        type: FeedItemType.job,
        title: 'Title',
        createdAt: now,
        locationParts: location,
        route: '/',
      );

      final itemSameCity = FeedItemModel(
        id: '2',
        sourceId: '2',
        type: FeedItemType.job,
        title: 'Title',
        createdAt: now,
        locationParts: const LocationParts(
          countryCode: 'ID',
          latitude: 0,
          longitude: 0,
          geoHash: 'abc',
          idAddress: IndonesiaGeoAddress(
            provinsi: 'DKI Jakarta',
            kabupaten: 'Jakarta Selatan',
            kecamatan: 'Tebet',
            kelurahan: 'Tebet Barat',
          ),
        ),
        route: '/',
      );

      expect(service.calculateDistanceScore(itemSameDistrict, context), 20.0);
      expect(service.calculateDistanceScore(itemSameCity, context), 10.0);
    });

    test('rankItems sorts items by finalScore', () {
      final itemLow = FeedItemModel(
        id: 'low',
        sourceId: '1',
        type: FeedItemType.job,
        title: 'Low Score',
        createdAt: now.subtract(const Duration(days: 10)),
        route: '/',
      );
      final itemHigh = FeedItemModel(
        id: 'high',
        sourceId: '2',
        type: FeedItemType.job,
        title: 'High Score',
        createdAt: now,
        isPromoted: true,
        route: '/',
      );

      final ranked = service.rankItems([itemLow, itemHigh], now: now);
      
      expect(ranked.first.id, 'high');
      expect(ranked.last.id, 'low');
      expect(ranked.first.finalScore, greaterThan(ranked.last.finalScore));
    });
  });
}
