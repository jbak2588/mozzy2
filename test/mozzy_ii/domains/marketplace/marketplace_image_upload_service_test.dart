import 'package:flutter_test/flutter_test.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mozzy/mozzy_ii/domains/marketplace/services/in_memory_marketplace_image_upload_service.dart';

void main() {
  late InMemoryMarketplaceImageUploadService service;

  setUp(() {
    service = InMemoryMarketplaceImageUploadService();
  });

  group('InMemoryMarketplaceImageUploadService', () {
    test('uploadProductImages returns fake URLs with correct count', () async {
      final images = [XFile('path/to/img1.jpg'), XFile('path/to/img2.jpg')];

      final urls = await service.uploadProductImages(
        productId: 'prod123',
        sellerId: 'user456',
        images: images,
      );

      expect(urls.length, 2);
      expect(urls[0], 'https://example.test/marketplace/prod123/image_0.jpg');
      expect(urls[1], 'https://example.test/marketplace/prod123/image_1.jpg');
    });

    test(
      'uploadProductImages throws ArgumentError if images is empty',
      () async {
        expect(
          () => service.uploadProductImages(
            productId: 'prod123',
            sellerId: 'user456',
            images: [],
          ),
          throwsArgumentError,
        );
      },
    );

    test('uploadProductImages throws ArgumentError if images > 5', () async {
      final images = List.generate(6, (i) => XFile('path/to/img$i.jpg'));
      expect(
        () => service.uploadProductImages(
          productId: 'prod123',
          sellerId: 'user456',
          images: images,
        ),
        throwsArgumentError,
      );
    });
  });
}
