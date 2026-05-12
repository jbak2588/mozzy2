import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mozzy/mozzy_ii/domains/account/screens/account_settings_screen.dart';
import 'package:mozzy/mozzy_ii/app/auth/auth_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:mockito/mockito.dart';
import 'package:mockito/annotations.dart';
import 'package:package_info_plus/package_info_plus.dart';
import '../../../helpers/test_localization_app.dart';

import 'account_settings_screen_test.mocks.dart';

@GenerateMocks([User])
void main() {
  testWidgets('AccountSettingsScreen renders correctly', (tester) async {
    // Setup Mock PackageInfo
    PackageInfo.setMockInitialValues(
      appName: 'Mozzy',
      packageName: 'com.humantric.mozzy2',
      version: '1.0.0',
      buildNumber: '7',
      buildSignature: '',
    );

    final mockUser = MockUser();
    when(mockUser.displayName).thenReturn('Test User');
    when(mockUser.email).thenReturn('test@example.com');
    when(mockUser.photoURL).thenReturn(null);

    await tester.pumpWidget(
      TestLocalizationApp(
        overrides: [
          authStateProvider.overrideWith((ref) => Stream.value(mockUser)),
        ],
        child: const AccountSettingsScreen(),
      ),
    );

    await tester.pumpAndSettle();

    // Since FakeAssetLoader returns empty map, tr() returns the key itself
    expect(find.text('account.settingsTitle'), findsOneWidget);
    expect(find.text('Test User'), findsOneWidget);
    expect(find.text('test@example.com'), findsOneWidget);
    expect(find.byIcon(Icons.feedback_outlined), findsOneWidget);
    expect(find.byIcon(Icons.logout), findsOneWidget);
    expect(find.byIcon(Icons.delete_forever_outlined), findsOneWidget);
    expect(find.textContaining('1.0.0+7'), findsOneWidget);
    expect(find.text('account.privateBeta'), findsOneWidget);
  });
}
