class TrustScoreService {
  /// Initial trust score for Google sign-in new users
  static double initialForGoogle() => 0.3;

  /// Initial trust level key
  static String initialLevel() => 'anggota_baru';

  /// Example method for future increments (phone verification +0.2)
  static double withPhoneVerification(double current) =>
      (current + 0.2).clamp(0.0, 1.0);
}
