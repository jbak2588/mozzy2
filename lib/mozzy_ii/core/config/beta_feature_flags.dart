enum MozzyFeatureKey {
  news,
  marketplace,
  jobs,
  chat,
  smartFeed,
  notifications,
  paymentBoost,
  auction,
  clubs,
  lostFound,
  pom,
  realEstate,
  stores,
  together,
}

class BetaFeatureFlags {
  static const bool isPrivateBeta = bool.fromEnvironment(
    'PRIVATE_BETA',
    defaultValue: true,
  );

  static const bool paymentProductionEnabled = bool.fromEnvironment(
    'PAYMENT_PRODUCTION_ENABLED',
    defaultValue: false,
  );

  static const Set<MozzyFeatureKey> enabledInBeta = {
    MozzyFeatureKey.news,
    MozzyFeatureKey.marketplace,
    MozzyFeatureKey.jobs,
    MozzyFeatureKey.chat,
    MozzyFeatureKey.smartFeed,
    MozzyFeatureKey.notifications,
    MozzyFeatureKey.paymentBoost,
  };

  static const Set<MozzyFeatureKey> disabledInBeta = {
    MozzyFeatureKey.auction,
    MozzyFeatureKey.clubs,
    MozzyFeatureKey.lostFound,
    MozzyFeatureKey.pom,
    MozzyFeatureKey.realEstate,
    MozzyFeatureKey.stores,
    MozzyFeatureKey.together,
  };

  static bool isEnabled(MozzyFeatureKey key) {
    if (!isPrivateBeta) return true;
    return enabledInBeta.contains(key);
  }

  static bool isDisabled(MozzyFeatureKey key) {
    return !isEnabled(key);
  }

  static bool isPaymentProduction() {
    return paymentProductionEnabled;
  }
}
