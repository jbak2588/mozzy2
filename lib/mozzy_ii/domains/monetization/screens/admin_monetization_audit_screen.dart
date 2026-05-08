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
        final isAdminEnabled = const bool.fromEnvironment('ENABLE_ADMIN_SCREENS',
                defaultValue: false) ||
            kEnableLocalAdminScreens ||
            claims.isAdmin;

        if (!isAdminEnabled) {
          return Scaffold(
            appBar: AppBar(title: const Text('admin.monetizationAudit').tr()),
            body: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.lock_outline, size: 64, color: Colors.grey),
                  const SizedBox(height: 16),
                  Text(
                    'admin.accessDenied'.tr(),
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  const SizedBox(height: 8),
                  const Text('admin.permissionDenied').tr(),
                  const SizedBox(height: 8),
                  const Text('admin.permissionDeniedDetail',
                      textAlign: TextAlign.center).tr(),
                ],
              ),
            ),
          );
        }

        return _buildAuditContent(context);
      },
    );
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
