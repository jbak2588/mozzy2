import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:go_router/go_router.dart';
import '../models/job_applicant_model.dart';
import '../providers/job_applicant_provider.dart';
import 'applicant_status_chip.dart';

class JobApplicantCard extends ConsumerWidget {
  final JobApplicantModel applicant;

  const JobApplicantCard({
    super.key,
    required this.applicant,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      elevation: 0,
      color: Colors.white,
      child: InkWell(
        onTap: () => _showStatusDialog(context, ref),
        borderRadius: BorderRadius.circular(16),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CircleAvatar(
                    radius: 24,
                    backgroundImage: applicant.applicantPhotoUrl != null 
                        ? NetworkImage(applicant.applicantPhotoUrl!) 
                        : null,
                    child: applicant.applicantPhotoUrl == null 
                        ? const Icon(Icons.person) 
                        : null,
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              applicant.applicantName,
                              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                            ),
                            ApplicantStatusChip(status: applicant.status),
                          ],
                        ),
                        const SizedBox(height: 4),
                        Text(
                          DateFormat('dd MMM yyyy, HH:mm').format(applicant.appliedAt),
                          style: TextStyle(fontSize: 12, color: Colors.grey.shade600),
                        ),
                        if (applicant.messagePreview != null) ...[
                          const SizedBox(height: 8),
                          Text(
                            applicant.messagePreview!,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(fontSize: 13, color: Colors.grey.shade800),
                          ),
                        ],
                      ],
                    ),
                  ),
                ],
              ),
              const Divider(height: 24),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton.icon(
                    onPressed: () => _showStatusDialog(context, ref),
                    icon: const Icon(Icons.edit_outlined, size: 18),
                    label: Text('jobs.applicantStatus'.tr()),
                  ),
                  const SizedBox(width: 8),
                  ElevatedButton.icon(
                    onPressed: applicant.chatRoomId != null 
                        ? () => context.push('/chat/${applicant.chatRoomId}') 
                        : null,
                    icon: const Icon(Icons.chat_bubble_outline, size: 18),
                    label: Text('common.chat'.tr()),
                    style: ElevatedButton.styleFrom(
                      elevation: 0,
                      backgroundColor: Colors.blue.shade600,
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showStatusDialog(BuildContext context, WidgetRef ref) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) => Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const SizedBox(height: 12),
          Container(
            width: 40,
            height: 4,
            decoration: BoxDecoration(
              color: Colors.grey.shade300,
              borderRadius: BorderRadius.circular(2),
            ),
          ),
          const SizedBox(height: 16),
          Text(
            'jobs.applicantStatus'.tr(),
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
          ),
          const SizedBox(height: 8),
          _buildStatusTile(context, ref, JobApplicantStatus.newApplicant),
          _buildStatusTile(context, ref, JobApplicantStatus.contacted),
          _buildStatusTile(context, ref, JobApplicantStatus.shortlisted),
          _buildStatusTile(context, ref, JobApplicantStatus.rejected),
          _buildStatusTile(context, ref, JobApplicantStatus.hired),
          const SizedBox(height: 24),
        ],
      ),
    );
  }

  Widget _buildStatusTile(BuildContext context, WidgetRef ref, JobApplicantStatus status) {
    final isSelected = applicant.status == status;
    return ListTile(
      leading: ApplicantStatusChip(status: status),
      title: Text('jobs.mark${status.name[0].toUpperCase()}${status.name.substring(1)}'.tr()),
      trailing: isSelected ? const Icon(Icons.check, color: Colors.blue) : null,
      onTap: () async {
        Navigator.pop(context);
        await ref.read(jobApplicantActionControllerProvider.notifier).updateStatus(
          applicant.jobId,
          applicant.applicantId,
          status,
        );
      },
    );
  }
}
