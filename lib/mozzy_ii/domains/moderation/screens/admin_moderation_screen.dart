import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:easy_localization/easy_localization.dart';
import '../providers/moderation_providers.dart';
import '../models/report_model.dart';
import '../../marketplace/screens/admin_guard_screen.dart'; // Assume we reuse marketplace admin guard for now, or check claims

class AdminModerationScreen extends ConsumerWidget {
  const AdminModerationScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // For now, wrapping inside the screen, but better to use route guard.
    // In P6-S03 we reuse MarketplaceAdminGuardScreen to just ensure admin access.
    return MarketplaceAdminGuardScreen(
      child: Scaffold(
        appBar: AppBar(
          title: Text('moderation.adminTitle'.tr()),
        ),
        body: const _ModerationList(),
      ),
    );
  }
}

class _ModerationList extends ConsumerWidget {
  const _ModerationList();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final reportsAsync = ref.watch(pendingReportsProvider);

    return reportsAsync.when(
      data: (reports) {
        if (reports.isEmpty) {
          return const Center(child: Text('No pending reports.'));
        }
        return ListView.builder(
          itemCount: reports.length,
          itemBuilder: (context, index) {
            final report = reports[index];
            return _ReportCard(report: report);
          },
        );
      },
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (e, st) => Center(child: Text('Error: $e')),
    );
  }
}

class _ReportCard extends ConsumerWidget {
  final ReportModel report;

  const _ReportCard({required this.report});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  report.targetType.name.toUpperCase(),
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                Text(
                  DateFormat.yMMMd().format(report.createdAt),
                  style: const TextStyle(color: Colors.grey, fontSize: 12),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Text('Target ID: ${report.targetId}'),
            Text('Reason: ${report.reason.name}'),
            if (report.description?.isNotEmpty == true)
              Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: Text('Note: ${report.description}'),
              ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton(
                  onPressed: () => _handleDismiss(context, ref),
                  child: Text('moderation.dismissReport'.tr()),
                ),
                const SizedBox(width: 8),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
                  onPressed: () => _handleHide(context, ref),
                  child: Text('moderation.hideContent'.tr(), style: const TextStyle(color: Colors.white)),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _handleDismiss(BuildContext context, WidgetRef ref) async {
    try {
      await ref.read(moderationServiceProvider).dismissReport(reportId: report.id);
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Dismissed')));
      }
    } catch (e) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Error: $e')));
      }
    }
  }

  Future<void> _handleHide(BuildContext context, WidgetRef ref) async {
    try {
      await ref.read(moderationServiceProvider).hideContent(
        targetType: report.targetType,
        targetId: report.targetId,
        reason: 'Hidden by admin due to report: ${report.id}',
      );
      await ref.read(moderationServiceProvider).actionTakenReport(reportId: report.id);
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Hidden')));
      }
    } catch (e) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Error: $e')));
      }
    }
  }
}
