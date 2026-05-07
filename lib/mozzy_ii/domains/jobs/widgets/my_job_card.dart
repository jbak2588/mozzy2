import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:go_router/go_router.dart';
import '../models/job_post_model.dart';
import '../providers/job_provider.dart';

class MyJobCard extends ConsumerWidget {
  final JobPostModel job;

  const MyJobCard({super.key, required this.job});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final statusColor = _getStatusColor(job.status);
    final statusLabel = 'jobs.status.${job.status}'.tr();

    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: () => context.push('/jobs/${job.id}'),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Text(
                      job.title,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: statusColor.withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: statusColor.withValues(alpha: 0.5)),
                    ),
                    child: Text(
                      statusLabel,
                      style: TextStyle(
                        color: statusColor,
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 4),
              Text(
                job.companyName,
                style: TextStyle(color: Colors.grey.shade600, fontSize: 14),
              ),
              const SizedBox(height: 12),
              Row(
                children: [
                  _buildStat(Icons.people_outline, 'jobs.applicantCount'.tr(namedArgs: {'count': job.applicantCount.toString()})),
                  const SizedBox(width: 16),
                  _buildStat(Icons.chat_bubble_outline, 'jobs.chatCount'.tr(namedArgs: {'count': job.chatCount.toString()})),
                ],
              ),
              const Divider(height: 24),
              Row(
                children: [
                  ElevatedButton.icon(
                    onPressed: () => context.push('/jobs/${job.id}/applicants'),
                    icon: const Icon(Icons.people_outline, size: 18),
                    label: Text('jobs.viewApplicants'.tr()),
                    style: ElevatedButton.styleFrom(
                      elevation: 0,
                      backgroundColor: Colors.blue.shade600,
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                    ),
                  ),
                  const Spacer(),
                  if (job.status == 'open') ...[
                    PopupMenuButton<String>(
                      icon: const Icon(Icons.more_vert),
                      onSelected: (value) {
                        if (value == 'close') _showCloseConfirm(context, ref);
                        if (value == 'archive') _showArchiveConfirm(context, ref);
                      },
                      itemBuilder: (context) => [
                        PopupMenuItem(
                          value: 'close',
                          child: Text('jobs.close'.tr(), style: const TextStyle(color: Colors.red)),
                        ),
                        PopupMenuItem(
                          value: 'archive',
                          child: Text('jobs.archive'.tr()),
                        ),
                      ],
                    ),
                  ] else if (job.status == 'closed' || job.status == 'archived') ...[
                    TextButton.icon(
                      onPressed: () => ref.read(jobActionControllerProvider.notifier).restoreJob(job.id),
                      icon: const Icon(Icons.restore, size: 18),
                      label: Text('jobs.restore'.tr()),
                    ),
                  ],
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildStat(IconData icon, String label) {
    return Row(
      children: [
        Icon(icon, size: 16, color: Colors.grey.shade600),
        const SizedBox(width: 4),
        Text(
          label,
          style: TextStyle(color: Colors.grey.shade600, fontSize: 13),
        ),
      ],
    );
  }

  Color _getStatusColor(String status) {
    switch (status) {
      case 'open':
        return Colors.green;
      case 'closed':
        return Colors.red;
      case 'archived':
        return Colors.grey;
      case 'expired':
        return Colors.orange;
      default:
        return Colors.blue;
    }
  }

  void _showCloseConfirm(BuildContext context, WidgetRef ref) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('jobs.closeConfirmTitle'.tr()),
        content: Text('jobs.closeConfirmMessage'.tr()),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('common.cancel'.tr()),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              ref.read(jobActionControllerProvider.notifier).closeJob(job.id);
            },
            child: Text('jobs.close'.tr(), style: const TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );
  }

  void _showArchiveConfirm(BuildContext context, WidgetRef ref) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('jobs.archiveConfirmTitle'.tr()),
        content: Text('jobs.archiveConfirmMessage'.tr()),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('common.cancel'.tr()),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              ref.read(jobActionControllerProvider.notifier).archiveJob(job.id);
            },
            child: Text('jobs.archive'.tr(), style: const TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );
  }
}
