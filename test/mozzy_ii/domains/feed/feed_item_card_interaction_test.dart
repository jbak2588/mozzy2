import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:go_router/go_router.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:mozzy/mozzy_ii/domains/feed/widgets/feed_item_card.dart';
import 'package:mozzy/mozzy_ii/domains/feed/models/feed_item_model.dart';
import 'package:mozzy/mozzy_ii/domains/feed/models/feed_item_type.dart';
import 'package:mozzy/mozzy_ii/domains/feed/models/feed_interaction_event.dart';
import 'package:mozzy/mozzy_ii/domains/feed/models/feed_interaction_type.dart';
import 'package:mozzy/mozzy_ii/domains/feed/repositories/feed_interaction_repository.dart';
import 'package:mozzy/mozzy_ii/domains/feed/providers/feed_interaction_provider.dart';
import 'package:mozzy/mozzy_ii/domains/feed/providers/feed_session_provider.dart';
import '../../../helpers/test_localization_app.dart';

class ManualMockFeedInteractionRepository implements FeedInteractionRepository {
  FeedInteractionEvent? lastEvent;
  int callCount = 0;

  @override
  Future<void> logInteraction(FeedInteractionEvent event) async {
    lastEvent = event;
    callCount++;
  }
}

void main() {
  late ManualMockFeedInteractionRepository mockRepository;

  setUp(() {
    mockRepository = ManualMockFeedInteractionRepository();
  });

  group('FeedItemCard Interaction Tests', () {
    testWidgets('tapping FeedItemCard calls logInteraction with card_tap', (WidgetTester tester) async {
      final now = DateTime.now();
      final item = FeedItemModel(
        id: '1',
        sourceId: 'src-1',
        type: FeedItemType.job,
        title: 'Test Job',
        createdAt: now,
        route: '/jobs/1',
      );

      // Create a router to handle context.push
      final router = GoRouter(
        initialLocation: '/',
        routes: [
          GoRoute(
            path: '/',
            builder: (context, state) => FeedItemCard(
              item: item,
              position: 3,
              hasSemanticIntent: true,
              intentLengthBucket: 'medium',
            ),
          ),
          GoRoute(
            path: '/jobs/1',
            builder: (context, state) => const Scaffold(body: Text('Detail Page')),
          ),
        ],
      );

      // Mock SharedPreferences
      SharedPreferences.setMockInitialValues({});

      // Initialize EasyLocalization
      await tester.runAsync(() async {
        await EasyLocalization.ensureInitialized();
      });

      await tester.pumpWidget(
        ProviderScope(
          overrides: [
            feedInteractionRepositoryProvider.overrideWithValue(mockRepository),
            feedSessionIdProvider.overrideWithValue('test-session'),
          ],
          child: EasyLocalization(
            supportedLocales: const [Locale('id')],
            path: 'assets/translations',
            fallbackLocale: const Locale('id'),
            assetLoader: FakeAssetLoader(),
            child: MaterialApp.router(
              routerConfig: router,
            ),
          ),
        ),
      );

      await tester.pumpAndSettle();

      // Tap the card
      await tester.tap(find.byType(FeedItemCard));
      await tester.pump(); // Start navigation and logging
      await tester.pumpAndSettle(); // Complete navigation

      // Verify logInteraction was called
      expect(mockRepository.callCount, 1);
      final event = mockRepository.lastEvent!;

      expect(event.eventType, FeedInteractionType.cardTap);
      expect(event.feedItemId, '1');
      expect(event.position, 3);
      expect(event.hasSemanticIntent, true);
      expect(event.intentLengthBucket, 'medium');
      expect(event.sessionId, 'test-session');
      
      // Verify navigation happened
      expect(find.text('Detail Page'), findsOneWidget);
    });
  });
}
