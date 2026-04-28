import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:mozzy/mozzy_ii/discovery/screens/home_screen.dart';

void main() {
  testWidgets(
    'HomeScreen renders with null location and shows Dev Profile button',
    (tester) async {
      await tester.pumpWidget(
        ProviderScope(child: const MaterialApp(home: HomeScreen())),
      );

      // AppBar exists and Dev Profile icon button present (no crash)
      expect(find.byType(AppBar), findsOneWidget);
      expect(find.byIcon(Icons.person_outline), findsOneWidget);
    },
  );
}
