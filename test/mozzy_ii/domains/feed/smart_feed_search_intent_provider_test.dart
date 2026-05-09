import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mozzy/mozzy_ii/domains/feed/providers/smart_feed_provider.dart';

void main() {
  group('SmartFeedSearchIntent Provider Tests', () {
    test('initial state should be empty string', () {
      final container = ProviderContainer();
      addTearDown(container.dispose);
      
      expect(container.read(smartFeedSearchIntentProvider), '');
    });

    test('setIntent should trim whitespace', () {
      final container = ProviderContainer();
      addTearDown(container.dispose);
      
      container.read(smartFeedSearchIntentProvider.notifier).setIntent('  job search  ');
      expect(container.read(smartFeedSearchIntentProvider), 'job search');
    });

    test('setIntent should truncate long intent to 100 chars', () {
      final container = ProviderContainer();
      addTearDown(container.dispose);
      
      final longIntent = 'A' * 150;
      container.read(smartFeedSearchIntentProvider.notifier).setIntent(longIntent);
      
      final state = container.read(smartFeedSearchIntentProvider);
      expect(state.length, 100);
      expect(state, 'A' * 100);
    });

    test('clearIntent should reset to empty string', () {
      final container = ProviderContainer();
      addTearDown(container.dispose);
      
      container.read(smartFeedSearchIntentProvider.notifier).setIntent('job');
      expect(container.read(smartFeedSearchIntentProvider), 'job');
      
      container.read(smartFeedSearchIntentProvider.notifier).clearIntent();
      expect(container.read(smartFeedSearchIntentProvider), '');
    });

    test('hasIntent should return true when not empty', () {
      final container = ProviderContainer();
      addTearDown(container.dispose);
      
      expect(container.read(smartFeedSearchIntentProvider.notifier).hasIntent, false);
      
      container.read(smartFeedSearchIntentProvider.notifier).setIntent('job');
      expect(container.read(smartFeedSearchIntentProvider.notifier).hasIntent, true);
    });
  });
}
