import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'main_scaffold.dart';
import '../auth/auth_gate.dart';
import '../../geo/screens/location_permission_screen.dart';
import '../../geo/screens/shared_map_browser_screen.dart';
import '../../discovery/screens/home_screen.dart';
import '../../dev/profile_screen.dart';
import '../../domains/news/screens/local_news_list_screen.dart';
import '../../domains/news/screens/create_post_screen.dart';
import '../../domains/news/screens/local_news_detail_screen.dart';
import '../../domains/marketplace/screens/create_product_screen.dart';
import '../../domains/marketplace/screens/marketplace_list_screen.dart';
import '../../domains/marketplace/screens/product_detail_screen.dart';
import '../../domains/marketplace/screens/saved_marketplace_screen.dart';
import '../../domains/marketplace/screens/admin_review_screen.dart';
import '../../domains/marketplace/screens/admin_audit_log_screen.dart';
import '../../domains/marketplace/screens/admin_guard_screen.dart';
import '../../domains/marketplace/screens/deals_list_screen.dart';
import '../../domains/marketplace/screens/deal_detail_screen.dart';
import '../../domains/chat/screens/chat_list_screen.dart';
import '../../domains/chat/screens/chat_detail_screen.dart';
import '../../domains/notifications/screens/notification_list_screen.dart';
import '../../domains/jobs/screens/jobs_list_screen.dart';
import '../../domains/jobs/screens/job_detail_screen.dart';
import '../../domains/jobs/screens/create_job_screen.dart';
import '../../domains/jobs/screens/my_jobs_screen.dart';
import '../../domains/jobs/screens/job_applicants_screen.dart';
import '../../domains/jobs/screens/job_boost_purchase_screen.dart';
import '../../domains/payments/screens/payment_status_screen.dart';
import '../../domains/monetization/screens/admin_monetization_audit_screen.dart';
import '../../domains/moderation/screens/admin_moderation_screen.dart';
import '../../domains/feed/screens/smart_feed_screen.dart';
import '../../core/config/beta_feature_flags.dart';
import '../../shared/screens/feature_coming_soon_screen.dart';
import '../../core/monitoring/screens/monitoring_debug_screen.dart';

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
      GoRoute(path: '/', builder: (context, state) => const AuthGate()),

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
                builder: (context, state) => const SmartFeedScreen(),
              ),
              GoRoute(
                path: '/legacy-home',
                builder: (context, state) => const HomeScreen(),
              ),
            ],
          ),
          // 탭 2: 마켓 (Jual)
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: '/marketplace',
                builder: (context, state) => const MarketplaceListScreen(),
                routes: [
                  GoRoute(
                    path: 'create',
                    builder: (context, state) => const CreateProductScreen(),
                  ),
                  GoRoute(
                    path: 'saved',
                    builder: (context, state) => const SavedMarketplaceScreen(),
                  ),
                  GoRoute(
                    path: 'admin-review',
                    builder: (context, state) => const MarketplaceAdminGuardScreen(
                      child: AdminReviewScreen(),
                    ),
                  ),
                  GoRoute(
                    path: 'admin-audit-logs',
                    builder: (context, state) => const MarketplaceAdminGuardScreen(
                      child: AdminAuditLogScreen(),
                    ),
                  ),
                  GoRoute(
                    path: 'deals',
                    builder: (context, state) => DealsListScreen(initialTab: state.uri.queryParameters['tab']),
                  ),
                  GoRoute(
                    path: 'deals/:dealId',
                    builder: (context, state) {
                      final dealId = state.pathParameters['dealId']!;
                      return DealDetailScreen(dealId: dealId);
                    },
                  ),
                  GoRoute(
                    path: ':productId',
                    builder: (context, state) {
                      final productId = state.pathParameters['productId']!;
                      return ProductDetailScreen(productId: productId);
                    },
                  ),
                ],
              ),
            ],
          ),
          // 탭 3: 뉴스 (Berita)
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: '/news',
                builder: (context, state) => const LocalNewsListScreen(),
                routes: [
                  GoRoute(
                    path: 'create',
                    builder: (context, state) => const CreatePostScreen(),
                  ),
                  GoRoute(
                    path: ':postId',
                    builder: (context, state) {
                      final postId = state.pathParameters['postId']!;
                      return LocalNewsDetailScreen(postId: postId);
                    },
                  ),
                ],
              ),
            ],
          ),
          // 탭 4: 동네 스토어 (Toko)
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: '/stores',
                builder: (context, state) => BetaFeatureFlags.isEnabled(MozzyFeatureKey.stores)
                    ? const DummyScreen(title: 'Toko Sekitar (Stores)')
                    : const FeatureComingSoonScreen(featureName: 'Toko Sekitar'),
              ),
            ],
          ),
          // 탭 5: 채팅 (Pesan)
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: '/chat',
                builder: (context, state) => const ChatListScreen(),
                routes: [
                  GoRoute(
                    path: ':roomId',
                    builder: (context, state) {
                      final roomId = state.pathParameters['roomId']!;
                      return ChatDetailScreen(roomId: roomId);
                    },
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
      
      GoRoute(
        path: '/feed',
        builder: (context, state) => const SmartFeedScreen(),
      ),

      // 나머지 Feature 라우트
      GoRoute(
        path: '/jobs',
        builder: (context, state) => const JobsListScreen(),
        routes: [
          GoRoute(
            path: 'create',
            builder: (context, state) => const CreateJobScreen(),
          ),
          GoRoute(
            path: 'my',
            builder: (context, state) => const MyJobsScreen(),
          ),
          GoRoute(
            path: ':jobId',
            builder: (context, state) {
              final jobId = state.pathParameters['jobId']!;
              return JobDetailScreen(jobId: jobId);
            },
            routes: [
              GoRoute(
                path: 'applicants',
                builder: (context, state) {
                  final jobId = state.pathParameters['jobId']!;
                  return JobApplicantsScreen(jobId: jobId);
                },
              ),
              GoRoute(
                path: 'boost',
                builder: (context, state) {
                  final jobId = state.pathParameters['jobId']!;
                  return JobBoostPurchaseScreen(jobId: jobId);
                },
              ),
            ],
          ),
        ],
      ),

      GoRoute(
        path: '/payments/:paymentId',
        builder: (context, state) {
          final paymentId = state.pathParameters['paymentId']!;
          return PaymentStatusScreen(paymentId: paymentId);
        },
      ),

      // Feature placeholder routes — must be available in debug and release
      GoRoute(
        path: '/auction',
        builder: (context, state) => BetaFeatureFlags.isEnabled(MozzyFeatureKey.auction)
            ? const DummyScreen(title: 'Lelang')
            : const FeatureComingSoonScreen(featureName: 'Lelang'),
      ),
      GoRoute(
        path: '/clubs',
        builder: (context, state) => BetaFeatureFlags.isEnabled(MozzyFeatureKey.clubs)
            ? const DummyScreen(title: 'Komunitas')
            : const FeatureComingSoonScreen(featureName: 'Komunitas'),
      ),
      GoRoute(
        path: '/lost-found',
        builder: (context, state) => BetaFeatureFlags.isEnabled(MozzyFeatureKey.lostFound)
            ? const DummyScreen(title: 'Barang Hilang')
            : const FeatureComingSoonScreen(featureName: 'Barang Hilang'),
      ),
      GoRoute(
        path: '/pom',
        builder: (context, state) => BetaFeatureFlags.isEnabled(MozzyFeatureKey.pom)
            ? const DummyScreen(title: 'Pamer!')
            : const FeatureComingSoonScreen(featureName: 'Pamer!'),
      ),
      GoRoute(
        path: '/real-estate',
        builder: (context, state) => BetaFeatureFlags.isEnabled(MozzyFeatureKey.realEstate)
            ? const DummyScreen(title: 'Properti')
            : const FeatureComingSoonScreen(featureName: 'Properti'),
      ),
      GoRoute(
        path: '/together',
        builder: (context, state) => BetaFeatureFlags.isEnabled(MozzyFeatureKey.together)
            ? const DummyScreen(title: 'Bareng Yuk!')
            : const FeatureComingSoonScreen(featureName: 'Bareng Yuk!'),
      ),
      // Dev-only debug routes
      if (kDebugMode) ...[
        GoRoute(
          path: '/dev/profile',
          builder: (context, state) => const DevProfileScreen(),
        ),
        GoRoute(
          path: '/dev/monitoring',
          builder: (context, state) => const MonitoringDebugScreen(),
        ),
      ],
      
      GoRoute(
        path: '/notifications',
        builder: (context, state) => const NotificationListScreen(),
      ),
      GoRoute(
        path: '/admin/monetization/audit',
        builder: (context, state) => const AdminMonetizationAuditScreen(),
      ),
      GoRoute(
        path: '/admin/moderation',
        builder: (context, state) => const AdminModerationScreen(),
      ),
    ],
  );
});
