import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mozzy/mozzy_ii/domains/feed/providers/feed_session_provider.dart';

void main() {
  group('feedSessionIdProvider', () {
    test('should return a non-empty UUID', () {
      final container = ProviderContainer();
      addTearDown(container.dispose);

      final sessionId = container.read(feedSessionIdProvider);
      expect(sessionId, isNotEmpty);
      expect(sessionId.length, greaterThan(30)); // UUID v4 length is 36
    });

    test('should maintain stable sessionId within the same container', () {
      final container = ProviderContainer();
      addTearDown(container.dispose);

      final session1 = container.read(feedSessionIdProvider);
      final session2 = container.read(feedSessionIdProvider);
      
      expect(session1, equals(session2));
    });

    test('should return different sessionId for different containers', () {
      final container1 = ProviderContainer();
      final container2 = ProviderContainer();
      addTearDown(container1.dispose);
      addTearDown(container2.dispose);

      final session1 = container1.read(feedSessionIdProvider);
      final session2 = container2.read(feedSessionIdProvider);
      
      expect(session1, isNot(equals(session2)));
    });
  });
}
