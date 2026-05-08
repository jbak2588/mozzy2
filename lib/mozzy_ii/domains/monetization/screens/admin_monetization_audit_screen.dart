import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:easy_localization/easy_localization.dart';
import '../providers/monetization_audit_provider.dart';
import '../widgets/audit_log_card.dart';
import '../widgets/audit_type_filter_bar.dart';

/// Temporary admin guard.
/// In production, this should be controlled by user custom claims / roles.
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
    // 1. Admin Guard Check
    final isAdminEnabled = const bool.fromEnvironment('ENABLE_ADMIN_SCREENS',
            defaultValue: false) ||
        kEnableLocalAdminScreens;

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
              Text('admin.adminOnly'.tr()),
            ],
          ),
        ),
      );
    }

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
