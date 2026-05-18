import 'package:flutter/foundation.dart';
import 'package:google_sign_in/google_sign_in.dart';

import 'google_oauth_config.dart';

class GoogleSignInConfig {
  static String get webClientId => GoogleOAuthConfig.webClientId;

  static bool get hasWebClientId => GoogleOAuthConfig.hasWebClientId;

  static Future<void> initialize() async {
    if (!hasWebClientId) {
      debugPrint('[GoogleSignInConfig] Web Client ID is missing.');
      return;
    }

    debugPrint('[GoogleSignInConfig] Web Client ID length=${webClientId.length}');
    debugPrint('[GoogleSignInConfig] Web Client ID prefix=${webClientId.substring(0, 12)}...');

    try {
      await GoogleSignIn.instance.initialize(
        serverClientId: webClientId,
      );
      debugPrint('[GoogleSignInConfig] GoogleSignIn.instance.initialize() successful');
    } catch (e, stack) {
      debugPrint('ERROR: [GoogleSignInConfig] GoogleSignIn.instance.initialize() failed.');
      debugPrint('This usually means SHA-1 is missing or mismatched in Firebase Console.');
      debugPrint('Error: $e');
      if (kDebugMode) {
        debugPrint('Stack: $stack');
      }
    }
  }
}
