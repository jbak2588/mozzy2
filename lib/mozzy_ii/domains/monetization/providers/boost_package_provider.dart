import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../models/boost_package_model.dart';

part 'boost_package_provider.g.dart';

@riverpod
List<BoostPackageModel> jobBoostPackages(Ref ref) {
  return const [
    BoostPackageModel(
      id: 'job_boost_1_day',
      productType: 'jobBoost',
      titleKey: 'monetization.boost1Day',
      descriptionKey: 'monetization.boostDescription',
      durationDays: 1,
      amount: 15000,
    ),
    BoostPackageModel(
      id: 'job_boost_3_days',
      productType: 'jobBoost',
      titleKey: 'monetization.boost3Days',
      descriptionKey: 'monetization.boostDescription',
      durationDays: 3,
      amount: 40000,
    ),
    BoostPackageModel(
      id: 'job_boost_7_days',
      productType: 'jobBoost',
      titleKey: 'monetization.boost7Days',
      descriptionKey: 'monetization.boostDescription',
      durationDays: 7,
      amount: 90000,
    ),
  ];
}
