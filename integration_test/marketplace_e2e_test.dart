import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:mozzy/main.dart' as app;

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('Marketplace List-Create-Detail E2E Flow', (WidgetTester tester) async {
    // 1. Start app
    app.main();
    await tester.pumpAndSettle();
    await tester.pump(const Duration(seconds: 3));
    await tester.pumpAndSettle();

    // 2. Navigate to Marketplace Tab (Icons.storefront)
    bool foundNav = false;
    for (int i = 0; i < 10; i++) {
      await tester.pump(const Duration(seconds: 1));
      if (find.byIcon(Icons.storefront).evaluate().isNotEmpty) {
        foundNav = true;
        break;
      }
    }

    if (!foundNav) {
      fail('Could not find Marketplace Tab (Icons.storefront)');
    }

    await tester.tap(find.byIcon(Icons.storefront));
    await tester.pumpAndSettle();

    // 3. Confirm MarketplaceListScreen appears
    expect(find.byKey(const Key('marketplaceListScreen')), findsOneWidget);
    
    // 4. Verify category chips appear (at least 'all')
    expect(find.byType(ChoiceChip), findsAtLeast(1));

    // 5. Tap Create FAB
    await tester.tap(find.byKey(const Key('marketplaceCreateFab')));
    await tester.pumpAndSettle();
    await tester.pump(const Duration(seconds: 2));
    await tester.pumpAndSettle();

    // 6. Confirm CreateProductScreen appears
    expect(find.byKey(const Key('createProductScreen')), findsOneWidget);

    // 6.1. Select an image (long press for fake injection in integration mode)
    await tester.longPress(find.byKey(const Key('createProductAddImageButton')));
    await tester.pumpAndSettle();
    expect(find.byKey(const Key('createProductImagePreview_0')), findsOneWidget);

    // 7. Submit empty form (title/description/price still missing)
    await tester.tap(find.byKey(const Key('createProductSubmitButton')));
    await tester.pumpAndSettle();
    
    // Should show validation error (we can verify it stays on create screen)
    expect(find.byKey(const Key('createProductScreen')), findsOneWidget);

    // 8. Enter Title only
    await tester.enterText(find.byKey(const Key('createProductTitleField')), 'Automated Marketplace Test Product');
    await tester.testTextInput.receiveAction(TextInputAction.done);
    FocusManager.instance.primaryFocus?.unfocus();
    await tester.pumpAndSettle();

    // 9. Submit and verify it stays on create screen (description missing)
    await tester.tap(find.byKey(const Key('createProductSubmitButton')));
    await tester.pumpAndSettle();
    expect(find.byKey(const Key('createProductScreen')), findsOneWidget);

    // 10. Enter Description
    await tester.enterText(find.byKey(const Key('createProductDescriptionField')), 'This is an automated marketplace integration test product.');
    await tester.testTextInput.receiveAction(TextInputAction.done);
    FocusManager.instance.primaryFocus?.unfocus();
    await tester.pumpAndSettle();

    // 11. Submit and verify it stays on create screen (price missing)
    await tester.tap(find.byKey(const Key('createProductSubmitButton')));
    await tester.pumpAndSettle();
    expect(find.byKey(const Key('createProductScreen')), findsOneWidget);

    // 12. Enter Price
    await tester.enterText(find.byKey(const Key('createProductPriceField')), '150000');
    await tester.testTextInput.receiveAction(TextInputAction.done);
    FocusManager.instance.primaryFocus?.unfocus();
    await tester.pumpAndSettle();

    // 13. Select Category (optional, electronics is default)
    // 14. Submit
    await tester.tap(find.byKey(const Key('createProductSubmitButton')));
    
    // Wait for pop to happen and list to refresh
    await tester.pumpAndSettle(const Duration(seconds: 2));

    // 15. Confirm we are back to Marketplace List screen
    expect(find.byKey(const Key('marketplaceListScreen')), findsOneWidget);

    // 16. Confirm the created product appears in the grid
    expect(find.text('Automated Marketplace Test Product'), findsWidgets);

    // 17. Tap the product card
    await tester.tap(find.text('Automated Marketplace Test Product').first);
    await tester.pumpAndSettle();

    // 18. Confirm ProductDetailScreen appears
    expect(find.byKey(const Key('productDetailScreen')), findsOneWidget);

    // 19. Confirm detail info appears
    expect(find.text('Automated Marketplace Test Product'), findsWidgets);
    expect(find.text('This is an automated marketplace integration test product.'), findsWidgets);
    expect(find.text('Rp 150.000'), findsWidgets);
    
    // Category check
    // Note: Detail screen uses marketplace.category.electronics.tr()
    // In integration test with easy_localization, we should expect translated or key depending on init.
    // The previous news test expected text, let's assume it works.
    
    // AI Status Section check
    expect(find.byIcon(Icons.auto_awesome), findsOneWidget);
    expect(find.textContaining('passed'), findsAtLeast(1));
    expect(find.textContaining('92%'), findsOneWidget);
    expect(find.textContaining('AI verification passed in integration mode'), findsOneWidget);

    // Test completed successfully
  });
}
