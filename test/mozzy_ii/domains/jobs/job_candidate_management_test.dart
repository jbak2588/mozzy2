import 'package:flutter_test/flutter_test.dart';
import 'package:mozzy/mozzy_ii/domains/jobs/models/job_applicant_model.dart';

void main() {
  group('Job Candidate Management Logic', () {
    test('JobApplicantStatus enum should have correct names', () {
      expect(JobApplicantStatus.newApplicant.name, 'newApplicant');
      expect(JobApplicantStatus.hired.name, 'hired');
    });

    test('JobApplicantModel should correctly handle status from string', () {
      final json = {
        'id': 'app1',
        'jobId': 'job1',
        'applicantId': 'user1',
        'applicantName': 'Test User',
        'status': 'shortlisted',
        'appliedAt': DateTime.now().toIso8601String(),
        'updatedAt': DateTime.now().toIso8601String(),
      };
      final model = JobApplicantModel.fromJson(json);
      expect(model.status, JobApplicantStatus.shortlisted);
    });
  });
}
