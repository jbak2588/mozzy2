import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:mozzy/mozzy_ii/domains/news/screens/create_post_screen.dart';
import 'package:mozzy/mozzy_ii/geo/models/location_parts.dart';

// Test helpers: provide a fake location and notifier to avoid real GPS calls
final _testLocation = LocationParts(
  countryCode: 'ID',
  idAddress: IndonesiaGeoAddress(
    provinsi: 'DKI Jakarta',
    kabupaten: 'Jakarta Selatan',
    kecamatan: 'Kebayoran Baru',
    kelurahan: 'Senayan',
  ),
  latitude: 0,
  longitude: 0,
  geoHash: 'x',
);


void main() {
  testWidgets('CreatePostScreen renders fields and shows validation', (
    tester,
  ) async {
    await EasyLocalization.ensureInitialized();

    // use top-level _testLocation and FakeLocationNotifier

    await tester.pumpWidget(
      ProviderScope(overrides: [
        // Avoid actual location lookups in tests by overriding effectiveLocationProvider
        effectiveLocationProvider.overrideWithValue(AsyncData(_testLocation)),
        // Provide a fake logged-in user id
        currentUserIdProvider.overrideWithValue('test-user'),
      ], child: EasyLocalization(
        supportedLocales: const [Locale('id')],
        path: 'assets/translations',
        child: MaterialApp(home: CreatePostScreen()),
      )),
    );

    await tester.pump();

    expect(find.byType(TextField), findsNWidgets(2)); // title + content
    expect(find.byType(DropdownButtonFormField<String>), findsOneWidget);
    expect(find.byType(ElevatedButton), findsOneWidget);

    // Tap submit with empty fields -> titleRequired snackbar
    await tester.tap(find.byType(ElevatedButton));
    await tester.pump();

    expect(find.text('news.titleRequired'.tr()), findsOneWidget);

    // Enter title only -> should show contentRequired
    await tester.enterText(find.byType(TextField).first, 'Test Title');
    await tester.tap(find.byType(ElevatedButton));
    await tester.pump();

    expect(find.text('news.contentRequired'.tr()), findsOneWidget);
  });
}
