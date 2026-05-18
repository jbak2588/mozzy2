import 'package:flutter/foundation.dart';
import 'package:google_sign_in/google_sign_in.dart';
import '../../core/config/integration_test_config.dart';

class GoogleSignInConfig {
  static const String webClientId = String.fromEnvironment(
    'GOOGLE_WEB_CLIENT_ID',
  );

  static bool get hasWebClientId => webClientId.trim().isNotEmpty;

  /// Call this once at startup (before runApp) with --dart-define
  static Future<void> initialize() async {
    if (IntegrationTestConfig.enabled) return;

    if (kDebugMode) {
      debugPrint('[GoogleSignInConfig] GOOGLE_WEB_CLIENT_ID length=${webClientId.length}');
      if (webClientId.isNotEmpty) {
        debugPrint('[GoogleSignInConfig] GOOGLE_WEB_CLIENT_ID prefix=${webClientId.substring(0, 12)}...');
      }
    }

    if (!hasWebClientId) {
      if (kDebugMode) {
        debugPrint('WARNING: [GoogleSignInConfig] GOOGLE_WEB_CLIENT_ID is missing. Google Sign-In will be disabled.');
      }
      return;
    }

    try {
      // Initialize might fail on Android if SHA-1 is missing in Firebase Console
      await GoogleSignIn.instance.initialize(serverClientId: webClientId);
      debugPrint('[GoogleSignInConfig] GoogleSignIn.instance.initialize() successful');
    } catch (e, stack) {
      // Always log critical initialization errors to adb logcat
      debugPrint('ERROR: [GoogleSignInConfig] GoogleSignIn.instance.initialize() failed.');
      debugPrint('This usually means SHA-1 is missing or mismatched in Firebase Console.');
      debugPrint('Error: $e');
      if (kDebugMode) {
        debugPrint('Stack: $stack');
      }
    }
  }
}
