// ============================================================================
// Mozzy DocHeader
// Module        : Marketplace Domain
// File          : test/mozzy_ii/domains/marketplace/marketplace_ai_verification_service_test.dart
// Purpose       : Marketplace AI 검수 서비스 단위 테스트.
// ============================================================================

import 'package:flutter_test/flutter_test.dart';
import 'package:mozzy/mozzy_ii/domains/marketplace/services/in_memory_marketplace_ai_verification_service.dart';

void main() {
  group('InMemoryMarketplaceAiVerificationService Tests', () {
    final service = InMemoryMarketplaceAiVerificationService();

    test('verifyProductImages returns deterministic passed result', () async {
      final result = await service.verifyProductImages(
        productId: 'prod_123',
        title: 'Test Laptop',
        description: 'Excellent condition',
        category: 'electronics',
        imageUrls: ['https://example.com/image.jpg'],
      );

      expect(result.productId, 'prod_123');
      expect(result.status, 'passed');
      expect(result.score, 0.92);
      expect(result.suggestedCategory, 'electronics');
      expect(result.conditionLabel, 'used');
      expect(result.detectedIssues, isEmpty);
    });
  });
}
