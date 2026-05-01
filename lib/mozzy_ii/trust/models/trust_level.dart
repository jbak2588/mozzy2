// ============================================================================
// Mozzy DocHeader
// Module        : Trust Layer
// File          : lib/mozzy_ii/trust/models/trust_level.dart
// Purpose       : 사용자의 신뢰 등급을 정의하고 관리합니다.
// ============================================================================

import 'package:flutter/material.dart';

/// 인도네시아 현지화된 신뢰 등급 열거형
enum TrustLevel {
  anggotaBaru, // Anggota Baru (New Member)
  terpercaya, // Terpercaya (Trusted)
  terverifikasi, // Terverifikasi (Verified)
  heroLokal; // Hero Lokal (Local Hero)

  /// 점수에 따른 등급 판별
  static TrustLevel fromScore(double score) {
    if (score >= 0.9) return TrustLevel.heroLokal;
    if (score >= 0.6) return TrustLevel.terverifikasi;
    if (score >= 0.3) return TrustLevel.terpercaya;
    return TrustLevel.anggotaBaru;
  }

  /// 등급별 표시 명칭 (i18n 키 반환)
  String get labelKey {
    return switch (this) {
      TrustLevel.anggotaBaru => 'trust.level.anggota_baru',
      TrustLevel.terpercaya => 'trust.level.terpercaya',
      TrustLevel.terverifikasi => 'trust.level.terverifikasi',
      TrustLevel.heroLokal => 'trust.level.hero_lokal',
    };
  }

  /// 등급별 대표 색상
  Color get color {
    return switch (this) {
      TrustLevel.anggotaBaru => Colors.grey,
      TrustLevel.terpercaya => Colors.blue,
      TrustLevel.terverifikasi => Colors.green,
      TrustLevel.heroLokal => Colors.orange,
    };
  }
}
