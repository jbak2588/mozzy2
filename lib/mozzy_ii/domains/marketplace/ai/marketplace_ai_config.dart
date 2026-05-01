// ============================================================================
// Mozzy DocHeader
// Module        : Marketplace Domain
// File          : lib/mozzy_ii/domains/marketplace/ai/marketplace_ai_config.dart
// Purpose       : Marketplace AI 설정. Gemini API 키 및 모델 설정을 관리합니다.
// ============================================================================

class MarketplaceAiConfig {
  /// Gemini API Key (dart-define을 통해 주입받습니다)
  static const String geminiApiKey = String.fromEnvironment(
    'GEMINI_API_KEY',
    defaultValue: '',
  );

  /// Gemini Vision Model
  static const String geminiModel = String.fromEnvironment(
    'GEMINI_VISION_MODEL',
    defaultValue: 'gemini-3-flash-preview',
  );

  /// API 키 존재 여부 확인
  static bool get hasApiKey => geminiApiKey.trim().isNotEmpty;
}
