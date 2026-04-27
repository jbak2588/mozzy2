import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'auth_service.dart';
import '../navigation/main_scaffold.dart';

// LoginScreen이 아직 구현되지 않았으므로 임시로 빈 화면을 사용하거나 나중에 구현 예정인 화면으로 연결합니다.
// 여기서는 간단한 로그인 버튼이 있는 화면을 예시로 둡니다.

class AuthGate extends ConsumerWidget {
  const AuthGate({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authState = ref.watch(authStateProvider);

    return authState.when(
      data: (user) {
        if (user != null) {
          return const MainScaffold();
        }
        return const LoginScreen();
      },
      loading: () => const Scaffold(
        body: Center(
          child: CircularProgressIndicator(color: Color(0xFFCC0001)),
        ),
      ),
      error: (e, st) => Scaffold(
        body: Center(
          child: Text('Error: $e'),
        ),
      ),
    );
  }
}

class LoginScreen extends ConsumerWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(title: const Text('Mozzy Indonesia')),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Selamat Datang',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 48),
            ElevatedButton(
              onPressed: () {
                // TODO: 전화번호 로그인 화면으로 이동
              },
              child: const Text('Masuk dengan Nomor HP'),
            ),
            const SizedBox(height: 16),
            OutlinedButton(
              onPressed: () async {
                await ref.read(authServiceProvider).signInAnonymously();
              },
              style: OutlinedButton.styleFrom(
                minimumSize: const Size(double.infinity, 48),
              ),
              child: const Text('Masuk sebagai Tamu (Coba Dulu)'),
            ),
          ],
        ),
      ),
    );
  }
}
