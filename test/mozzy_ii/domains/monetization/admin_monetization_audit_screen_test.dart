import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:mozzy/mozzy_ii/domains/monetization/screens/admin_monetization_audit_screen.dart';
import 'package:mozzy/mozzy_ii/domains/monetization/widgets/audit_log_card.dart';
import 'package:mozzy/mozzy_ii/domains/monetization/models/monetization_audit_log_model.dart';

void main() {
  group('AuditLogCard', () {
    testWidgets('renders correct information', (WidgetTester tester) async {
      final now = DateTime.now();
      final log = MonetizationAuditLogModel(
        id: 'log_1',
        type: 'job_boost_activated',
        relatedDomain: 'jobs',
        relatedId: 'job_1',
        actorType: 'system',
        createdAt: now,
      );

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: AuditLogCard(log: log),
          ),
        ),
      );

      // Note: Translations might not be initialized, so we check for key or tr() output
      expect(find.text('admin.job_boost_activated'), findsOneWidget);
      expect(find.textContaining('job_1'), findsWidgets);
      expect(find.textContaining('system'), findsOneWidget);
    });
  });

  group('AdminMonetizationAuditScreen', () {
    testWidgets('shows access denied when kEnableLocalAdminScreens is false', (WidgetTester tester) async {
      await tester.pumpWidget(
        const ProviderScope(
          child: MaterialApp(
            home: AdminMonetizationAuditScreen(),
          ),
        ),
      );

      // Access denied is shown by default because of kEnableLocalAdminScreens = false
      expect(find.text('admin.accessDenied'), findsOneWidget);
      expect(find.text('admin.adminOnly'), findsOneWidget);
    });
  });
}
