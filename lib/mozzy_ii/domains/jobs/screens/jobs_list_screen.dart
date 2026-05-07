import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:go_router/go_router.dart';
import '../providers/job_provider.dart';
import '../providers/jobs_location_provider.dart';
import '../widgets/job_card.dart';
import '../models/job_post_model.dart';

class JobsListScreen extends ConsumerWidget {
  const JobsListScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final locationAsync = ref.watch(effectiveJobsLocationProvider);
    final filters = ref.watch(jobFiltersProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text('jobs.title'.tr()),
        actions: [
          IconButton(
            icon: const Icon(Icons.assignment_ind_outlined),
            tooltip: 'jobs.myJobs'.tr(),
            onPressed: () => context.push('/jobs/my'),
          ),
        ],
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(100),
          child: Column(
            children: [
              _buildLocationHeader(locationAsync),
              _buildFilterBar(ref, filters),
            ],
          ),
        ),
      ),
      body: locationAsync.when(
        data: (loc) {
          final kecamatan = loc.idAddress?.kecamatan ?? 'Kebayoran Baru';
          final jobsAsync = ref.watch(nearbyJobsProvider(kecamatan));

          return jobsAsync.when(
            data: (jobs) {
              if (jobs.isEmpty) {
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(Icons.work_off_outlined, size: 64, color: Colors.grey),
                      const SizedBox(height: 16),
                      Text('jobs.empty'.tr()),
                    ],
                  ),
                );
              }
              return ListView.builder(
                padding: const EdgeInsets.only(top: 8, bottom: 80),
                itemCount: jobs.length,
                itemBuilder: (context, index) => JobCard(job: jobs[index]),
              );
            },
            loading: () => const Center(child: CircularProgressIndicator()),
            error: (err, _) => Center(child: Text('common.error'.tr())),
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (err, _) => Center(child: Text('common.error'.tr())),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => context.push('/jobs/create'),
        icon: const Icon(Icons.add),
        label: Text('jobs.create'.tr()),
      ),
    );
  }

  Widget _buildLocationHeader(AsyncValue<dynamic> locationAsync) {
    return locationAsync.when(
      data: (loc) => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: Row(
          children: [
            const Icon(Icons.location_on, size: 16, color: Colors.red),
            const SizedBox(width: 4),
            Text(
              '${loc.idAddress?.kecamatan}, ${loc.idAddress?.kabupaten}',
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
      loading: () => const SizedBox(height: 32),
      error: (e, s) => const SizedBox(height: 32),
    );
  }

  Widget _buildFilterBar(WidgetRef ref, JobFiltersState filters) {
    final types = [null, ...JobType.values];

    return SizedBox(
      height: 50,
      child: ListView.builder(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        scrollDirection: Axis.horizontal,
        itemCount: types.length,
        itemBuilder: (context, index) {
          final type = types[index];
          final isSelected = filters.jobType == type;
          final label = type == null ? 'marketplace.all'.tr() : 'jobs.type.${type.name}'.tr();

          return Padding(
            padding: const EdgeInsets.only(right: 8),
            child: ChoiceChip(
              label: Text(label),
              selected: isSelected,
              onSelected: (selected) {
                if (selected) {
                  ref.read(jobFiltersProvider.notifier).setJobType(type);
                }
              },
            ),
          );
        },
      ),
    );
  }
}
