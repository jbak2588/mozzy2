import 'package:flutter_test/flutter_test.dart';
import 'package:mozzy/mozzy_ii/domains/jobs/models/job_post_model.dart';
import 'package:mozzy/mozzy_ii/geo/models/location_parts.dart';

void main() {
  group('JobPostModel Boost Logic', () {
    final now = DateTime.now();
    final future = now.add(const Duration(days: 1));
    final past = now.subtract(const Duration(days: 1));

    final baseJob = JobPostModel(
      id: 'job1',
      title: 'Software Engineer',
      companyName: 'Mozzy',
      description: 'Test job',
      ownerId: 'owner1',
      ownerName: 'John Doe',
      category: 'IT',
      jobType: JobType.fullTime,
      workType: WorkType.onsite,
      salaryType: SalaryType.monthly,
      salaryMin: 5000000,
      salaryMax: 10000000,
      locationParts: const LocationParts(
        countryCode: 'ID',
        latitude: 0.0,
        longitude: 0.0,
        geoHash: 'abc',
      ),
      createdAt: now,
      updatedAt: now,
      expiresAt: future,
    );

    test('isBoostActive should be true when status is active and until is in future', () {
      final boostedJob = baseJob.copyWith(
        boostStatus: 'active',
        boostActiveUntil: future,
      );
      expect(boostedJob.isBoostActive, isTrue);
    });

    test('isBoostActive should be false when status is none', () {
      final boostedJob = baseJob.copyWith(
        boostStatus: 'none',
        boostActiveUntil: future,
      );
      expect(boostedJob.isBoostActive, isFalse);
    });

    test('isBoostActive should be false when until is in past', () {
      final boostedJob = baseJob.copyWith(
        boostStatus: 'active',
        boostActiveUntil: past,
      );
      expect(boostedJob.isBoostActive, isFalse);
    });

    test('isBoostActive should be false when until is null', () {
      final boostedJob = baseJob.copyWith(
        boostStatus: 'active',
        boostActiveUntil: null,
      );
      expect(boostedJob.isBoostActive, isFalse);
    });

    test('hasBoostHistory should be true if boostPaymentId exists', () {
      final boostedJob = baseJob.copyWith(boostPaymentId: 'pay_123');
      expect(boostedJob.hasBoostHistory, isTrue);
    });

    test('hasBoostHistory should be true if lastBoostedAt exists', () {
      final boostedJob = baseJob.copyWith(lastBoostedAt: now);
      expect(boostedJob.hasBoostHistory, isTrue);
    });

    test('isBoostExpired should be true when status is active and until is in past', () {
      final boostedJob = baseJob.copyWith(
        boostStatus: 'active',
        boostActiveUntil: past,
      );
      expect(boostedJob.isBoostExpired, isTrue);
    });

    test('isBoostExpired should be false when status is active and until is in future', () {
      final boostedJob = baseJob.copyWith(
        boostStatus: 'active',
        boostActiveUntil: future,
      );
      expect(boostedJob.isBoostExpired, isFalse);
    });

    test('isBoostExpired should be false when status is none', () {
      final boostedJob = baseJob.copyWith(
        boostStatus: 'none',
        boostActiveUntil: past,
      );
      expect(boostedJob.isBoostExpired, isFalse);
    });
  });
}
