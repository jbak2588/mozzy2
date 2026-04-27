import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:easy_localization/easy_localization.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  // 1. EasyLocalization 초기화
  await EasyLocalization.ensureInitialized();

  // 2. Firebase 초기화
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

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

class MozzyApp extends StatelessWidget {
  const MozzyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Mozzy Indonesia',
      localizationsDelegates: context.localizationDelegates,
      supportedLocales: context.supportedLocales,
      locale: context.locale,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFFCC0001)),
        useMaterial3: true,
      ),
      home: const Scaffold(
        body: Center(
          child: Text('Mozzy Version 2 - Firebase & Riverpod Initialized'),
        ),
      ),
    );
  }
}
