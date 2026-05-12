import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mozzy/mozzy_ii/domains/feed/screens/smart_feed_screen.dart';
import 'package:mozzy/mozzy_ii/domains/feed/providers/smart_feed_provider.dart';
import 'package:mozzy/mozzy_ii/domains/feed/models/feed_item_model.dart';
import 'package:mozzy/mozzy_ii/domains/feed/models/feed_item_type.dart';
import 'package:mozzy/mozzy_ii/domains/feed/widgets/smart_feed_search_bar.dart';
import 'package:visibility_detector/visibility_detector.dart';
import '../../../helpers/test_localization_app.dart';

void main() {
  setUp(() {
    VisibilityDetectorController.instance.updateInterval = Duration.zero;
  });

  group('SmartFeedScreen Widget Tests', () {
    testWidgets('SmartFeedScreen shows loading state', (WidgetTester tester) async {
      await pumpMozzyTestApp(
        tester,
        const SmartFeedScreen(),
        overrides: [
          smartFeedProvider.overrideWith((ref) => const Stream.empty()),
        ],
      );
      await tester.pump();

      expect(find.byType(CircularProgressIndicator), findsOneWidget);
    });

    testWidgets('SmartFeedScreen displays SearchBar', (WidgetTester tester) async {
      await pumpMozzyTestApp(
        tester,
        const SmartFeedScreen(),
      );
      await tester.pumpAndSettle();

      expect(find.byType(SmartFeedSearchBar), findsOneWidget);
    });

    testWidgets('SmartFeedScreen shows items when data is available', (WidgetTester tester) async {
      final now = DateTime.now();
      final items = [
        FeedItemModel(
          id: '1',
          sourceId: '1',
          type: FeedItemType.job,
          title: 'Test Job',
          subtitle: 'Test Company',
          createdAt: now,
          route: '/jobs/1',
        ),
      ];

      await pumpMozzyTestApp(
        tester,
        const SmartFeedScreen(),
        overrides: [
          smartFeedProvider.overrideWith((ref) => Stream.value(items)),
        ],
      );

      await tester.pumpAndSettle();

      expect(find.text('Test Job'), findsOneWidget);
      expect(find.text('Test Company'), findsOneWidget);
    });

    testWidgets('SmartFeedScreen shows empty state when no items', (WidgetTester tester) async {
      await pumpMozzyTestApp(
        tester,
        const SmartFeedScreen(),
        overrides: [
          smartFeedProvider.overrideWith((ref) => Stream.value([])),
        ],
      );

      await tester.pumpAndSettle();

      // "feed.empty" key should be translated or at least the key itself should be found if not translated
      expect(find.byType(ListView), findsNothing);
    });

    testWidgets('SmartFeedScreen shows error state', (WidgetTester tester) async {
      await pumpMozzyTestApp(
        tester,
        const SmartFeedScreen(),
        overrides: [
          smartFeedProvider.overrideWith((ref) => Stream.error(Exception('Error'))),
        ],
      );

      await tester.pumpAndSettle();

      expect(find.byType(ElevatedButton), findsOneWidget);
    });
  });
}
