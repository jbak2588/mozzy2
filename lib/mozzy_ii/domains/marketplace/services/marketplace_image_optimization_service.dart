// ============================================================================
// Mozzy DocHeader
// Module        : Marketplace Domain
// File          : lib/mozzy_ii/domains/marketplace/services/marketplace_image_optimization_service.dart
// Purpose       : Marketplace 물품 이미지 최적화 서비스. WebP 변환 및 압축을 담당합니다.
// ============================================================================

import 'package:flutter/foundation.dart';
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

      try {
        if (kDebugMode) debugPrint('[ImageOpt] optimizing image $i...');
        final result = await FlutterImageCompress.compressAndGetFile(
          image.path,
          targetPath,
          quality: 85,
          minWidth: 1600,
          minHeight: 1600,
          format: CompressFormat.webp,
        ).timeout(const Duration(seconds: 10));

        if (result == null) {
          if (kDebugMode) debugPrint('[ImageOpt] compression returned null for image $i, using original');
          optimizedImages.add(image);
        } else {
          if (kDebugMode) debugPrint('[ImageOpt] image $i optimized to WebP');
          optimizedImages.add(result);
        }
      } catch (e) {
        if (kDebugMode) {
          debugPrint('[ImageOpt] error or timeout during optimization of image $i: $e. Using original.');
        }
        optimizedImages.add(image);
      }
    }

    return optimizedImages;
  }
}
