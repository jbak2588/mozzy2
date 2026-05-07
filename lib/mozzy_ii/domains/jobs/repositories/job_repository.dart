import '../models/job_post_model.dart';
import '../models/job_applicant_model.dart';

abstract class JobRepository {
  Stream<List<JobPostModel>> watchNearbyJobs({
    required String kecamatan,
    String? category,
    JobType? jobType,
  });

  Future<List<JobPostModel>> fetchJobsByKecamatan({
    required String kecamatan,
    String? category,
    JobType? jobType,
  });

  Future<JobPostModel?> fetchJobById(String jobId);
  Stream<JobPostModel?> watchJobById(String jobId);
  Stream<List<JobPostModel>> watchOwnerJobs(String ownerId, {JobPostStatus? status});

  Future<String> createJob(JobPostModel job);

  Future<void> updateJob(String jobId, Map<String, dynamic> updates);

  Future<void> archiveJob(String jobId);

  Future<void> closeJob(String jobId);

  Future<void> restoreJob(String jobId);

  Future<void> incrementApplicantCountOnce(String jobId, String applicantId);

  Future<void> incrementViewCount(String jobId);

  Future<void> incrementChatCount(String jobId);

  // Applicant Management
  Stream<List<JobApplicantModel>> watchApplicants(String jobId, {JobApplicantStatus? status});
  Future<JobApplicantModel?> fetchApplicant(String jobId, String applicantId);
  Future<void> updateApplicantStatus(String jobId, String applicantId, JobApplicantStatus status);
  Future<void> ensureApplicantRecord({
    required JobPostModel job,
    required String applicantId,
    required String applicantName,
    required String chatRoomId,
    String? applicantPhotoUrl,
  });
}
