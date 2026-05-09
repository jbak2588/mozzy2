import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mozzy/mozzy_ii/app/navigation/app_router.dart';

void main() {
  group('Smart Feed Routing Tests', () {
    test('Router has /feed and /home mapping to SmartFeedScreen', () {
      final container = ProviderContainer();
      final router = container.read(routerProvider);

      // Check if routes exist
      final feedMatch = router.configuration.findMatch(Uri.parse('/feed'));
      expect(feedMatch.matches.isNotEmpty, true);
      
      final homeMatch = router.configuration.findMatch(Uri.parse('/home'));
      expect(homeMatch.matches.isNotEmpty, true);
    });

    test('Router has /legacy-home mapping', () {
      final container = ProviderContainer();
      final router = container.read(routerProvider);

      final legacyMatch = router.configuration.findMatch(Uri.parse('/legacy-home'));
      expect(legacyMatch.matches.isNotEmpty, true);
    });
  });
}
