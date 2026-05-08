import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:mozzy/mozzy_ii/domains/admin/providers/admin_auth_provider.dart';
import 'package:mozzy/mozzy_ii/domains/admin/models/admin_claims_model.dart';
import 'package:mozzy/mozzy_ii/domains/monetization/screens/admin_monetization_audit_screen.dart';
import 'package:mozzy/mozzy_ii/domains/monetization/widgets/audit_log_card.dart';
import 'package:mozzy/mozzy_ii/domains/monetization/models/monetization_audit_log_model.dart';

class MockAdminAuth extends AdminAuth {
  final AdminClaimsModel claims;
  MockAdminAuth(this.claims);

  @override
  Stream<AdminClaimsModel> build() => Stream.value(claims);
}

void main() {
  group('AuditLogCard', () {
    testWidgets('renders correct information', (WidgetTester tester) async {
      final now = DateTime.now();
      final log = MonetizationAuditLogModel(
        id: 'log_very_long_id_that_should_be_truncated',
        type: 'job_boost_activated',
        relatedDomain: 'jobs',
        relatedId: 'job_very_long_id_that_should_be_truncated',
        actorType: 'system',
        createdAt: now,
        amount: 15000,
      );

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: AuditLogCard(log: log),
          ),
        ),
      );

      // Note: Translations might not be initialized
      expect(find.text('admin.job_boost_activated'), findsOneWidget);
      expect(find.textContaining('job_very_lon...'), findsWidgets);
      expect(find.textContaining('system'), findsOneWidget);
      expect(find.textContaining('Rp 15.000'), findsOneWidget);
    });
  });

  group('AdminMonetizationAuditScreen', () {
    testWidgets('shows access denied when isAdmin is false', (WidgetTester tester) async {
      await tester.pumpWidget(
        ProviderScope(
          overrides: [
            adminAuthProvider.overrideWith(() => MockAdminAuth(const AdminClaimsModel(isAdmin: false))),
          ],
          child: const MaterialApp(
            home: AdminMonetizationAuditScreen(),
          ),
        ),
      );

      await tester.pump(); // Start stream
      await tester.pump(); // Data available

      expect(find.text('admin.accessDenied'), findsOneWidget);
      expect(find.text('admin.permissionDenied'), findsOneWidget);
    });

    testWidgets('shows content when isAdmin is true', (WidgetTester tester) async {
      await tester.pumpWidget(
        ProviderScope(
          overrides: [
            adminAuthProvider.overrideWith(() => MockAdminAuth(const AdminClaimsModel(isAdmin: true))),
          ],
          child: const MaterialApp(
            home: AdminMonetizationAuditScreen(),
          ),
        ),
      );

      await tester.pump(); // Start stream
      await tester.pump(); // Data available

      expect(find.text('admin.monetizationAudit'), findsWidgets);
      expect(find.text('admin.accessDenied'), findsNothing);
    });
  });
}
