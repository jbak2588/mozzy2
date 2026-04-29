import 'package:google_sign_in/google_sign_in.dart';
import '../../core/config/integration_test_config.dart';

class GoogleSignInConfig {
  static const String webClientId = String.fromEnvironment(
    'GOOGLE_WEB_CLIENT_ID',
  );

  /// Call this once at startup (before runApp) with --dart-define
  static Future<void> initialize() async {
    if (IntegrationTestConfig.enabled) return;

    if (webClientId.isEmpty) {
      throw StateError(
        'GOOGLE_WEB_CLIENT_ID is missing. Run with --dart-define=\'GOOGLE_WEB_CLIENT_ID=<WEB_CLIENT_ID>\'.',
      );
    }

    await GoogleSignIn.instance.initialize(serverClientId: webClientId);
  }
}

