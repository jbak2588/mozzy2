import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:easy_localization/easy_localization.dart';
import '../providers/job_provider.dart';
import '../models/job_post_model.dart';
import '../widgets/my_job_card.dart';

class MyJobsScreen extends ConsumerWidget {
  const MyJobsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final myJobsAsync = ref.watch(myJobsProvider);
    final currentFilter = ref.watch(myJobsFilterProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text('jobs.myJobs'.tr()),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(48),
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              children: [
                _FilterChip(
                  label: 'common.all'.tr(),
                  isSelected: currentFilter == null,
                  onSelected: () => ref.read(myJobsFilterProvider.notifier).setStatus(null),
                ),
                const SizedBox(width: 8),
                _FilterChip(
                  label: 'jobs.openJobs'.tr(),
                  isSelected: currentFilter == JobPostStatus.open,
                  onSelected: () => ref.read(myJobsFilterProvider.notifier).setStatus(JobPostStatus.open),
                ),
                const SizedBox(width: 8),
                _FilterChip(
                  label: 'jobs.closedJobs'.tr(),
                  isSelected: currentFilter == JobPostStatus.closed,
                  onSelected: () => ref.read(myJobsFilterProvider.notifier).setStatus(JobPostStatus.closed),
                ),
                const SizedBox(width: 8),
                _FilterChip(
                  label: 'jobs.archivedJobs'.tr(),
                  isSelected: currentFilter == JobPostStatus.archived,
                  onSelected: () => ref.read(myJobsFilterProvider.notifier).setStatus(JobPostStatus.archived),
                ),
              ],
            ),
          ),
        ),
      ),
      body: myJobsAsync.when(
        data: (jobs) {
          if (jobs.isEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.work_outline, size: 64, color: Colors.grey.shade400),
                  const SizedBox(height: 16),
                  Text(
                    'jobs.myJobsEmpty'.tr(),
                    style: TextStyle(color: Colors.grey.shade600, fontSize: 16),
                  ),
                ],
              ),
            );
          }
          return ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: jobs.length,
            itemBuilder: (context, index) => MyJobCard(job: jobs[index]),
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, stack) => Center(child: Text('Error: $e')),
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
    return ChoiceChip(
      label: Text(label),
      selected: isSelected,
      onSelected: (_) => onSelected(),
      selectedColor: Theme.of(context).primaryColor.withValues(alpha: 0.2),
      labelStyle: TextStyle(
        color: isSelected ? Theme.of(context).primaryColor : Colors.black87,
        fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
      ),
    );
  }
}
