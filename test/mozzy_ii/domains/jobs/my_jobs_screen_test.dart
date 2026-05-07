import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mozzy/mozzy_ii/domains/jobs/screens/my_jobs_screen.dart';
import 'package:mozzy/mozzy_ii/domains/jobs/providers/job_provider.dart';
import 'package:mozzy/mozzy_ii/domains/jobs/models/job_post_model.dart';
import 'package:mozzy/mozzy_ii/geo/models/location_parts.dart';

void main() {
  testWidgets('MyJobsScreen shows empty state when no jobs', (tester) async {
    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          myJobsProvider.overrideWith((ref) => Stream.value([])),
        ],
        child: const MaterialApp(
          home: MyJobsScreen(),
        ),
      ),
    );
    await tester.pumpAndSettle();
    expect(find.byIcon(Icons.work_outline), findsOneWidget);
  });

  testWidgets('MyJobsScreen shows list of jobs', (tester) async {
    final mockJob = JobPostModel(
      id: '1',
      title: 'Software Engineer',
      description: 'Desc',
      companyName: 'Mozzy Corp',
      ownerId: 'user1',
      ownerName: 'Owner',
      category: 'IT',
      jobType: JobType.fullTime,
      workType: WorkType.onsite,
      salaryType: SalaryType.monthly,
      salaryMin: 10000000,
      salaryMax: 20000000,
      locationParts: const LocationParts(
        countryCode: 'ID',
        latitude: 0.0,
        longitude: 0.0,
        geoHash: '',
      ),
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
      expiresAt: DateTime.now().add(const Duration(days: 30)),
      status: 'open',
    );

    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          myJobsProvider.overrideWith((ref) => Stream.value([mockJob])),
        ],
        child: const MaterialApp(
          home: MyJobsScreen(),
        ),
      ),
    );

    await tester.pumpAndSettle();
    expect(find.text('Software Engineer'), findsOneWidget);
    expect(find.text('Mozzy Corp'), findsOneWidget);
  });
}
