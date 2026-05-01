// ============================================================================
// Mozzy DocHeader
// Module        : Marketplace Domain
// File          : lib/mozzy_ii/domains/marketplace/services/marketplace_image_upload_service.dart
// Purpose       : Marketplace 물품 이미지 업로드 서비스. Firebase Storage를 사용합니다.
// ============================================================================

import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';

class MarketplaceImageUploadService {
  final FirebaseStorage _storage;

  MarketplaceImageUploadService([FirebaseStorage? storage])
    : _storage = storage ?? FirebaseStorage.instance;

  /// 여러 이미지를 업로드하고 다운로드 URL 리스트를 반환합니다.
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

    final List<String> downloadUrls = [];

    for (int i = 0; i < images.length; i++) {
      final image = images[i];
      final fileName = 'image_$i.jpg'; // Simple naming for now
      final path = 'marketplace/products/$sellerId/$productId/$fileName';

      final ref = _storage.ref().child(path);

      // Platform-safe upload
      final uploadTask = ref.putFile(File(image.path));

      final snapshot = await uploadTask;
      final url = await snapshot.ref.getDownloadURL();
      downloadUrls.add(url);
    }

    return downloadUrls;
  }
}
