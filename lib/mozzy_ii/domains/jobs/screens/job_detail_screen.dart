import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:go_router/go_router.dart';
import '../models/job_post_model.dart';
import '../providers/job_provider.dart';
import '../providers/job_applicant_provider.dart';
import '../../../core/utils/formatters.dart';
import '../../../app/auth/auth_service.dart';

class JobDetailScreen extends ConsumerWidget {
  final String jobId;

  const JobDetailScreen({super.key, required this.jobId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final jobAsync = ref.watch(jobDetailProvider(jobId));
    final currentUserId = ref.watch(authStateProvider).value?.uid;
    final actionState = ref.watch(jobActionControllerProvider);
    final isLoading = actionState.isLoading;

    return Scaffold(
      appBar: AppBar(
        title: Text('jobs.detail'.tr()),
        actions: [
          IconButton(
            icon: const Icon(Icons.report_outlined),
            onPressed: () {
              // TODO: Implement report
            },
          ),
        ],
      ),
      body: jobAsync.when(
        data: (job) {
          if (job == null) {
            return Center(child: Text('marketplace.notFound'.tr()));
          }
          final isOwner = currentUserId == job.ownerId;
          return Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        job.title,
                        style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        job.companyName,
                        style: TextStyle(fontSize: 18, color: Colors.grey[700], fontWeight: FontWeight.w500),
                      ),
                      const SizedBox(height: 16),
                      _buildInfoRow(Icons.money, 'jobs.salary'.tr(), _formatSalary(job)),
                      _buildInfoRow(Icons.work_outline, 'jobs.jobType'.tr(), 'jobs.type.${job.jobType.name}'.tr()),
                      _buildInfoRow(Icons.location_on_outlined, 'jobs.location'.tr(), 
                        '${job.locationParts.idAddress?.kecamatan}, ${job.locationParts.idAddress?.kabupaten}'),
                      _buildInfoRow(Icons.calendar_today_outlined, 'jobs.postedAt'.tr(), 
                        MozzyFormatters.formatDateID(job.createdAt)),
                      const Divider(height: 40),
                      Text(
                        'jobs.description'.tr(),
                        style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 8),
                      Text(job.description, style: const TextStyle(fontSize: 16, height: 1.5)),
                      const SizedBox(height: 24),
                      _buildOwnerInfo(job),
                      const SizedBox(height: 40),
                    ],
                  ),
                ),
              ),
              _buildBottomBar(context, ref, job, isOwner, currentUserId, isLoading),
            ],
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (err, _) => Center(child: Text('common.error'.tr())),
      ),
    );
  }

  Widget _buildInfoRow(IconData icon, String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          Icon(icon, size: 20, color: Colors.grey[600]),
          const SizedBox(width: 8),
          Text('$label: ', style: TextStyle(color: Colors.grey[600])),
          Text(value, style: const TextStyle(fontWeight: FontWeight.w500)),
        ],
      ),
    );
  }

  Widget _buildOwnerInfo(JobPostModel job) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.grey[100],
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          CircleAvatar(
            backgroundImage: job.ownerPhotoUrl != null ? NetworkImage(job.ownerPhotoUrl!) : null,
            child: job.ownerPhotoUrl == null ? const Icon(Icons.person) : null,
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(job.ownerName, style: const TextStyle(fontWeight: FontWeight.bold)),
                Text('Trust Score: ${(job.trustScore * 100).toStringAsFixed(0)}%', style: const TextStyle(fontSize: 12)),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBottomBar(BuildContext context, WidgetRef ref, JobPostModel job, bool isOwner, String? currentUserId, bool isLoading) {
    final myApplicantAsync = ref.watch(myApplicantRecordProvider(job.id));

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [BoxShadow(color: Colors.black.withValues(alpha: 0.1), blurRadius: 4, offset: const Offset(0, -2))],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: !isOwner ? [
          SizedBox(
            width: double.infinity,
            child: myApplicantAsync.when(
              data: (applicant) {
                final hasApplied = applicant != null;
                return ElevatedButton(
                  onPressed: (job.status == 'closed' || isLoading)
                      ? null
                      : () => _handleApply(ref, job),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Theme.of(context).primaryColor,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  ),
                  child: isLoading
                      ? const SizedBox(width: 20, height: 20, child: CircularProgressIndicator(strokeWidth: 2, color: Colors.white))
                      : Text(job.status == 'closed' 
                          ? 'jobs.closed'.tr() 
                          : (hasApplied ? 'jobs.continueChat'.tr() : 'jobs.apply'.tr())),
                );
              },
              loading: () => const SizedBox(height: 54, child: Center(child: CircularProgressIndicator())),
              error: (err, _) => const SizedBox.shrink(),
            ),
          ),
          const SizedBox(height: 12),
          SizedBox(
            width: double.infinity,
            child: OutlinedButton(
              onPressed: (job.status == 'closed' || isLoading)
                  ? null
                  : () => _handleChat(ref, job),
              style: OutlinedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              ),
              child: Text('jobs.chatOwner'.tr()),
            ),
          ),
        ] : [
          if (job.status == 'open') ...[
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: () => context.push('/jobs/${job.id}/applicants'),
                icon: const Icon(Icons.people_outline),
                label: Text('jobs.viewApplicantsCount'.tr(namedArgs: {'count': job.applicantCount.toString()})),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue.shade600,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                ),
              ),
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                Expanded(
                  child: OutlinedButton.icon(
                    onPressed: isLoading ? null : () => _showCloseConfirm(context, ref, job.id),
                    icon: const Icon(Icons.close),
                    label: Text('jobs.close'.tr()),
                    style: OutlinedButton.styleFrom(
                      foregroundColor: Colors.red.shade600,
                      side: BorderSide(color: Colors.red.shade600),
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: OutlinedButton.icon(
                    onPressed: isLoading ? null : () => _showArchiveConfirm(context, ref, job.id),
                    icon: const Icon(Icons.archive_outlined),
                    label: Text('jobs.archive'.tr()),
                    style: OutlinedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                    ),
                  ),
                ),
              ],
            ),
          ] else ...[
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: isLoading ? null : () => ref.read(jobActionControllerProvider.notifier).restoreJob(job.id),
                icon: const Icon(Icons.restore),
                label: Text('jobs.restore'.tr()),
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }

  Future<void> _handleApply(WidgetRef ref, JobPostModel job) async {
    final roomId = await ref.read(jobActionControllerProvider.notifier).applyJob(job);
    if (roomId != null && ref.context.mounted) {
      ref.context.push('/chat/$roomId');
    } else if (ref.context.mounted) {
      final state = ref.read(jobActionControllerProvider);
      if (state.hasError) {
        ScaffoldMessenger.of(ref.context).showSnackBar(
          SnackBar(content: Text(state.error.toString())),
        );
      }
    }
  }

  Future<void> _handleChat(WidgetRef ref, JobPostModel job) async {
    final roomId = await ref.read(jobActionControllerProvider.notifier).applyJob(job);
    if (roomId != null && ref.context.mounted) {
      ref.context.push('/chat/$roomId');
    }
  }

  void _showArchiveConfirm(BuildContext context, WidgetRef ref, String jobId) {
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
            onPressed: () async {
              Navigator.pop(context);
              await ref.read(jobActionControllerProvider.notifier).archiveJob(jobId);
              if (context.mounted) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('jobs.archiveSuccess'.tr())),
                );
              }
            },
            child: Text('jobs.archive'.tr(), style: const TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );
  }

  void _showCloseConfirm(BuildContext context, WidgetRef ref, String jobId) {
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
            onPressed: () async {
              Navigator.pop(context);
              await ref.read(jobActionControllerProvider.notifier).closeJob(jobId);
              if (context.mounted) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('jobs.closeSuccess'.tr())),
                );
              }
            },
            child: Text('jobs.close'.tr(), style: const TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );
  }

  String _formatSalary(JobPostModel job) {
    if (job.salaryType == SalaryType.negotiable) {
      return 'jobs.salaryType.negotiable'.tr();
    }
    final min = MozzyFormatters.formatIDR(job.salaryMin);
    final max = MozzyFormatters.formatIDR(job.salaryMax);
    final type = 'jobs.salaryType.${job.salaryType.name}'.tr();
    return '$min - $max ($type)';
  }
}
