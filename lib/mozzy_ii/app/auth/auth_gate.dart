import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// 임시: 실제 인증 로직(Phase 1-B)이 들어가기 전까지 더미 상태를 제공하는 Provider
class AuthNotifier extends Notifier<bool> {
  @override
  bool build() {
    return true; // 임시로 '로그인 됨' 상태로 고정
  }
}

final authStateProvider = NotifierProvider<AuthNotifier, bool>(() {
  return AuthNotifier();
});

class AuthGateScreen extends ConsumerWidget {
  const AuthGateScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // 앱 진입 시 초기 로딩 화면 역할
    return const Scaffold(
      body: Center(
        child: CircularProgressIndicator(color: Color(0xFFCC0001)),
      ),
    );
  }
}
