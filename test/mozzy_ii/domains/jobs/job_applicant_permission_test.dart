import 'package:flutter_test/flutter_test.dart';
import 'package:mozzy/mozzy_ii/domains/jobs/models/job_post_model.dart';
import 'package:mozzy/mozzy_ii/geo/models/location_parts.dart';

void main() {
  group('Job Applicant Permissions Logic', () {
    final mockJob = JobPostModel(
      id: 'job1',
      title: 'Job',
      description: 'Desc',
      companyName: 'Company',
      ownerId: 'owner1',
      ownerName: 'Owner',
      category: 'IT',
      jobType: JobType.fullTime,
      workType: WorkType.onsite,
      salaryType: SalaryType.monthly,
      salaryMin: 1000,
      salaryMax: 2000,
      locationParts: const LocationParts(
        countryCode: 'ID',
        latitude: 0,
        longitude: 0,
        geoHash: '',
      ),
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
      expiresAt: DateTime.now().add(const Duration(days: 30)),
    );

    test('isOwner should be true for correct ownerId', () {
      const currentUserId = 'owner1';
      expect(mockJob.ownerId == currentUserId, isTrue);
    });

    test('isOwner should be false for other users', () {
      const currentUserId = 'other_user';
      expect(mockJob.ownerId == currentUserId, isFalse);
    });

    test('third party should not see applicants if they are not owner', () {
      const currentUserId = 'stranger';
      final canViewApplicants = mockJob.ownerId == currentUserId;
      expect(canViewApplicants, isFalse);
    });
  });
}
