import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import '../models/job_post_model.dart';
import '../../../core/utils/formatters.dart';
import 'package:go_router/go_router.dart';

class JobCard extends StatelessWidget {
  final JobPostModel job;

  const JobCard({super.key, required this.job});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: InkWell(
        onTap: () => context.push('/jobs/${job.id}'),
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Row(
                      children: [
                        if (job.isBoostActive) ...[
                          _buildBoostBadge(),
                          const SizedBox(width: 8),
                        ],
                        Expanded(
                          child: Text(
                            job.title,
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                  ),
                  _buildStatusBadge(),
                ],
              ),
              const SizedBox(height: 4),
              Text(
                job.companyName,
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.grey[700],
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: 12),
              Row(
                children: [
                  const Icon(Icons.money, size: 16, color: Colors.green),
                  const SizedBox(width: 4),
                  Text(
                    _formatSalary(),
                    style: const TextStyle(
                      color: Colors.green,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Wrap(
                spacing: 8,
                children: [
                  _buildChip(
                    'jobs.type.${job.jobType.name}'.tr(),
                    Colors.blue[100]!,
                    Colors.blue[800]!,
                  ),
                  _buildChip(
                    'jobs.workTypes.${job.workType.name}'.tr(),
                    Colors.orange[100]!,
                    Colors.orange[800]!,
                  ),
                ],
              ),
              const Divider(height: 24),
              Row(
                children: [
                  const Icon(Icons.location_on, size: 14, color: Colors.grey),
                  const SizedBox(width: 4),
                  Expanded(
                    child: Text(
                      '${job.locationParts.idAddress?.kecamatan}, ${job.locationParts.idAddress?.kabupaten}',
                      style: const TextStyle(fontSize: 12, color: Colors.grey),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  Text(
                    _formatDate(job.createdAt),
                    style: const TextStyle(fontSize: 11, color: Colors.grey),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildStatusBadge() {
    if (job.status == 'closed' || job.isClosed) {
      return Container(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
        decoration: BoxDecoration(
          color: Colors.red[100],
          borderRadius: BorderRadius.circular(4),
        ),
        child: Text(
          'jobs.status.closed'.tr(),
          style: TextStyle(color: Colors.red[800], fontSize: 10, fontWeight: FontWeight.bold),
        ),
      );
    }
    return const SizedBox.shrink();
  }

  Widget _buildBoostBadge() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
      decoration: BoxDecoration(
        color: Colors.purple[100],
        borderRadius: BorderRadius.circular(4),
        border: Border.all(color: Colors.purple[300]!),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.bolt, size: 10, color: Colors.purple[800]),
          const SizedBox(width: 2),
          Text(
            'monetization.boosted'.tr(),
            style: TextStyle(
              color: Colors.purple[800],
              fontSize: 10,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildChip(String label, Color bgColor, Color textColor) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(6),
      ),
      child: Text(
        label,
        style: TextStyle(color: textColor, fontSize: 12, fontWeight: FontWeight.w500),
      ),
    );
  }

  String _formatSalary() {
    if (job.salaryType == SalaryType.negotiable) {
      return 'jobs.salaryType.negotiable'.tr();
    }
    final min = MozzyFormatters.formatIDR(job.salaryMin);
    final max = MozzyFormatters.formatIDR(job.salaryMax);
    final type = 'jobs.salaryType.${job.salaryType.name}'.tr();
    return '$min - $max ($type)';
  }

  String _formatDate(DateTime date) {
    return MozzyFormatters.formatDateID(date);
  }
}
