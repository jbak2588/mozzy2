import 'package:flutter_test/flutter_test.dart';
import 'package:mozzy/mozzy_ii/domains/marketplace/models/product_model.dart';
import 'package:mozzy/mozzy_ii/shared/contracts/mozzy_post_contract.dart';

void main() {
  group('ProductModel Contract Integration', () {
    test('missing fields use fallback defaults', () {
      final json = {
        'id': 'p1',
        'sellerId': 'u1',
        'title': 'Test',
        'description': 'Test',
        'category': 'Test',
        'price': 100,
        'geoPath': 'ID',
        'createdAt': DateTime.now().toIso8601String(),
      };

      final product = ProductModel.fromJson(json);

      expect(product.geoScope, GeoScope.neighborhood);
      expect(product.reachMode, ReachMode.localOnly);
      expect(product.trustScore, 0.3);
      expect(product.signalScore, 0.0);
      expect(product.translationState, isEmpty);
      expect(product.discoveryChannels, ['feed', 'map', 'search']);
      expect(product.mapVisibility, isTrue);
    });

    test('implements MozzyPostContract fields correctly', () {
      final product = ProductModel(
        id: 'p1',
        userId: 'u1',
        title: 'Title',
        description: 'Desc',
        category: 'Cat',
        price: 100,
        geoPath: 'ID#A',
        createdAt: DateTime.now(),
      );

      // Cast to verify it implements the contract
      final contract = product as MozzyPostContract;

      expect(contract.id, 'p1');
      expect(contract.userId, 'u1');
      expect(contract.geoScope, GeoScope.neighborhood);
      expect(contract.reachMode, ReachMode.localOnly);
      expect(contract.trustScore, 0.3);
      expect(contract.signalScore, 0.0);
      expect(contract.translationState, isEmpty);
      expect(contract.geoPath, 'ID#A');
    });
  });
}