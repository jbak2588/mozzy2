// ============================================================================
// Mozzy DocHeader
// Module        : Marketplace Domain
// File          : lib/mozzy_ii/domains/marketplace/services/in_memory_marketplace_image_upload_service.dart
// Purpose       : 테스트를 위한 인메모리 이미지 업로드 서비스. 가짜 URL을 반환합니다.
// ============================================================================

import 'package:image_picker/image_picker.dart';
import 'marketplace_image_upload_service.dart';

class InMemoryMarketplaceImageUploadService
    implements MarketplaceImageUploadService {
  @override
  Future<List<String>> uploadProductImages({
    required String productId,
    required String sellerId,
    required List<XFile> images,
  }) async {
    if (images.isEmpty) {
      throw ArgumentError('Images list cannot be empty');
    }
    if (images.length > 5) {
      throw ArgumentError('Maximum 5 images allowed');
    }

    // Return deterministic fake URLs for testing
    return List.generate(images.length, (i) {
      return 'https://example.test/marketplace/$productId/image_$i.jpg';
    });
  }
}
