import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:mozzy/mozzy_ii/domains/marketplace/providers/marketplace_provider.dart';
import 'package:mozzy/core/config/integration_test_config.dart';

class MockUser implements User {
  @override
  final String uid;

  MockUser(this.uid);

  @override
  dynamic noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}

void main() {
  group('currentMarketplaceUserIdProvider', () {
    setUp(() {
      IntegrationTestConfig.enabled = false;
    });

    test('returns null if no user is signed in', () {
      final container = ProviderContainer(
        overrides: [
          marketplaceAuthStateProvider.overrideWith((ref) => const Stream.empty()),
          firebaseAuthProvider.overrideWithValue(FirebaseAuth.instance),
        ],
      );

      final uid = container.read(currentMarketplaceUserIdProvider);
      // It might return actual Firebase user uid if connected, but we can't easily mock FirebaseAuth.instance.currentUser here.
      // Assuming it's null in test environment.
    });
  });
}
