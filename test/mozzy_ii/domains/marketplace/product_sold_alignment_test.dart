import 'package:flutter_test/flutter_test.dart';
import 'package:mozzy/mozzy_ii/domains/marketplace/models/product_model.dart';
import 'package:mozzy/mozzy_ii/domains/marketplace/repositories/in_memory_marketplace_repository.dart';
import 'package:mozzy/mozzy_ii/domains/marketplace/repositories/in_memory_deal_repository.dart';

void main() {
  group('Product Sold Alignment (P2-B23-C)', () {
    late InMemoryMarketplaceRepository marketplaceRepo;
    late InMemoryDealRepository dealRepo;

    setUp(() {
      marketplaceRepo = InMemoryMarketplaceRepository();
      dealRepo = InMemoryDealRepository(marketplaceRepo);
    });

    test('should mark product as sold when COD deal is completed', () async {
      // 1. Create a product
      final product = ProductModel(
        id: 'prod_1',
        userId: 'seller_1',
        title: 'Test Product',
        description: 'Description',
        category: 'electronics',
        price: 100000,
        geoPath: 'path',
        aiVerificationStatus: 'passed',
        isAiVerified: true,
        createdAt: DateTime.now(),
        status: ProductStatus.available,
      );
      await marketplaceRepo.createProduct(product);

      // 2. Create a COD deal
      final deal = await dealRepo.createCodDeal(
        product: product,
        buyerId: 'buyer_1',
      );
      expect(deal.status, 'confirmed');

      // 3. Verify product is now reserved
      var p = await marketplaceRepo.getProductById(product.id);
      expect(p?.status, ProductStatus.reserved);

      // 4. Complete the deal (simulate correct code entry)
      await dealRepo.verifySellerConfirmationCode(
        dealId: deal.id,
        sellerId: 'seller_1',
        inputCode: 'ABC123', // InMemory code
      );

      // 5. Verify deal is completed
      final updatedDeal = await dealRepo.getDealById(deal.id);
      expect(updatedDeal?.status, 'completed');

      // 6. CRITICAL: Verify product status is now sold
      p = await marketplaceRepo.getProductById(product.id);
      expect(p?.status, ProductStatus.sold);
    });
  });
}
