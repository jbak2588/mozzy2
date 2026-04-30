// ============================================================================
// Mozzy DocHeader
// Module        : Marketplace Domain
// File          : lib/mozzy_ii/domains/marketplace/services/in_memory_marketplace_ai_verification_service.dart
// Purpose       : 테스트 및 통합 테스트용 가짜 AI 검수 서비스.
// ============================================================================

import 'package:uuid/uuid.dart';
import '../models/ai_verification_result.dart';
import 'marketplace_ai_verification_service.dart';

class InMemoryMarketplaceAiVerificationService implements MarketplaceAiVerificationService {
  @override
  Future<AiVerificationResult> verifyProductImages({
    required String productId,
    required String title,
    required String description,
    required String category,
    required List<String> imageUrls,
  }) async {
    // 1초 지연 후 결정론적 결과 반환
    await Future.delayed(const Duration(seconds: 1));
    
    return AiVerificationResult(
      id: const Uuid().v4(),
      productId: productId,
      status: 'passed',
      score: 0.92,
      summary: 'AI verification passed in integration mode.',
      detectedIssues: [],
      suggestedCategory: category,
      conditionLabel: 'used',
      createdAt: DateTime.now().toUtc(),
    );
  }
}
