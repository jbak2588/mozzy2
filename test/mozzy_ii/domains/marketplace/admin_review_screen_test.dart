import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mozzy/mozzy_ii/domains/marketplace/repositories/in_memory_ai_verification_report_repository.dart';
import 'package:mozzy/mozzy_ii/domains/marketplace/repositories/in_memory_marketplace_repository.dart';
import 'package:mozzy/mozzy_ii/domains/marketplace/providers/marketplace_provider.dart';
import 'package:mozzy/mozzy_ii/domains/marketplace/screens/admin_review_screen.dart';
import 'package:mozzy/mozzy_ii/domains/marketplace/models/ai_verification_report_model.dart';
import 'package:mozzy/mozzy_ii/domains/marketplace/models/admin_role_model.dart';
import 'package:mozzy/mozzy_ii/domains/marketplace/services/in_memory_marketplace_admin_role_source.dart';

void main() {
  late InMemoryAiVerificationReportRepository mockRepo;
  late InMemoryMarketplaceAdminRoleSource mockRoleSource;

  setUp(() {
    mockRepo = InMemoryAiVerificationReportRepository();
    mockRoleSource = InMemoryMarketplaceAdminRoleSource(MarketplaceAdminRole.admin);
  });

  Widget createTestWidget({MarketplaceAdminRole role = MarketplaceAdminRole.admin}) {
    mockRoleSource.setRole(role);
    return ProviderScope(
      overrides: [
        aiVerificationReportRepositoryProvider.overrideWithValue(mockRepo),
        marketplaceRepositoryProvider.overrideWithValue(InMemoryMarketplaceRepository()),
        marketplaceAdminRoleSourceProvider.overrideWithValue(mockRoleSource),
        currentMarketplaceUserIdProvider.overrideWithValue('test_admin_id'),
      ],
      child: const MaterialApp(
        home: AdminReviewScreen(),
      ),
    );
  }

  testWidgets('AdminReviewScreen renders and shows empty state when queue is empty', (tester) async {
    await tester.pumpWidget(createTestWidget());
    await tester.pump(); // Start async role check
    await tester.pump(); // Complete async role check
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
    await tester.pump(); // role check
    await tester.pump(); // role check
    await tester.pumpAndSettle();

    expect(find.byKey(const Key('adminReviewQueueList')), findsOneWidget);
    expect(find.text('Product ID: p1'), findsOneWidget);
  });

  testWidgets('AdminReviewScreen shows buttons when canModerate is true', (tester) async {
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
    await tester.pump(); // role check
    await tester.pump(); // role check
    await tester.pumpAndSettle();

    expect(find.byKey(const Key('approveBtn_r1')), findsOneWidget);
    expect(find.byKey(const Key('rejectBtn_r1')), findsOneWidget);
    expect(find.byKey(const Key('dismissBtn_r1')), findsOneWidget);
  });

  testWidgets('AdminReviewScreen handles approve action', (tester) async {
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
    await tester.pump(); // role check
    await tester.pump(); // role check
    await tester.pumpAndSettle();

    await tester.tap(find.byKey(const Key('approveBtn_r1')));
    await tester.pump(); // Start the async action
    await tester.pumpAndSettle(); // Wait for it to complete

    // Verify it's resolved in mockRepo
    final items = await mockRepo.fetchOpenReviewQueue();
    expect(items.any((i) => i.id == 'r1'), isFalse);
  });

  testWidgets('AdminReviewScreen shows access denied when unauthorized', (tester) async {
    await tester.pumpWidget(createTestWidget(role: MarketplaceAdminRole.none));
    await tester.pump(); // role check
    await tester.pump(); // role check
    await tester.pumpAndSettle();

    expect(find.byKey(const Key('adminReviewAccessDenied')), findsOneWidget);
  });

  testWidgets('AdminReviewScreen shows queue but no buttons for reviewer', (tester) async {
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

    await tester.pumpWidget(createTestWidget(role: MarketplaceAdminRole.reviewer));
    await tester.pump(); // role check
    await tester.pump(); // role check
    await tester.pumpAndSettle();

    expect(find.byKey(const Key('adminReviewQueueList')), findsOneWidget);
    expect(find.byKey(const Key('approveBtn_r1')), findsNothing);
    expect(find.byKey(const Key('rejectBtn_r1')), findsNothing);
  });
}
