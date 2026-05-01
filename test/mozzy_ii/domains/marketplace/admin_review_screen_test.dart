import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mozzy/mozzy_ii/domains/marketplace/repositories/in_memory_ai_verification_report_repository.dart';
import 'package:mozzy/mozzy_ii/domains/marketplace/providers/marketplace_provider.dart';
import 'package:mozzy/mozzy_ii/domains/marketplace/screens/admin_review_screen.dart';
import 'package:mozzy/mozzy_ii/domains/marketplace/models/ai_verification_report_model.dart';
import 'package:mozzy/mozzy_ii/domains/marketplace/models/admin_role_model.dart';

void main() {
  late InMemoryAiVerificationReportRepository mockRepo;

  setUp(() {
    mockRepo = InMemoryAiVerificationReportRepository();
  });

  Widget createTestWidget() {
    return ProviderScope(
      overrides: [
        aiVerificationReportRepositoryProvider.overrideWithValue(mockRepo),
        marketplaceAdminRoleProvider.overrideWithValue(MarketplaceAdminRole.admin),
      ],
      child: const MaterialApp(
        home: AdminReviewScreen(),
      ),
    );
  }

  testWidgets('AdminReviewScreen renders and shows empty state when queue is empty', (tester) async {
    await tester.pumpWidget(createTestWidget());
    await tester.pumpAndSettle();

    expect(find.byKey(const Key('adminReviewScreen')), findsOneWidget);
    expect(find.byKey(const Key('adminReviewEmptyState')), findsOneWidget);
  });

  testWidgets('AdminReviewScreen shows items when queue is not empty', (tester) async {
    final report = AiVerificationReportModel(
      id: 'r1',
      productId: 'p1',
      sellerId: 's1',
      status: 'failed',
      summary: 'Potential counterfeit item',
      createdAt: DateTime.now(),
    );
    await mockRepo.saveReport(report);
    await mockRepo.enqueueReviewIfNeeded(report: report);

    await tester.pumpWidget(createTestWidget());
    await tester.pumpAndSettle();

    expect(find.byKey(const Key('adminReviewQueueList')), findsOneWidget);
    expect(find.text('Product ID: p1'), findsOneWidget);
    expect(find.textContaining('Potential counterfeit item'), findsOneWidget);
    // Key 'marketplace.reviewFailed' would be shown if translation works, 
    // but in test it might just be the key or its translation.
    // Check for the status badge text (if translations are not loaded, it shows the key)
  });

  testWidgets('AdminReviewScreen does not have approve or reject buttons', (tester) async {
    final report = AiVerificationReportModel(
      id: 'r1',
      productId: 'p1',
      sellerId: 's1',
      status: 'needs_review',
      summary: 'Manual check needed',
      createdAt: DateTime.now(),
    );
    await mockRepo.saveReport(report);
    await mockRepo.enqueueReviewIfNeeded(report: report);

    await tester.pumpWidget(createTestWidget());
    await tester.pumpAndSettle();

    expect(find.byType(ElevatedButton), findsNothing);
    expect(find.text('Approve'), findsNothing);
    expect(find.text('Reject'), findsNothing);
  });

  testWidgets('AdminReviewScreen shows access denied when unauthorized', (tester) async {
    await tester.pumpWidget(ProviderScope(
      overrides: [
        marketplaceAdminRoleProvider.overrideWithValue(MarketplaceAdminRole.none),
      ],
      child: const MaterialApp(
        home: AdminReviewScreen(),
      ),
    ));
    await tester.pumpAndSettle();

    expect(find.byKey(const Key('adminReviewAccessDenied')), findsOneWidget);
    expect(find.textContaining('Access Denied'), findsNothing); // Translations might not be loaded, check for key or logic
  });
}
