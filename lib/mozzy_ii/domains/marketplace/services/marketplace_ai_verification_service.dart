// ============================================================================
// Mozzy DocHeader
// Module        : Marketplace Domain
// File          : lib/mozzy_ii/domains/marketplace/services/marketplace_ai_verification_service.dart
// Purpose       : Marketplace AI 검수 서비스 인터페이스.
// ============================================================================

import 'package:image_picker/image_picker.dart';
import '../models/ai_verification_result.dart';

abstract class MarketplaceAiVerificationService {
  Future<AiVerificationResult> verifyProductImages({
    required String productId,
    required String title,
    required String description,
    required String category,
    required List<String> imageUrls,
    List<XFile> imageFiles = const [],
  });
}
