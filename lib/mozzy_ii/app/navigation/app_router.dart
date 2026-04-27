import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'main_scaffold.dart';
import '../auth/auth_gate.dart';
import '../auth/auth_service.dart';
import '../../geo/screens/location_permission_screen.dart';
import '../../geo/screens/shared_map_browser_screen.dart';

// 임시 플레이스홀더 화면들
class DummyScreen extends StatelessWidget {
  final String title;
  const DummyScreen({super.key, required this.title});
  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(title: Text(title)),
    body: Center(child: Text(title, style: const TextStyle(fontSize: 24))),
  );
}

final routerProvider = Provider<GoRouter>((ref) {
  return GoRouter(
    initialLocation: '/',
    debugLogDiagnostics: true,
    
    routes: [
      // 진입점 (Auth Gate에서 로그인 여부에 따라 MainScaffold 또는 LoginScreen 반환)
      GoRoute(
        path: '/',
        builder: (context, state) => const AuthGate(),
      ),
      
      // 위치 권한 요청 화면
      GoRoute(
        path: '/location-permission',
        builder: (context, state) => const LocationPermissionScreen(),
      ),
      
      // 공통 지도 브라우저 화면
      GoRoute(
        path: '/map',
        builder: (context, state) => const SharedMapBrowserScreen(),
      ),

      // 메인 바텀 탭 구조 (StatefulShellRoute)
      StatefulShellRoute.indexedStack(
        builder: (context, state, navigationShell) {
          return MainScaffold(navigationShell: navigationShell);
        },
        branches: [
          // 탭 1: 홈 (Beranda) - Smart Feed
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: '/home',
                builder: (context, state) => const DummyScreen(title: 'Beranda (Smart Feed)'),
              ),
            ],
          ),
          // 탭 2: 마켓 (Jual)
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: '/marketplace',
                builder: (context, state) => const DummyScreen(title: 'Jual Beli (Marketplace)'),
              ),
            ],
          ),
          // 탭 3: 뉴스 (Berita)
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: '/news',
                builder: (context, state) => const DummyScreen(title: 'Berita Lokal (News)'),
              ),
            ],
          ),
          // 탭 4: 동네 스토어 (Toko)
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: '/stores',
                builder: (context, state) => const DummyScreen(title: 'Toko Sekitar (Stores)'),
              ),
            ],
          ),
          // 탭 5: 채팅 (Pesan)
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: '/chat',
                builder: (context, state) => const DummyScreen(title: 'Pesan (Chat)'),
              ),
            ],
          ),
        ],
      ),
      
      // 나머지 Feature 라우트
      GoRoute(path: '/jobs', builder: (context, state) => const DummyScreen(title: 'Lowongan Kerja')),
      GoRoute(path: '/auction', builder: (context, state) => const DummyScreen(title: 'Lelang')),
      GoRoute(path: '/clubs', builder: (context, state) => const DummyScreen(title: 'Komunitas')),
      GoRoute(path: '/lost-found', builder: (context, state) => const DummyScreen(title: 'Barang Hilang')),
      GoRoute(path: '/pom', builder: (context, state) => const DummyScreen(title: 'Pamer!')),
      GoRoute(path: '/real-estate', builder: (context, state) => const DummyScreen(title: 'Properti')),
      GoRoute(path: '/together', builder: (context, state) => const DummyScreen(title: 'Bareng Yuk!')),
    ],
  );
});
