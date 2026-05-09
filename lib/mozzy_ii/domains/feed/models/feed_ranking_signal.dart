class FeedRankingSignal {
  // Boost Weights
  static const double activeBoostBonus = 100.0;
  
  // Freshness Weights
  static const double freshnessWithin24h = 30.0;
  static const double freshnessWithin3Days = 20.0;
  static const double freshnessWithin7Days = 10.0;
  
  // Trust Weights
  static const double highTrustBonus = 20.0;
  static const double midTrustBonus = 10.0;
  
  // Distance Weights
  static const double sameDistrictBonus = 20.0;
  static const double sameCityBonus = 10.0;
  
  // Engagement Weights
  static const double engagementMultiplier = 1.0; // Scaled by count
}
