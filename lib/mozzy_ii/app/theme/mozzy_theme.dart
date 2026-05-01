import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MozzyTheme {
  // 브랜드 컬러 (인도네시아 국기 빨강)
  static const Color primaryRed = Color(0xFFCC0001);
  static const Color accentRed = Color(0xFFE63946);
  static const Color backgroundLight = Color(0xFFF8F9FA);
  static const Color textPrimary = Color(0xFF212529);

  static ThemeData get lightTheme {
    final baseTheme = ThemeData.light(useMaterial3: true);

    return baseTheme.copyWith(
      colorScheme: ColorScheme.fromSeed(
        seedColor: primaryRed,
        primary: primaryRed,
        secondary: accentRed,
        surface: backgroundLight,
      ),
      // 전역 폰트를 Nunito Sans로 설정
      textTheme: GoogleFonts.nunitoSansTextTheme(
        baseTheme.textTheme,
      ).apply(bodyColor: textPrimary, displayColor: textPrimary),
      appBarTheme: const AppBarTheme(
        backgroundColor: Colors.white,
        foregroundColor: textPrimary,
        elevation: 0,
        centerTitle: true,
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: primaryRed,
          foregroundColor: Colors.white,
          minimumSize: const Size(88, 48), // 터치 영역 최소 48dp 기준 준수
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          textStyle: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
        ),
      ),
      bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        selectedItemColor: primaryRed,
        unselectedItemColor: Colors.grey,
        showUnselectedLabels: true,
        type: BottomNavigationBarType.fixed,
      ),
    );
  }
}
