import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../models/job_applicant_model.dart';
import 'job_provider.dart';
import '../../../app/auth/auth_service.dart';

part 'job_applicant_provider.g.dart';

@riverpod
Stream<List<JobApplicantModel>> jobApplicants(Ref ref, String jobId) {
  final repo = ref.watch(jobRepositoryProvider);
  return repo.watchApplicants(jobId);
}

@riverpod
class ApplicantStatusFilter extends _$ApplicantStatusFilter {
  @override
  JobApplicantStatus? build() => null;

  void set(JobApplicantStatus? status) => state = status;
}

@riverpod
AsyncValue<List<JobApplicantModel>> filteredJobApplicants(Ref ref, String jobId) {
  final applicantsAsync = ref.watch(jobApplicantsProvider(jobId));
  final filter = ref.watch(applicantStatusFilterProvider);

  return applicantsAsync.whenData((applicants) {
    if (filter == null) return applicants;
    return applicants.where((a) => a.status == filter).toList();
  });
}

@riverpod
Future<JobApplicantModel?> myApplicantRecord(Ref ref, String jobId) {
  final user = ref.watch(authStateProvider).value;
  if (user == null) return Future.value(null);

  final repo = ref.watch(jobRepositoryProvider);
  return repo.fetchApplicant(jobId, user.uid);
}

@riverpod
class JobApplicantActionController extends _$JobApplicantActionController {
  @override
  AsyncValue<void> build() => const AsyncValue.data(null);

  Future<void> updateStatus(String jobId, String applicantId, JobApplicantStatus status) async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      await ref.read(jobRepositoryProvider).updateApplicantStatus(jobId, applicantId, status);
    });
  }
}
