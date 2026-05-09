import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:easy_localization/easy_localization.dart';
import '../providers/monetization_audit_provider.dart';
import '../widgets/audit_log_card.dart';
import '../widgets/audit_type_filter_bar.dart';

import '../../admin/providers/admin_auth_provider.dart';

/// Temporary admin guard override for local development.
const bool kEnableLocalAdminScreens = false;

class AdminMonetizationAuditScreen extends ConsumerStatefulWidget {
  const AdminMonetizationAuditScreen({super.key});

  @override
  ConsumerState<AdminMonetizationAuditScreen> createState() =>
      _AdminMonetizationAuditScreenState();
}

class _AdminMonetizationAuditScreenState
    extends ConsumerState<AdminMonetizationAuditScreen> {
  String? _selectedType;

  @override
  Widget build(BuildContext context) {
    // 1. Admin Guard Check (Custom Claims based)
    final adminClaimsAsync = ref.watch(adminAuthProvider);
    final canReadAudit = ref.watch(canReadMonetizationAuditProvider);

    return adminClaimsAsync.when(
      loading: () => Scaffold(
        appBar: AppBar(title: const Text('admin.monetizationAudit').tr()),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const CircularProgressIndicator(),
              const SizedBox(height: 16),
              const Text('admin.checkingPermission').tr(),
            ],
          ),
        ),
      ),
      error: (err, stack) => Scaffold(
        appBar: AppBar(title: const Text('admin.monetizationAudit').tr()),
        body: Center(child: Text('Error checking admin permission: $err')),
      ),
      data: (claims) {
        final isDevEnabled = const bool.fromEnvironment('ENABLE_ADMIN_SCREENS',
                defaultValue: false) ||
            kEnableLocalAdminScreens;

        // Strict guard: must be admin AND (super_admin or finance_admin)
        if (!isDevEnabled && !canReadAudit) {
          return Scaffold(
            appBar: AppBar(title: const Text('admin.monetizationAudit').tr()),
            body: Center(
              child: Padding(
                padding: const EdgeInsets.all(24.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(Icons.lock_outline, size: 64, color: Colors.red),
                    const SizedBox(height: 16),
                    Text(
                      'admin.accessDenied'.tr(),
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(
                            color: Colors.red,
                            fontWeight: FontWeight.bold,
                          ),
                    ),
                    const SizedBox(height: 16),
                    const Text(
                      'admin.monetizationAuditRequiresFinance',
                      textAlign: TextAlign.center,
                    ).tr(),
                    const SizedBox(height: 24),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 8,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.grey.shade100,
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(color: Colors.grey.shade300),
                      ),
                      child: Text(
                        'admin.currentRole'.tr(namedArgs: {
                          'role': _formatRole(claims.adminRole, context),
                        }),
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                    ),
                    const SizedBox(height: 32),
                    ElevatedButton(
                      onPressed: () =>
                          ref.read(adminAuthProvider.notifier).refreshClaims(),
                      child: const Text('admin.refreshPermission').tr(),
                    ),
                  ],
                ),
              ),
            ),
          );
        }

        return _buildAuditContent(context);
      },
    );
  }

  String _formatRole(String? role, BuildContext context) {
    if (role == null) return 'admin.unknownRole'.tr();
    switch (role) {
      case 'super_admin':
        return 'admin.superAdmin'.tr();
      case 'finance_admin':
        return 'admin.financeAdmin'.tr();
      case 'ops_admin':
        return 'admin.opsAdmin'.tr();
      case 'support_admin':
        return 'admin.supportAdmin'.tr();
      default:
        return role;
    }
  }

  Widget _buildAuditContent(BuildContext context) {
    // 2. Main Admin Content
    final auditLogsAsync = _selectedType == null
        ? ref.watch(recentAuditLogsProvider(limit: 50))
        : ref.watch(auditLogsByTypeProvider(_selectedType!, limit: 50));

    return Scaffold(
      appBar: AppBar(
        title: const Text('admin.monetizationAudit').tr(),
      ),
      body: Column(
        children: [
          AuditTypeFilterBar(
            selectedType: _selectedType,
            onTypeChanged: (type) {
              setState(() {
                _selectedType = type;
              });
            },
          ),
          Expanded(
            child: auditLogsAsync.when(
              data: (logs) {
                if (logs.isEmpty) {
                  return Center(
                    child: Text('admin.noAuditLogs'.tr()),
                  );
                }
                return ListView.builder(
                  itemCount: logs.length,
                  itemBuilder: (context, index) {
                    return AuditLogCard(log: logs[index]);
                  },
                );
              },
              loading: () => const Center(child: CircularProgressIndicator()),
              error: (err, stack) => Center(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Text(
                    'Error: $err\n\nNote: Firestore Rules might be blocking access.',
                    textAlign: TextAlign.center,
                    style: const TextStyle(color: Colors.red),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
