import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mozzy/mozzy_ii/domains/feed/widgets/feed_item_card.dart';
import 'package:mozzy/mozzy_ii/domains/feed/models/feed_item_model.dart';
import 'package:mozzy/mozzy_ii/domains/feed/models/feed_item_type.dart';
import '../../../helpers/test_localization_app.dart';

void main() {
  group('FeedItemCard Widget Tests', () {
    testWidgets('FeedItemCard displays item details', (WidgetTester tester) async {
      final now = DateTime.now();
      final item = FeedItemModel(
        id: '1',
        sourceId: '1',
        type: FeedItemType.job,
        title: 'Senior Developer',
        subtitle: 'Awesome Tech',
        locationText: 'Jakarta',
        createdAt: now,
        isPromoted: true,
        route: '/jobs/1',
      );

      await pumpMozzyTestApp(
        tester,
        FeedItemCard(item: item),
      );

      await tester.pumpAndSettle();

      expect(find.text('Senior Developer'), findsOneWidget);
      expect(find.text('Awesome Tech'), findsOneWidget);
      expect(find.text('Jakarta'), findsOneWidget);
      // Promoted badge should be visible
      expect(find.byIcon(Icons.bolt), findsOneWidget);
    });

    testWidgets('FeedItemCard displays marketplace product details', (WidgetTester tester) async {
      final now = DateTime.now();
      final item = FeedItemModel(
        id: 'p1',
        sourceId: 'p1',
        type: FeedItemType.marketplaceProduct,
        title: 'Used Phone',
        subtitle: 'Rp 1.000.000',
        createdAt: now,
        route: '/marketplace/p1',
      );

      await pumpMozzyTestApp(
        tester,
        FeedItemCard(item: item),
      );

      await tester.pumpAndSettle();

      expect(find.text('Used Phone'), findsOneWidget);
      expect(find.text('Rp 1.000.000'), findsOneWidget);
    });
  });
}
