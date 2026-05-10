import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:visibility_detector/visibility_detector.dart';
import 'package:mozzy/mozzy_ii/domains/feed/widgets/viewport_impression_tracker.dart';

void main() {
  setUp(() {
    VisibilityDetectorController.instance.updateInterval = Duration.zero;
  });

  testWidgets('logs impression when visible for enough time', (WidgetTester tester) async {
    bool impressionLogged = false;
    double loggedRatio = 0.0;
    int loggedDwell = 0;

    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: ListView(
            children: [
              ViewportImpressionTracker(
                feedItemId: 'fi1',
                sourceId: 'src1',
                sourceType: 'job',
                onImpression: (ratio, dwell) {
                  impressionLogged = true;
                  loggedRatio = ratio;
                  loggedDwell = dwell;
                },
                child: const SizedBox(height: 100, width: double.infinity),
              ),
            ],
          ),
        ),
      ),
    );

    // Initial render
    await tester.pump();
    
    // Not logged immediately
    expect(impressionLogged, isFalse);

    // Wait for the dwell threshold (800ms)
    await tester.pump(const Duration(milliseconds: 850));

    expect(impressionLogged, isTrue);
    expect(loggedRatio, 1.0); // Fully visible in the ListView
    expect(loggedDwell, 800);
  });
  
  testWidgets('does not log impression if visibleRatio is below threshold', (WidgetTester tester) async {
    bool impressionLogged = false;

    // Use a Stack to position the widget partially off-screen
    // A 100x100 widget positioned at top: -60 will only have 40px visible
    // which is 40%, below the 50% threshold.
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: Stack(
            children: [
              Positioned(
                top: -60,
                child: ViewportImpressionTracker(
                  feedItemId: 'fi2',
                  sourceId: 'src2',
                  sourceType: 'job',
                  onImpression: (ratio, dwell) {
                    impressionLogged = true;
                  },
                  child: const SizedBox(height: 100, width: 100),
                ),
              ),
            ],
          ),
        ),
      ),
    );

    await tester.pump();
    await tester.pump(const Duration(milliseconds: 850));

    expect(impressionLogged, isFalse);
  });

  testWidgets('does not log impression if scrolled away before dwell time', (WidgetTester tester) async {
    bool impressionLogged = false;

    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: ListView(
            children: [
              ViewportImpressionTracker(
                feedItemId: 'fi3',
                sourceId: 'src3',
                sourceType: 'job',
                onImpression: (ratio, dwell) {
                  impressionLogged = true;
                },
                child: const SizedBox(height: 100, width: double.infinity),
              ),
              const SizedBox(height: 2000), // Lots of space to scroll
            ],
          ),
        ),
      ),
    );

    await tester.pump();
    
    // Wait for part of the time
    await tester.pump(const Duration(milliseconds: 400));
    
    // Scroll it out of view
    await tester.dragFrom(const Offset(200, 300), const Offset(0, -1000));
    await tester.pumpAndSettle();
    
    // Wait the rest of the time
    await tester.pump(const Duration(milliseconds: 450));

    expect(impressionLogged, isFalse);
  });

  testWidgets('does not log impression if identifiers are empty', (WidgetTester tester) async {
    bool impressionLogged = false;

    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: ListView(
            children: [
              ViewportImpressionTracker(
                feedItemId: '',
                sourceId: '',
                sourceType: '',
                onImpression: (ratio, dwell) {
                  impressionLogged = true;
                },
                child: const SizedBox(height: 100, width: double.infinity),
              ),
            ],
          ),
        ),
      ),
    );

    await tester.pump();
    await tester.pump(const Duration(milliseconds: 850));

    expect(impressionLogged, isFalse);
  });
}
