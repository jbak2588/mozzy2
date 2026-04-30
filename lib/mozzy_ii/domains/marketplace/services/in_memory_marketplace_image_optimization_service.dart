// ============================================================================
// Mozzy DocHeader
// Module        : Marketplace Domain
// File          : lib/mozzy_ii/domains/marketplace/services/in_memory_marketplace_image_optimization_service.dart
// Purpose       : 테스트를 위한 인메모리 이미지 최적화 서비스. 압축 없이 원본을 반환합니다.
// ============================================================================

import 'package:image_picker/image_picker.dart';
import 'marketplace_image_optimization_service.dart';

class InMemoryMarketplaceImageOptimizationService implements MarketplaceImageOptimizationService {
  @override
  Future<List<XFile>> optimizeProductImages(List<XFile> images) async {
    if (images.isEmpty) {
      throw ArgumentError('Images list cannot be empty');
    }
    if (images.length > 5) {
      throw ArgumentError('Maximum 5 images allowed');
    }

    // Return input images unchanged for testing
    return images;
  }
}
