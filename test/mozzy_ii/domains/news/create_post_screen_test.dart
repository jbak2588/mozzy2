import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:mozzy/mozzy_ii/domains/news/screens/create_post_screen.dart';

void main() {
  testWidgets('CreatePostScreen renders fields and shows validation', (
    tester,
  ) async {
    await EasyLocalization.ensureInitialized();

    await tester.pumpWidget(
      ProviderScope(
        child: EasyLocalization(
          supportedLocales: const [Locale('id')],
          path: 'assets/translations',
          child: MaterialApp(home: CreatePostScreen()),
        ),
      ),
    );

    await tester.pumpAndSettle();

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
