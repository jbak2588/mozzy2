class AuthFailure implements Exception {
  final String code;
  final String? message;

  AuthFailure(this.code, {this.message});

  @override
  String toString() => 'AuthFailure($code, message: $message)';

  // Predefined codes
  static const String googleWebClientIdMissing = 'google_web_client_id_missing';
  static const String googleIdTokenMissing = 'google_id_token_missing';
  static const String googleSignInCancelled = 'google_sign_in_cancelled';
  static const String googleSignInUnknown = 'google_sign_in_unknown';
  static const String firebaseAuthInvalidCredential = 'firebase_auth_invalid_credential';
  static const String firebaseAuthNetworkRequestFailed = 'firebase_auth_network_request_failed';
}
