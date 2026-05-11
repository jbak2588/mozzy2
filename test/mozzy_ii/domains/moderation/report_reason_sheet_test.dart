import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mozzy/mozzy_ii/domains/moderation/models/report_model.dart';
import 'package:mozzy/mozzy_ii/domains/moderation/widgets/report_reason_sheet.dart';

void main() {
  testWidgets('ReportReasonSheet renders correctly and handles state', (WidgetTester tester) async {
    await tester.pumpWidget(
      const ProviderScope(
        child: MaterialApp(
          home: Scaffold(
            body: ReportReasonSheet(
              targetType: ReportTargetType.news,
              targetId: 'news_123',
            ),
          ),
        ),
      ),
    );

    // Verify title
    expect(find.text('moderation.reportContent'), findsOneWidget);

    // Verify radio buttons
    expect(find.byType(RadioListTile<ReportReason>), findsWidgets);

    // Initially button is disabled (or does nothing if selectedReason is null)
    final submitButton = find.byType(ElevatedButton);
    expect(submitButton, findsOneWidget);
    expect(tester.widget<ElevatedButton>(submitButton).enabled, isFalse);

    // Tap a reason
    await tester.tap(find.byType(RadioListTile<ReportReason>).first);
    await tester.pumpAndSettle();

    // Now button should be enabled
    expect(tester.widget<ElevatedButton>(submitButton).enabled, isTrue);

    // Input text in description
    await tester.enterText(find.byType(TextField), 'This is a test description');
    expect(find.text('This is a test description'), findsOneWidget);
  });
}
