import 'package:flutter_test/flutter_test.dart';
import 'package:mozzy/mozzy_ii/domains/jobs/models/job_post_model.dart';
import 'package:mozzy/mozzy_ii/shared/contracts/mozzy_post_contract.dart';
import 'package:mozzy/mozzy_ii/geo/models/location_parts.dart';

void main() {
  group('JobPostModel Contract Integration', () {
    test('missing fields use fallback defaults', () {
      final json = {
        'id': 'j1',
        'title': 'Test',
        'description': 'Test',
        'companyName': 'Company',
        'ownerId': 'u1',
        'ownerName': 'Owner',
        'category': 'IT',
        'jobType': 'fullTime',
        'workType': 'remote',
        'salaryType': 'monthly',
        'salaryMin': 100,
        'salaryMax': 200,
        'locationParts': {
          'countryCode': 'ID',
          'latitude': 0,
          'longitude': 0,
          'geoHash': 'abc'
        },
        'createdAt': DateTime.now().toIso8601String(),
        'updatedAt': DateTime.now().toIso8601String(),
        'expiresAt': DateTime.now().add(const Duration(days: 30)).toIso8601String(),
      };

      final job = JobPostModel.fromJson(json);

      expect(job.geoScope, GeoScope.neighborhood);
      expect(job.reachMode, ReachMode.localOnly);
      expect(job.trustScore, 0.5);
      expect(job.signalScore, 0.0);
      expect(job.translationState, isEmpty);
      expect(job.discoveryChannels, ['feed', 'map', 'search']);
      expect(job.mapVisibility, isTrue);
    });

    test('implements MozzyPostContract fields correctly', () {
      final job = JobPostModel(
        id: 'j1',
        title: 'Title',
        description: 'Desc',
        companyName: 'Company',
        ownerId: 'u1',
        ownerName: 'Owner',
        category: 'IT',
        jobType: JobType.fullTime,
        workType: WorkType.remote,
        salaryType: SalaryType.monthly,
        salaryMin: 100,
        salaryMax: 200,
        locationParts: const LocationParts(
          countryCode: 'ID',
          latitude: 0,
          longitude: 0,
          geoHash: 'abc',
        ),
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
        expiresAt: DateTime.now().add(const Duration(days: 30)),
      );

      // Cast to verify it implements the contract
      final contract = job as MozzyPostContract;

      expect(contract.id, 'j1');
      expect(contract.userId, 'u1');
      expect(contract.geoScope, GeoScope.neighborhood);
      expect(contract.reachMode, ReachMode.localOnly);
      expect(contract.trustScore, 0.5);
      expect(contract.signalScore, 0.0);
      expect(contract.translationState, isEmpty);
      // geoPath is derived from locationParts
      expect(contract.geoPath, isNotEmpty);
    });
  });
}