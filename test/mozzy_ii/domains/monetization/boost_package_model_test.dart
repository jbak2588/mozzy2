import 'package:flutter_test/flutter_test.dart';
import 'package:mozzy/mozzy_ii/domains/monetization/models/boost_package_model.dart';

void main() {
  group('BoostPackageModel Tests', () {
    test('BoostPackageModel should serialize to JSON correctly', () {
      const package = BoostPackageModel(
        id: 'job_boost_1_day',
        productType: 'jobBoost',
        titleKey: 'monetization.boost1Day',
        descriptionKey: 'monetization.boostDescription',
        durationDays: 1,
        amount: 15000,
      );

      final json = package.toJson();
      expect(json['id'], 'job_boost_1_day');
      expect(json['amount'], 15000);
      expect(json['durationDays'], 1);
    });

    test('BoostPackageModel should deserialize from JSON correctly', () {
      final json = {
        'id': 'job_boost_3_days',
        'productType': 'jobBoost',
        'titleKey': 'monetization.boost3Days',
        'descriptionKey': 'monetization.boostDescription',
        'durationDays': 3,
        'amount': 40000,
        'currency': 'IDR',
        'isActive': true,
      };

      final package = BoostPackageModel.fromJson(json);
      expect(package.id, 'job_boost_3_days');
      expect(package.amount, 40000);
      expect(package.durationDays, 3);
    });
  });
}
