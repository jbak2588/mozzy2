import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import '../models/job_applicant_model.dart';

class ApplicantStatusChip extends StatelessWidget {
  final JobApplicantStatus status;

  const ApplicantStatusChip({
    super.key,
    required this.status,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: _getColor(status).withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: _getColor(status).withValues(alpha: 0.2)),
      ),
      child: Text(
        'jobs.${_getLabel(status)}'.tr(),
        style: TextStyle(
          color: _getColor(status),
          fontSize: 10,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Color _getColor(JobApplicantStatus status) {
    switch (status) {
      case JobApplicantStatus.newApplicant:
        return Colors.blue;
      case JobApplicantStatus.contacted:
        return Colors.orange;
      case JobApplicantStatus.shortlisted:
        return Colors.purple;
      case JobApplicantStatus.rejected:
        return Colors.red;
      case JobApplicantStatus.hired:
        return Colors.green;
    }
  }

  String _getLabel(JobApplicantStatus status) {
    switch (status) {
      case JobApplicantStatus.newApplicant:
        return 'newApplicant';
      case JobApplicantStatus.contacted:
        return 'contacted';
      case JobApplicantStatus.shortlisted:
        return 'shortlisted';
      case JobApplicantStatus.rejected:
        return 'rejected';
      case JobApplicantStatus.hired:
        return 'hired';
    }
  }
}
