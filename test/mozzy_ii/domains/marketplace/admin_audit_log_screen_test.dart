// ============================================================================
// Mozzy DocHeader
// Module        : Marketplace Domain
// File          : test/mozzy_ii/domains/marketplace/admin_audit_log_screen_test.dart
// Purpose       : AdminAuditLogScreen UI 및 권한 테스트.
// ============================================================================

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mozzy/mozzy_ii/domains/marketplace/providers/marketplace_provider.dart';
import 'package:mozzy/mozzy_ii/domains/marketplace/screens/admin_audit_log_screen.dart';
import 'package:mozzy/mozzy_ii/domains/marketplace/models/admin_audit_log_model.dart';
import 'package:mozzy/mozzy_ii/domains/marketplace/models/admin_role_model.dart';
import 'package:mozzy/mozzy_ii/domains/marketplace/repositories/in_memory_admin_audit_log_repository.dart';

void main() {
  late InMemoryAdminAuditLogRepository mockRepo;

  setUp(() {
    mockRepo = InMemoryAdminAuditLogRepository();
  });

  Widget createTestWidget({
    required MarketplaceAdminRole role,
    InMemoryAdminAuditLogRepository? auditRepo,
  }) {
    return ProviderScope(
      overrides: [
        marketplaceAdminRoleAsyncProvider.overrideWith((ref) => role),
        if (auditRepo != null)
          adminAuditLogRepositoryProvider.overrideWithValue(auditRepo),
      ],
      child: const MaterialApp(home: AdminAuditLogScreen()),
    );
  }

  group('AdminAuditLogScreen Tests', () {
    testWidgets('shows access denied when role is none', (tester) async {
      await tester.pumpWidget(
        createTestWidget(role: MarketplaceAdminRole.none),
      );

      await tester.pumpAndSettle();

      expect(
        find.byKey(const Key('adminAuditLogAccessDenied')),
        findsOneWidget,
      );
    });

    testWidgets('shows empty state when no logs exist', (tester) async {
      await tester.pumpWidget(
        createTestWidget(role: MarketplaceAdminRole.admin, auditRepo: mockRepo),
      );

      await tester.pumpAndSettle();

      expect(find.byKey(const Key('adminAuditLogEmptyState')), findsOneWidget);
    });

    testWidgets('renders audit logs list', (tester) async {
      final log = AdminAuditLogModel(
        id: 'log1',
        action: 'approve',
        queueItemId: 'q1',
        productId: 'p1',
        reviewerId: 'u1',
        reviewerRole: 'admin',
        previousReviewStatus: 'pending',
        newReviewStatus: 'approved',
        decision: 'Safe content',
        createdAt: DateTime.now(),
      );

      await mockRepo.recordModerationAction(log);

      await tester.pumpWidget(
        createTestWidget(role: MarketplaceAdminRole.admin, auditRepo: mockRepo),
      );

      await tester.pumpAndSettle();

      expect(find.byKey(const Key('adminAuditLogList')), findsOneWidget);
      expect(find.text('p1'), findsOneWidget);
      expect(find.text('admin'), findsOneWidget);
      expect(find.text('Safe content'), findsOneWidget);
    });
  });
}
