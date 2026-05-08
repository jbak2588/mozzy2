import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mozzy/mozzy_ii/domains/jobs/screens/job_boost_purchase_screen.dart';
import 'package:mozzy/mozzy_ii/domains/jobs/providers/job_provider.dart';
import 'package:mozzy/mozzy_ii/domains/jobs/models/job_post_model.dart';
import 'package:mozzy/mozzy_ii/domains/monetization/providers/boost_package_provider.dart';
import 'package:mozzy/mozzy_ii/domains/monetization/models/boost_package_model.dart';
import 'package:mozzy/mozzy_ii/domains/payments/providers/payment_action_provider.dart';
import 'package:mozzy/mozzy_ii/geo/models/location_parts.dart';

void main() {
  final now = DateTime.now();
  final mockJob = JobPostModel(
    id: 'job_123',
    title: 'Flutter Developer',
    description: 'We need an expert',
    companyName: 'Mozzy Tech',
    ownerId: 'owner_abc',
    ownerName: 'Admin',
    category: 'IT',
    jobType: JobType.fullTime,
    workType: WorkType.remote,
    salaryType: SalaryType.monthly,
    salaryMin: 10000000,
    salaryMax: 15000000,
    locationParts: const LocationParts(
      countryCode: 'ID',
      latitude: -6.2,
      longitude: 106.8,
      geoHash: 'qqgv',
    ),
    createdAt: now,
    updatedAt: now,
    expiresAt: now.add(const Duration(days: 30)),
  );

  final mockPackages = [
    const BoostPackageModel(
      id: 'pkg_1',
      productType: 'jobBoost',
      titleKey: 'Boost 1 Day',
      descriptionKey: 'Desc',
      durationDays: 1,
      amount: 15000,
    ),
  ];

  testWidgets('JobBoostPurchaseScreen renders correctly', (WidgetTester tester) async {
    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          jobDetailProvider('job_123').overrideWith((ref) => Future.value(mockJob)),
          jobBoostPackagesProvider.overrideWith((ref) => mockPackages),
          paymentActionProvider.overrideWith(() => PaymentAction()),
        ],
        child: const MaterialApp(
          home: JobBoostPurchaseScreen(jobId: 'job_123'),
        ),
      ),
    );

    await tester.pump();
    await tester.pumpAndSettle();

    expect(find.text('Flutter Developer'), findsOneWidget);
    expect(find.text('Mozzy Tech'), findsOneWidget);
    expect(find.text('Boost 1 Day'), findsOneWidget);
    expect(find.text('Rp 15.000'), findsOneWidget);
  });
}
