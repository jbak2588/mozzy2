import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mozzy/mozzy_ii/domains/feed/widgets/feed_type_chip_bar.dart';
import 'package:mozzy/mozzy_ii/domains/feed/providers/smart_feed_provider.dart';
import '../../../helpers/test_localization_app.dart';

void main() {
  group('FeedTypeChipBar Widget Tests', () {
    testWidgets('FeedTypeChipBar displays all chips', (WidgetTester tester) async {
      await pumpMozzyTestApp(
        tester,
        const Scaffold(body: FeedTypeChipBar()),
      );

      await tester.pumpAndSettle();

      // We use translated text or keys. In tests without full asset loading, it might show the key.
      // But EasyLocalization usually defaults to the key if not found.
      expect(find.byType(ChoiceChip), findsAtLeastNWidgets(3));
    });

    testWidgets('FeedTypeChipBar updates filter on chip selection', (WidgetTester tester) async {
      final container = ProviderContainer();
      
      await tester.pumpWidget(
        UncontrolledProviderScope(
          container: container,
          child: MaterialApp(
            home: Builder(
              builder: (context) => const Scaffold(body: FeedTypeChipBar()),
            ),
          ),
        ),
      );

      // Initially null (Semua)
      expect(container.read(feedFilterProvider), isNull);

      // Find a chip that is NOT the first one (which is 'Semua')
      final chips = find.byType(ChoiceChip);
      await tester.tap(chips.at(1));
      await tester.pump();

      expect(container.read(feedFilterProvider), isNotNull);
    });
  });
}
