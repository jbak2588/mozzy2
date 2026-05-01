// ============================================================================
// Mozzy DocHeader
// Module        : Marketplace Domain
// File          : lib/mozzy_ii/domains/marketplace/screens/admin_audit_log_screen.dart
// Purpose       : 관리자 작업 감사 로그를 확인하기 위한 화면.
// ============================================================================

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:go_router/go_router.dart';
import '../providers/marketplace_provider.dart';
import '../models/admin_audit_log_model.dart';
import '../models/admin_role_model.dart';

class AdminAuditLogScreen extends ConsumerWidget {
  const AdminAuditLogScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final roleAsync = ref.watch(marketplaceAdminRoleAsyncProvider);

    return roleAsync.when(
      data: (role) {
        if (!role.canViewReviewQueue) {
          return _buildAccessDenied(context);
        }
        return _buildAuditLogView(context, ref);
      },
      loading: () => Scaffold(
        appBar: AppBar(title: Text('marketplace.adminAuditLog'.tr())),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const CircularProgressIndicator(),
              const SizedBox(height: 16),
              Text('marketplace.adminRoleLoading'.tr()),
            ],
          ),
        ),
      ),
      error: (err, stack) => Scaffold(
        appBar: AppBar(title: Text('marketplace.adminAuditLog'.tr())),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.error_outline, size: 48, color: Colors.red),
              const SizedBox(height: 16),
              Text('marketplace.adminRoleLoadFailed'.tr()),
              const SizedBox(height: 8),
              ElevatedButton(
                onPressed: () =>
                    ref.invalidate(marketplaceAdminRoleAsyncProvider),
                child: Text('common.retry'.tr()),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildAccessDenied(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('marketplace.adminAuditLog'.tr())),
      body: Center(
        key: const Key('adminAuditLogAccessDenied'),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.lock_outline, size: 64, color: Colors.red),
            const SizedBox(height: 16),
            Text(
              'marketplace.adminAccessDenied'.tr(),
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text('marketplace.adminAccessDeniedDesc'.tr()),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: () => context.pop(),
              child: Text('common.back'.tr()),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAuditLogView(BuildContext context, WidgetRef ref) {
    final logsAsync = ref.watch(recentAdminAuditLogsProvider);

    return Scaffold(
      key: const Key('adminAuditLogScreen'),
      appBar: AppBar(
        title: Text('marketplace.adminAuditLog'.tr()),
        actions: [
          IconButton(
            onPressed: () => ref.invalidate(recentAdminAuditLogsProvider),
            icon: const Icon(Icons.refresh),
          ),
        ],
      ),
      body: logsAsync.when(
        data: (logs) {
          if (logs.isEmpty) {
            return Center(
              key: const Key('adminAuditLogEmptyState'),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.history, size: 64, color: Colors.grey),
                  const SizedBox(height: 16),
                  Text('marketplace.noAuditLogs'.tr()),
                ],
              ),
            );
          }

          return ListView.builder(
            key: const Key('adminAuditLogList'),
            itemCount: logs.length,
            padding: const EdgeInsets.all(16),
            itemBuilder: (context, index) {
              final log = logs[index];
              return _buildAuditLogCard(log);
            },
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (err, stack) => Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.error_outline, size: 48, color: Colors.red),
              const SizedBox(height: 16),
              Text('marketplace.auditLogLoadFailed'.tr()),
              const SizedBox(height: 8),
              ElevatedButton(
                onPressed: () => ref.invalidate(recentAdminAuditLogsProvider),
                child: Text('common.retry'.tr()),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildAuditLogCard(AdminAuditLogModel log) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _buildActionChip(log.action),
                Text(
                  DateFormat(
                    'yyyy-MM-dd HH:mm',
                  ).format(log.createdAt.toLocal()),
                  style: const TextStyle(fontSize: 12, color: Colors.grey),
                ),
              ],
            ),
            const SizedBox(height: 12),
            _buildDetailRow('marketplace.auditProduct'.tr(), log.productId),
            _buildDetailRow('marketplace.auditQueueItem'.tr(), log.queueItemId),
            _buildDetailRow(
              'marketplace.auditReviewerRole'.tr(),
              log.reviewerRole,
            ),
            _buildDetailRow(
              'marketplace.auditDecision'.tr(),
              log.decision,
              isHighlight: true,
            ),
            if (log.noteSummary != null && log.noteSummary!.isNotEmpty)
              _buildDetailRow('marketplace.auditNote'.tr(), log.noteSummary!),
          ],
        ),
      ),
    );
  }

  Widget _buildActionChip(String action) {
    Color color;
    String label;

    switch (action) {
      case 'approve':
        color = Colors.green;
        label = 'marketplace.auditActionApprove'.tr();
        break;
      case 'reject':
        color = Colors.red;
        label = 'marketplace.auditActionReject'.tr();
        break;
      case 'dismiss':
        color = Colors.orange;
        label = 'marketplace.auditActionDismiss'.tr();
        break;
      default:
        color = Colors.grey;
        label = action;
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(4),
        border: Border.all(color: color),
      ),
      child: Text(
        label,
        style: TextStyle(
          color: color,
          fontSize: 12,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget _buildDetailRow(
    String label,
    String value, {
    bool isHighlight = false,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 100,
            child: Text(
              '$label:',
              style: const TextStyle(fontSize: 13, color: Colors.grey),
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: TextStyle(
                fontSize: 13,
                fontWeight: isHighlight ? FontWeight.bold : FontWeight.normal,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
