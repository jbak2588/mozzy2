import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mockito/annotations.dart';
import 'package:mozzy/mozzy_ii/domains/feedback/screens/feedback_screen.dart';
import 'package:mozzy/mozzy_ii/domains/feedback/services/feedback_service.dart';
import 'package:mozzy/mozzy_ii/domains/feedback/providers/feedback_providers.dart';

@GenerateMocks([FeedbackService])
import 'feedback_screen_test.mocks.dart';

void main() {
  testWidgets('FeedbackScreen renders and validates input', (WidgetTester tester) async {
    final mockService = MockFeedbackService();

    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          feedbackServiceProvider.overrideWithValue(mockService),
        ],
        child: const MaterialApp(
          home: FeedbackScreen(),
        ),
      ),
    );

    // Verify title
    expect(find.text('feedback.title'), findsOneWidget);

    // Verify privacy notice
    expect(find.text('feedback.privacyNotice'), findsOneWidget);

    // Submit button should be present
    final submitButton = find.text('feedback.submit');
    expect(submitButton, findsOneWidget);

    // Enter message
    await tester.enterText(find.byType(TextField).first, 'This is a test feedback message');
    
    // Verify character count or presence
    expect(find.text('This is a test feedback message'), findsOneWidget);
  });
}
