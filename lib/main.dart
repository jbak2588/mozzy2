import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:intl/date_symbol_data_local.dart'; // 추가
import 'firebase_options.dart';
import 'mozzy_ii/app/auth/google_sign_in_config.dart';
import 'mozzy_ii/domains/marketplace/ai/marketplace_ai_config.dart';

import 'mozzy_ii/app/theme/mozzy_theme.dart';
import 'mozzy_ii/app/navigation/app_router.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // 1. EasyLocalization 초기화
  await EasyLocalization.ensureInitialized();

  // 2. 날짜 포맷팅 초기화 (인도네시아어 지원)
  await initializeDateFormatting('id_ID', null);

  // 3. Firebase 초기화
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  // 3.5 Google Sign-In 초기화 (dart-define로 Web Client ID 주입 필요)
  await GoogleSignInConfig.initialize();

  // 3.6 Marketplace AI Config 로그 (디버그용)
  MarketplaceAiConfig.logConfig();

  runApp(
    ProviderScope(
      child: EasyLocalization(
        supportedLocales: const [Locale('id'), Locale('en'), Locale('ko')],
        path: 'assets/translations', // 번역 파일 경로
        fallbackLocale: const Locale('id'), // 기본 언어
        child: const MozzyApp(),
      ),
    ),
  );
}

class MozzyApp extends ConsumerWidget {
  const MozzyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final router = ref.watch(routerProvider);

    return MaterialApp.router(
      title: 'Mozzy Indonesia',
      localizationsDelegates: context.localizationDelegates,
      supportedLocales: context.supportedLocales,
      locale: context.locale,
      theme: MozzyTheme.lightTheme,
      routerConfig: router,
    );
  }
}
