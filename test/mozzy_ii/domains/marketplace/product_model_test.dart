import 'package:flutter_test/flutter_test.dart';
import 'package:mozzy/mozzy_ii/domains/marketplace/models/product_model.dart';
import 'package:mozzy/mozzy_ii/geo/models/location_parts.dart';
import 'package:mozzy/mozzy_ii/shared/contracts/mozzy_post_contract.dart';

void main() {
  group('ProductModel', () {
    test('toJson/fromJson and contract implementation', () {
      final location = LocationParts(
        countryCode: 'ID',
        idAddress: null,
        globalAddress: null,
        latitude: -6.9,
        longitude: 107.6,
        geoHash: 'w23e',
      );

      final product = ProductModel(
        id: 'pr1',
        userId: 'u1',
        title: 'MacBook Pro',
        description: 'Bekas mulus',
        category: 'electronics',
        price: 15000000,
        currencyCode: 'IDR',
        imageUrls: ['https://example.com/mac.jpg'],
        geoScope: GeoScope.neighborhood,
        reachMode: ReachMode.localOnly,
        translationState: {},
        trustScore: 0.5,
        signalScore: 0.2,
        geoPath: 'ID#JB#BANDUNG#COBLONG#DAGO',
        locationParts: location,
        countryCode: 'ID',
        isAiVerified: true,
        aiVerificationStatus: 'passed',
        aiVerificationScore: 0.95,
        aiVerificationSummary: 'AI matched images and description',
        aiDetectedIssues: [],
        aiSuggestedCategory: 'electronics',
        aiConditionLabel: 'good',
        aiVerifiedAt: DateTime.utc(2026, 4, 29),
        createdAt: DateTime.utc(2026, 4, 29),
        isDeleted: false,
        viewsCount: 10,
        likesCount: 2,
        chatsCount: 1,
      );

      final json = product.toJson();
      final restored = ProductModel.fromJson(json);

      expect(restored.id, equals(product.id));
      expect(restored.userId, equals(product.userId));
      expect(restored.sellerId, equals(product.userId));
      expect(restored.price, equals(15000000));
      // ignore: unnecessary_type_check
      expect(restored is MozzyPostContract, isTrue);
      expect(restored.trustScore, equals(0.5));
    });

    test('default values', () {
      final product = ProductModel(
        id: 'pr1',
        userId: 'u1',
        title: 'Title',
        description: 'Desc',
        category: 'cat',
        price: 1000,
        geoPath: 'path',
        createdAt: DateTime.now(),
      );

      expect(product.currencyCode, equals('IDR'));
      expect(product.isAiVerified, isFalse);
      expect(product.aiVerificationStatus, equals('not_requested'));
      expect(product.trustScore, equals(0.3));
      expect(product.imageUrls, isEmpty);
      expect(product.viewsCount, 0);
      expect(product.likesCount, 0);
      expect(product.chatsCount, 0);
      expect(product.isDeleted, isFalse);
    });
  });
}
