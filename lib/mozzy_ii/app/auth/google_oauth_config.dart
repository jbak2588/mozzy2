class GoogleOAuthConfig {
  GoogleOAuthConfig._();

  /// Firebase / Google OAuth Web Client ID.
  ///
  /// This is not a server secret.
  /// It is required by Google Sign-In to request an ID token for Firebase Auth.
  ///
  /// Do not put Gemini API keys, payment secrets, service account keys,
  /// or private keys in this file.
  static const String webClientId =
      '149673701591-oml428ssc9hon7mla0rvsn6e528hgdv9.apps.googleusercontent.com';

  static bool get hasWebClientId => webClientId.trim().isNotEmpty;
}
