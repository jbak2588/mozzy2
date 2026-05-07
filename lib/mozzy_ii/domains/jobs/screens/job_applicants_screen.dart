import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:easy_localization/easy_localization.dart';
import '../models/job_applicant_model.dart';
import '../providers/job_applicant_provider.dart';
import '../providers/job_provider.dart';
import '../widgets/job_applicant_card.dart';

class JobApplicantsScreen extends ConsumerWidget {
  final String jobId;

  const JobApplicantsScreen({
    super.key,
    required this.jobId,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final applicantsAsync = ref.watch(filteredJobApplicantsProvider(jobId));
    final jobAsync = ref.watch(jobDetailProvider(jobId));
    final currentFilter = ref.watch(applicantStatusFilterProvider);

    return Scaffold(
      backgroundColor: Colors.grey.shade50,
      appBar: AppBar(
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('jobs.applicants'.tr()),
            jobAsync.when(
              data: (job) => job != null 
                  ? Text(job.title, style: const TextStyle(fontSize: 12, fontWeight: FontWeight.normal))
                  : const SizedBox.shrink(),
              loading: () => const SizedBox.shrink(),
              error: (err, _) => const SizedBox.shrink(),
            ),
          ],
        ),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(60),
          child: _buildFilterBar(ref, currentFilter),
        ),
      ),
      body: applicantsAsync.when(
        data: (applicants) {
          if (applicants.isEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.people_outline, size: 64, color: Colors.grey.shade400),
                  const SizedBox(height: 16),
                  Text(
                    'jobs.noApplicants'.tr(),
                    style: TextStyle(color: Colors.grey.shade600),
                  ),
                ],
              ),
            );
          }

          return ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: applicants.length,
            itemBuilder: (context, index) => JobApplicantCard(applicant: applicants[index]),
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (err, _) => Center(child: Text('common.error'.tr())),
      ),
    );
  }

  Widget _buildFilterBar(WidgetRef ref, JobApplicantStatus? currentFilter) {
    return SizedBox(
      height: 60,
      child: ListView(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        children: [
          _FilterChip(
            label: 'common.all'.tr(),
            isSelected: currentFilter == null,
            onSelected: () => ref.read(applicantStatusFilterProvider.notifier).set(null),
          ),
          const SizedBox(width: 8),
          _FilterChip(
            label: 'jobs.newApplicant'.tr(),
            isSelected: currentFilter == JobApplicantStatus.newApplicant,
            onSelected: () => ref.read(applicantStatusFilterProvider.notifier).set(JobApplicantStatus.newApplicant),
          ),
          const SizedBox(width: 8),
          _FilterChip(
            label: 'jobs.contacted'.tr(),
            isSelected: currentFilter == JobApplicantStatus.contacted,
            onSelected: () => ref.read(applicantStatusFilterProvider.notifier).set(JobApplicantStatus.contacted),
          ),
          const SizedBox(width: 8),
          _FilterChip(
            label: 'jobs.shortlisted'.tr(),
            isSelected: currentFilter == JobApplicantStatus.shortlisted,
            onSelected: () => ref.read(applicantStatusFilterProvider.notifier).set(JobApplicantStatus.shortlisted),
          ),
          const SizedBox(width: 8),
          _FilterChip(
            label: 'jobs.rejected'.tr(),
            isSelected: currentFilter == JobApplicantStatus.rejected,
            onSelected: () => ref.read(applicantStatusFilterProvider.notifier).set(JobApplicantStatus.rejected),
          ),
          const SizedBox(width: 8),
          _FilterChip(
            label: 'jobs.hired'.tr(),
            isSelected: currentFilter == JobApplicantStatus.hired,
            onSelected: () => ref.read(applicantStatusFilterProvider.notifier).set(JobApplicantStatus.hired),
          ),
        ],
      ),
    );
  }
}

class _FilterChip extends StatelessWidget {
  final String label;
  final bool isSelected;
  final VoidCallback onSelected;

  const _FilterChip({
    required this.label,
    required this.isSelected,
    required this.onSelected,
  });

  @override
  Widget build(BuildContext context) {
    return FilterChip(
      label: Text(label),
      selected: isSelected,
      onSelected: (_) => onSelected(),
      backgroundColor: Colors.white,
      selectedColor: Colors.blue.shade100,
      checkmarkColor: Colors.blue,
      labelStyle: TextStyle(
        color: isSelected ? Colors.blue.shade700 : Colors.black87,
        fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
        side: BorderSide(color: isSelected ? Colors.blue : Colors.grey.shade300),
      ),
    );
  }
}
