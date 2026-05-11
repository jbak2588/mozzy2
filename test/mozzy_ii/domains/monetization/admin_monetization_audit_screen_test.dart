import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
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
    testWidgets('shows loading state initially', (WidgetTester tester) async {
      await tester.pumpWidget(
        ProviderScope(
          overrides: [
            // Return a stream that doesn't emit immediately if possible, 
            // but here we just check if it shows loading before pump()
            adminAuthProvider.overrideWith(() => MockAdminAuth(const AdminClaimsModel(isAdmin: true))),
          ],
          child: const MaterialApp(
            home: AdminMonetizationAuditScreen(),
          ),
        ),
      );

      expect(find.text('admin.checkingPermission'), findsOneWidget);
      expect(find.byType(CircularProgressIndicator), findsOneWidget);
    });

    testWidgets('shows access denied when role is ops_admin', (WidgetTester tester) async {
      await tester.pumpWidget(
        ProviderScope(
          overrides: [
            adminAuthProvider.overrideWith(() => MockAdminAuth(
                  const AdminClaimsModel(isAdmin: true, adminRole: 'ops_admin'),
                )),
          ],
          child: const MaterialApp(
            home: AdminMonetizationAuditScreen(),
          ),
        ),
      );

      await tester.pump();
      await tester.pump();

      expect(find.text('admin.accessDenied'), findsOneWidget);
      expect(find.text('admin.monetizationAuditRequiresFinance'), findsOneWidget);
      expect(find.textContaining('admin.currentRole'), findsOneWidget);
    });

    testWidgets('shows access denied when role is support_admin', (WidgetTester tester) async {
      await tester.pumpWidget(
        ProviderScope(
          overrides: [
            adminAuthProvider.overrideWith(() => MockAdminAuth(
                  const AdminClaimsModel(isAdmin: true, adminRole: 'support_admin'),
                )),
          ],
          child: const MaterialApp(
            home: AdminMonetizationAuditScreen(),
          ),
        ),
      );

      await tester.pump();
      await tester.pump();

      expect(find.text('admin.accessDenied'), findsOneWidget);
    });

    testWidgets('shows access denied when isAdmin is false even if role is finance_admin',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        ProviderScope(
          overrides: [
            adminAuthProvider.overrideWith(() => MockAdminAuth(
                  const AdminClaimsModel(isAdmin: false, adminRole: 'finance_admin'),
                )),
          ],
          child: const MaterialApp(
            home: AdminMonetizationAuditScreen(),
          ),
        ),
      );

      await tester.pump();
      await tester.pump();

      expect(find.text('admin.accessDenied'), findsOneWidget);
    });

    testWidgets('shows content when role is super_admin', (WidgetTester tester) async {
      await tester.pumpWidget(
        ProviderScope(
          overrides: [
            adminAuthProvider.overrideWith(() => MockAdminAuth(
                  const AdminClaimsModel(isAdmin: true, adminRole: 'super_admin'),
                )),
          ],
          child: const MaterialApp(
            home: AdminMonetizationAuditScreen(),
          ),
        ),
      );

      await tester.pump();
      await tester.pump();

      expect(find.text('admin.monetizationAudit'), findsWidgets);
      expect(find.text('admin.accessDenied'), findsNothing);
    });

    testWidgets('shows content when role is finance_admin', (WidgetTester tester) async {
      await tester.pumpWidget(
        ProviderScope(
          overrides: [
            adminAuthProvider.overrideWith(() => MockAdminAuth(
                  const AdminClaimsModel(isAdmin: true, adminRole: 'finance_admin'),
                )),
          ],
          child: const MaterialApp(
            home: AdminMonetizationAuditScreen(),
          ),
        ),
      );

      await tester.pump();
      await tester.pump();

      expect(find.text('admin.monetizationAudit'), findsWidgets);
      expect(find.text('admin.accessDenied'), findsNothing);
    });
  });
}
