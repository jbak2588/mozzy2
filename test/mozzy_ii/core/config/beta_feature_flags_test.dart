import 'package:flutter_test/flutter_test.dart';
import 'package:mozzy/mozzy_ii/core/config/beta_feature_flags.dart';

void main() {
  group('BetaFeatureFlags', () {
    test('enabledInBeta should contain expected features', () {
      expect(BetaFeatureFlags.enabledInBeta, contains(MozzyFeatureKey.news));
      expect(BetaFeatureFlags.enabledInBeta, contains(MozzyFeatureKey.marketplace));
      expect(BetaFeatureFlags.enabledInBeta, contains(MozzyFeatureKey.jobs));
      expect(BetaFeatureFlags.enabledInBeta, contains(MozzyFeatureKey.chat));
      expect(BetaFeatureFlags.enabledInBeta, contains(MozzyFeatureKey.smartFeed));
      expect(BetaFeatureFlags.enabledInBeta, contains(MozzyFeatureKey.notifications));
      expect(BetaFeatureFlags.enabledInBeta, contains(MozzyFeatureKey.paymentBoost));
    });

    test('disabledInBeta should contain expected features', () {
      expect(BetaFeatureFlags.disabledInBeta, contains(MozzyFeatureKey.auction));
      expect(BetaFeatureFlags.disabledInBeta, contains(MozzyFeatureKey.clubs));
      expect(BetaFeatureFlags.disabledInBeta, contains(MozzyFeatureKey.lostFound));
      expect(BetaFeatureFlags.disabledInBeta, contains(MozzyFeatureKey.pom));
      expect(BetaFeatureFlags.disabledInBeta, contains(MozzyFeatureKey.realEstate));
      expect(BetaFeatureFlags.disabledInBeta, contains(MozzyFeatureKey.stores));
      expect(BetaFeatureFlags.disabledInBeta, contains(MozzyFeatureKey.together));
    });

    // Note: bool.fromEnvironment cannot be easily mocked in a standard unit test
    // without custom test setups. We are testing the default behavior here
    // where isPrivateBeta is true.
    test('isEnabled returns correct value for beta defaults', () {
      if (BetaFeatureFlags.isPrivateBeta) {
        expect(BetaFeatureFlags.isEnabled(MozzyFeatureKey.news), isTrue);
        expect(BetaFeatureFlags.isEnabled(MozzyFeatureKey.auction), isFalse);
      }
    });

    test('isDisabled returns correct value for beta defaults', () {
      if (BetaFeatureFlags.isPrivateBeta) {
        expect(BetaFeatureFlags.isDisabled(MozzyFeatureKey.news), isFalse);
        expect(BetaFeatureFlags.isDisabled(MozzyFeatureKey.auction), isTrue);
      }
    });
  });
}
