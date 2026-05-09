import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mozzy/mozzy_ii/domains/feed/widgets/smart_feed_search_bar.dart';
import 'package:mozzy/mozzy_ii/domains/feed/providers/smart_feed_provider.dart';
import '../../../helpers/test_localization_app.dart';

class FakeIntent extends SmartFeedSearchIntent {
  @override
  String build() => 'test';
}

void main() {
  group('SmartFeedSearchBar Widget Tests', () {
    testWidgets('should display hint and search icon', (tester) async {
      await pumpMozzyTestApp(
        tester,
        const Scaffold(body: SmartFeedSearchBar()),
      );
      await tester.pumpAndSettle();

      expect(find.byIcon(Icons.search), findsOneWidget);
      expect(find.byType(TextField), findsOneWidget);
    });

    testWidgets('typing and submitting should update provider', (tester) async {
      await pumpMozzyTestApp(
        tester,
        const Scaffold(body: SmartFeedSearchBar()),
      );
      await tester.pumpAndSettle();

      await tester.enterText(find.byType(TextField), 'job');
      await tester.testTextInput.receiveAction(TextInputAction.search);
      await tester.pumpAndSettle();

      final context = tester.element(find.byType(SmartFeedSearchBar));
      final container = ProviderScope.containerOf(context);
      
      expect(container.read(smartFeedSearchIntentProvider), 'job');
    });

    testWidgets('clear button should reset provider and field', (tester) async {
      await pumpMozzyTestApp(
        tester,
        const Scaffold(body: SmartFeedSearchBar()),
        overrides: [
          smartFeedSearchIntentProvider.overrideWith(FakeIntent.new),
        ],
      );
      await tester.pumpAndSettle();

      expect(tester.widget<TextField>(find.byType(TextField)).controller?.text, 'test');

      final clearIcon = find.byIcon(Icons.clear);
      expect(clearIcon, findsAtLeast(1));

      await tester.tap(clearIcon.first);
      await tester.pumpAndSettle();

      final context = tester.element(find.byType(SmartFeedSearchBar));
      final container = ProviderScope.containerOf(context);

      expect(container.read(smartFeedSearchIntentProvider), '');
      expect(tester.widget<TextField>(find.byType(TextField)).controller?.text, '');
    });
  });
}
