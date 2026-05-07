import 'package:flutter_test/flutter_test.dart';
import 'package:mozzy/mozzy_ii/domains/jobs/models/job_applicant_model.dart';

void main() {
  group('JobApplicantModel', () {
    final now = DateTime.now();
    final mockJson = {
      'id': 'app1',
      'jobId': 'job1',
      'applicantId': 'user1',
      'applicantName': 'John Doe',
      'status': 'shortlisted',
      'appliedAt': now.toIso8601String(),
      'updatedAt': now.toIso8601String(),
      'source': 'job_detail',
      'countryCode': 'ID',
    };

    test('fromJson creates model correctly', () {
      final model = JobApplicantModel.fromJson(mockJson);
      expect(model.id, 'app1');
      expect(model.status, JobApplicantStatus.shortlisted);
      expect(model.applicantName, 'John Doe');
    });

    test('toJson returns correct map', () {
      final model = JobApplicantModel(
        id: 'app1',
        jobId: 'job1',
        applicantId: 'user1',
        applicantName: 'John Doe',
        status: JobApplicantStatus.hired,
        appliedAt: now,
        updatedAt: now,
      );
      final json = model.toJson();
      expect(json['status'], 'hired');
      expect(json['applicantName'], 'John Doe');
    });
  });
}
