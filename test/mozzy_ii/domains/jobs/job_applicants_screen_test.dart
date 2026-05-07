import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mozzy/mozzy_ii/domains/jobs/screens/job_applicants_screen.dart';
import 'package:mozzy/mozzy_ii/domains/jobs/providers/job_provider.dart';
import 'package:mozzy/mozzy_ii/domains/jobs/providers/job_applicant_provider.dart';
import 'package:mozzy/mozzy_ii/domains/jobs/models/job_applicant_model.dart';
import 'package:mozzy/mozzy_ii/domains/jobs/models/job_post_model.dart';
import 'package:mozzy/mozzy_ii/domains/jobs/widgets/job_applicant_card.dart';
import 'package:easy_localization/easy_localization.dart';

void main() {
  testWidgets('JobApplicantsScreen shows empty state', (tester) async {
    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          filteredJobApplicantsProvider('job1').overrideWith((ref) => const AsyncValue.data([])),
          jobDetailProvider('job1').overrideWith((ref) => Future.value(null)),
        ],
        child: const MaterialApp(
          home: Scaffold(
            body: JobApplicantsScreen(jobId: 'job1'),
          ),
        ),
      ),
    );

    await tester.pump();
    expect(find.byType(JobApplicantCard), findsNothing);
  });

  testWidgets('JobApplicantsScreen shows list of applicants', (tester) async {
    final mockApplicant = JobApplicantModel(
      id: 'app1',
      jobId: 'job1',
      applicantId: 'user1',
      applicantName: 'John Doe',
      status: JobApplicantStatus.newApplicant,
      appliedAt: DateTime.now(),
      updatedAt: DateTime.now(),
    );

    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          filteredJobApplicantsProvider('job1').overrideWith((ref) => AsyncValue.data([mockApplicant])),
          jobDetailProvider('job1').overrideWith((ref) => Future.value(null)),
        ],
        child: const MaterialApp(
          home: Scaffold(
            body: JobApplicantsScreen(jobId: 'job1'),
          ),
        ),
      ),
    );

    await tester.pump();
    expect(find.byType(JobApplicantCard), findsOneWidget);
  });
}
