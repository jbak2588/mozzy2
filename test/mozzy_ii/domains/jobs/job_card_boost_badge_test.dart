import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mozzy/mozzy_ii/domains/jobs/models/job_post_model.dart';
import 'package:mozzy/mozzy_ii/domains/jobs/widgets/job_card.dart';
import 'package:mozzy/mozzy_ii/geo/models/location_parts.dart';
import 'package:intl/date_symbol_data_local.dart';

void main() {
  setUpAll(() async {
    await initializeDateFormatting('id_ID', null);
  });

  testWidgets('JobCard shows boost badge when active', (tester) async {
    final now = DateTime.now();
    final job = JobPostModel(
      id: 'job1',
      title: 'Boosted Job',
      companyName: 'Company',
      description: 'Desc',
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
        geoHash: 'abc',
      ),
      createdAt: now,
      updatedAt: now,
      expiresAt: now.add(const Duration(days: 30)),
      boostStatus: 'active',
      boostActiveUntil: now.add(const Duration(days: 1)),
    );

    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: JobCard(job: job),
        ),
      ),
    );

    // Bolt icon should be present for boosted jobs
    expect(find.byIcon(Icons.bolt), findsOneWidget);
  });

  testWidgets('JobCard does not show boost badge when expired', (tester) async {
    final now = DateTime.now();
    final job = JobPostModel(
      id: 'job2',
      title: 'Expired Boost Job',
      companyName: 'Company',
      description: 'Desc',
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
        geoHash: 'abc',
      ),
      createdAt: now,
      updatedAt: now,
      expiresAt: now.add(const Duration(days: 30)),
      boostStatus: 'active',
      boostActiveUntil: now.subtract(const Duration(days: 1)),
    );

    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: JobCard(job: job),
        ),
      ),
    );

    // Bolt icon should NOT be present for expired boost
    expect(find.byIcon(Icons.bolt), findsNothing);
  });
}
