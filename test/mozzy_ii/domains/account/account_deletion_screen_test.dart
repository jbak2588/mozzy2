import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mockito/annotations.dart';
import 'package:mozzy/mozzy_ii/domains/account/screens/account_deletion_screen.dart';
import 'package:mozzy/mozzy_ii/domains/account/services/account_deletion_service.dart';
import 'package:mozzy/mozzy_ii/domains/account/providers/account_deletion_providers.dart';

@GenerateMocks([AccountDeletionService])
import 'account_deletion_screen_test.mocks.dart';

void main() {
  testWidgets('AccountDeletionScreen UI and validation', (WidgetTester tester) async {
    final mockService = MockAccountDeletionService();

    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          accountDeletionServiceProvider.overrideWithValue(mockService),
        ],
        child: const MaterialApp(
          home: AccountDeletionScreen(),
        ),
      ),
    );

    // Verify title
    expect(find.text('accountDeletion.title'), findsOneWidget);

    // Verify warning
    expect(find.text('accountDeletion.warning'), findsOneWidget);

    // Button should be disabled initially
    final deleteButton = find.byType(ElevatedButton);
    expect(tester.widget<ElevatedButton>(deleteButton).enabled, isFalse);

    // Tap checkbox
    await tester.tap(find.byType(CheckboxListTile));
    await tester.pumpAndSettle();

    // Now button should be enabled
    expect(tester.widget<ElevatedButton>(deleteButton).enabled, isTrue);

    // Enter reason
    await tester.enterText(find.byType(TextField), 'Moving to another city');
    expect(find.text('Moving to another city'), findsOneWidget);

    // Tap Delete (should show dialog)
    await tester.tap(deleteButton);
    await tester.pumpAndSettle();

    expect(find.text('accountDeletion.confirmTitle'), findsOneWidget);
    expect(find.text('accountDeletion.confirm'), findsOneWidget);
  });
}
