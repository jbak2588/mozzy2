import 'package:flutter_test/flutter_test.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mozzy/mozzy_ii/domains/marketplace/services/in_memory_marketplace_image_optimization_service.dart';

void main() {
  late InMemoryMarketplaceImageOptimizationService service;

  setUp(() {
    service = InMemoryMarketplaceImageOptimizationService();
  });

  group('InMemoryMarketplaceImageOptimizationService', () {
    test('optimizeProductImages returns input images unchanged', () async {
      final images = [XFile('path/to/img1.jpg'), XFile('path/to/img2.jpg')];

      final optimized = await service.optimizeProductImages(images);

      expect(optimized.length, 2);
      expect(optimized[0].path, 'path/to/img1.jpg');
      expect(optimized[1].path, 'path/to/img2.jpg');
    });

    test(
      'optimizeProductImages throws ArgumentError if images is empty',
      () async {
        expect(() => service.optimizeProductImages([]), throwsArgumentError);
      },
    );

    test('optimizeProductImages throws ArgumentError if images > 5', () async {
      final images = List.generate(6, (i) => XFile('path/to/img$i.jpg'));
      expect(() => service.optimizeProductImages(images), throwsArgumentError);
    });
  });
}
