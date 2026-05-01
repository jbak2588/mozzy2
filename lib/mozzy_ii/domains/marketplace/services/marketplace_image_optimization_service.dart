// ============================================================================
// Mozzy DocHeader
// Module        : Marketplace Domain
// File          : lib/mozzy_ii/domains/marketplace/services/marketplace_image_optimization_service.dart
// Purpose       : Marketplace 물품 이미지 최적화 서비스. WebP 변환 및 압축을 담당합니다.
// ============================================================================

import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;

abstract class MarketplaceImageOptimizationService {
  Future<List<XFile>> optimizeProductImages(List<XFile> images);
}

class MarketplaceImageOptimizationServiceImpl
    implements MarketplaceImageOptimizationService {
  @override
  Future<List<XFile>> optimizeProductImages(List<XFile> images) async {
    if (images.isEmpty) {
      throw ArgumentError('Images list cannot be empty');
    }
    if (images.length > 5) {
      throw ArgumentError('Maximum 5 images allowed');
    }

    final List<XFile> optimizedImages = [];
    final tempDir = await getTemporaryDirectory();
    final timestamp = DateTime.now().millisecondsSinceEpoch;

    for (int i = 0; i < images.length; i++) {
      final image = images[i];
      final targetPath = p.join(
        tempDir.path,
        'marketplace_${timestamp}_$i.webp',
      );

      final result = await FlutterImageCompress.compressAndGetFile(
        image.path,
        targetPath,
        quality: 85,
        minWidth: 1600,
        minHeight: 1600,
        format: CompressFormat.webp,
      );

      if (result == null) {
        throw Exception('Image optimization failed for image at index $i');
      }

      optimizedImages.add(result);
    }

    return optimizedImages;
  }
}
