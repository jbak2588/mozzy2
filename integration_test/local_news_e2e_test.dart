import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:mozzy/main.dart' as app;

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('Local News List-Create-Detail E2E Flow', (WidgetTester tester) async {
    // 1. Start app
    app.main();
    await tester.pumpAndSettle();
    await tester.pump(const Duration(seconds: 3));
    await tester.pumpAndSettle();

    // 2. We should be on Home since AuthGate bypasses login
    // Let's wait for the BottomNavigationBar item to appear
    bool foundNav = false;
    for (int i = 0; i < 10; i++) {
      await tester.pump(const Duration(seconds: 1));
      if (find.byIcon(Icons.article).evaluate().isNotEmpty) {
        foundNav = true;
        break;
      }
    }

    if (!foundNav) {
      fail('Could not find News Tab (Icons.article)');
    }

    await tester.tap(find.byIcon(Icons.article));
    await tester.pumpAndSettle();

    // 3. Confirm LocalNewsListScreen appears
    expect(find.byKey(const Key('localNewsListScreen')), findsOneWidget);
    
    // 4. Tap Create FAB
    await tester.tap(find.byKey(const Key('localNewsCreateFab')));
    await tester.pumpAndSettle();

    // 5. Confirm CreatePostScreen appears
    expect(find.byKey(const Key('createPostScreen')), findsOneWidget);

    // 6. Empty Submit to see validation
    await tester.tap(find.byKey(const Key('createPostSubmitButton')));
    await tester.pumpAndSettle();
    
    // Should show titleRequired snackbar (we can just verify it stays on create screen)
    expect(find.byKey(const Key('createPostScreen')), findsOneWidget);

    // 7. Enter Title
    await tester.enterText(find.byKey(const Key('createPostTitleField')), 'Smoke Test Local News');
    await tester.testTextInput.receiveAction(TextInputAction.done);
    FocusManager.instance.primaryFocus?.unfocus();
    await tester.pump(const Duration(seconds: 2));
    await tester.pumpAndSettle();

    // 8. Empty content submit
    await tester.ensureVisible(find.byKey(const Key('createPostSubmitButton')));
    await tester.tap(find.byKey(const Key('createPostSubmitButton')), warnIfMissed: false);
    await tester.pumpAndSettle();
    expect(find.byKey(const Key('createPostScreen')), findsOneWidget);

    // 9. Enter Content
    await tester.enterText(find.byKey(const Key('createPostContentField')), 'This is an automated integration test post from Flutter.');
    await tester.testTextInput.receiveAction(TextInputAction.done);
    FocusManager.instance.primaryFocus?.unfocus();
    await tester.pump(const Duration(seconds: 2));
    await tester.pumpAndSettle();

    // 10. Change Category
    // To change dropdown, we tap it, wait, and tap the item. But 'umum' is default. We can leave it or change. Let's just leave 'umum'.

    // 11. Submit
    await tester.ensureVisible(find.byKey(const Key('createPostSubmitButton')));
    await tester.tap(find.byKey(const Key('createPostSubmitButton')), warnIfMissed: false);
    
    // Wait for pop to happen
    await tester.pumpAndSettle(const Duration(seconds: 2));

    // 12. Confirm we are back to List screen
    expect(find.byKey(const Key('localNewsListScreen')), findsOneWidget);

    // 13. Confirm the post appears
    expect(find.text('Smoke Test Local News'), findsWidgets);

    // 14. Tap the post
    await tester.tap(find.text('Smoke Test Local News').first);
    await tester.pumpAndSettle();

    // 15. Confirm Detail Screen appears
    expect(find.byKey(const Key('localNewsDetailScreen')), findsOneWidget);

    // 16. Confirm detail info appears
    expect(find.text('Smoke Test Local News'), findsWidgets);
    expect(find.text('This is an automated integration test post from Flutter.'), findsWidgets);

    // Test completed successfully
  });
}
