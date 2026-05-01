import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mozzy/mozzy_ii/app/auth/auth_gate.dart';
import 'package:mozzy/mozzy_ii/app/auth/auth_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:mockito/annotations.dart';

@GenerateMocks([AuthService, User])
import 'auth_gate_test.mocks.dart';

void main() {
  setUp(() {});

  Widget createWidget({required ProviderContainer container}) {
    return UncontrolledProviderScope(
      container: container,
      child: const MaterialApp(home: AuthGate()),
    );
  }

  testWidgets('Shows loading indicator when authState is loading', (
    tester,
  ) async {
    final container = ProviderContainer(
      overrides: [
        authStateProvider.overrideWith((ref) => const Stream.empty()),
      ],
    );

    await tester.pumpWidget(createWidget(container: container));
    expect(find.byType(CircularProgressIndicator), findsOneWidget);
  });

  testWidgets('Shows LoginScreen when user is null', (tester) async {
    final container = ProviderContainer(
      overrides: [authStateProvider.overrideWith((ref) => Stream.value(null))],
    );

    await tester.pumpWidget(createWidget(container: container));
    await tester.pumpAndSettle();

    expect(find.byType(LoginScreen), findsOneWidget);
  });

  testWidgets('Shows Placeholder Home when user is logged in', (tester) async {
    final mockUser = MockUser();
    final container = ProviderContainer(
      overrides: [
        authStateProvider.overrideWith((ref) => Stream.value(mockUser)),
      ],
    );

    await tester.pumpWidget(createWidget(container: container));
    await tester.pumpAndSettle();

    expect(find.text('Home (navigation not configured)'), findsOneWidget);
  });
}
