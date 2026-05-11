import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mozzy/mozzy_ii/shared/screens/feature_coming_soon_screen.dart';

void main() {
  testWidgets('FeatureComingSoonScreen renders correctly', (WidgetTester tester) async {
    const featureName = 'Test Feature';

    await tester.pumpWidget(
      const MaterialApp(
        // We mock easy_localization's tr() extension by avoiding it or
        // relying on the fallback behavior in tests if not initialized.
        // Actually, if easy_localization is not initialized, it returns the key.
        home: FeatureComingSoonScreen(featureName: featureName),
      ),
    );

    // Verify AppBar title
    expect(find.text(featureName), findsOneWidget);

    // Verify Icon
    expect(find.byIcon(Icons.construction), findsOneWidget);

    // Verify keys (or text if tr() isn't working)
    expect(find.text('beta.comingSoonTitle'), findsOneWidget);
    expect(find.text('beta.comingSoonBody'), findsOneWidget);
    expect(find.text('beta.backToHome'), findsOneWidget);
    
    // Verify Button
    expect(find.byType(ElevatedButton), findsOneWidget);
  });
}
