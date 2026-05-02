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
      throw StateError(
        'GOOGLE_WEB_CLIENT_ID is missing. Run with --dart-define=\'GOOGLE_WEB_CLIENT_ID=<WEB_CLIENT_ID>\'.',
      );
    }

    await GoogleSignIn.instance.initialize(serverClientId: webClientId);
  }
}
