import 'package:flutter/foundation.dart';
import 'package:google_sign_in/google_sign_in.dart';
import '../../core/config/integration_test_config.dart';

class GoogleSignInConfig {
  static const String webClientId = String.fromEnvironment(
    'GOOGLE_WEB_CLIENT_ID',
  );

  /// Call this once at startup (before runApp) with --dart-define
  static Future<void> initialize() async {
    if (IntegrationTestConfig.enabled) return;

    if (kDebugMode) {
      // ignore: avoid_print
      print('DEBUG: Loading GOOGLE_WEB_CLIENT_ID... length: ${webClientId.length}');
      if (webClientId.isNotEmpty) {
        // ignore: avoid_print
        print('DEBUG: Web Client ID start: ${webClientId.substring(0, 12)}...');
      }
    }

    if (webClientId.isEmpty) {
      if (kDebugMode) {
        // ignore: avoid_print
        print('WARNING: GOOGLE_WEB_CLIENT_ID is missing. Google Sign-In idToken features might not work.');
      }
      return;
    }

    try {
      // Initialize might fail on Android if SHA-1 is missing in Firebase Console
      await GoogleSignIn.instance.initialize(serverClientId: webClientId);
    } catch (e, stack) {
      if (kDebugMode) {
        // ignore: avoid_print
        print('DEBUG: GoogleSignIn.instance.initialize() failed. This usually means SHA-1 is missing or mismatched in Firebase.');
        // ignore: avoid_print
        print('Error: $e');
        // ignore: avoid_print
        print('Stack: $stack');
      }
      // Depending on requirements, we can rethrow or ignore.
      // Ignoring allows the app to load, but Google Sign-In will fail later.
      // throw e;
    }
  }
}
