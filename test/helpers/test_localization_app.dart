import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:easy_localization/easy_localization.dart';
export 'pump_mozzy_test_app.dart';

/// A fake asset loader for tests to avoid file system access.
class FakeAssetLoader extends AssetLoader {
  @override
  Future<Map<String, dynamic>> load(String path, Locale locale) async {
    return {}; // Return empty map, tr() will return the key
  }
}

/// A wrapper for widget tests that provides EasyLocalization and ProviderScope.
class TestLocalizationApp extends StatelessWidget {
  final Widget child;
  final List overrides;
  final Locale locale;

  const TestLocalizationApp({
    super.key,
    required this.child,
    this.overrides = const [],
    this.locale = const Locale('id'),
  });

  @override
  Widget build(BuildContext context) {
    return ProviderScope(
      overrides: overrides.cast(),
      child: EasyLocalization(
        supportedLocales: const [
          Locale('id'),
          Locale('en'),
          Locale('ko'),
        ],
        path: 'assets/translations',
        fallbackLocale: const Locale('id'),
        startLocale: locale,
        saveLocale: false,
        useOnlyLangCode: true,
        assetLoader: FakeAssetLoader(),
        child: Builder(
          builder: (context) {
            return MaterialApp(
              locale: context.locale,
              supportedLocales: context.supportedLocales,
              localizationsDelegates: context.localizationDelegates,
              home: child,
            );
          },
        ),
      ),
    );
  }
}
