import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:easy_localization/easy_localization.dart';
import 'test_localization_app.dart';

/// Helper function to pump a widget with localization and providers.
Future<void> pumpMozzyTestApp(
  WidgetTester tester,
  Widget child, {
  List overrides = const [],
  Locale locale = const Locale('id'),
}) async {
  // Mock SharedPreferences
  SharedPreferences.setMockInitialValues({});
  
  // Initialize EasyLocalization for testing
  await tester.runAsync(() async {
    await EasyLocalization.ensureInitialized();
  });

  await tester.pumpWidget(
    TestLocalizationApp(
      overrides: overrides,
      locale: locale,
      child: child,
    ),
  );
  
  // Wait for localization to load and UI to settle
  await tester.pump();
}
