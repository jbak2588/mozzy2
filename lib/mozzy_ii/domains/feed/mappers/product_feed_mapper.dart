import '../../marketplace/models/product_model.dart';
import '../models/feed_item_model.dart';
import '../models/feed_item_type.dart';

class ProductFeedMapper {
  static FeedItemModel map(ProductModel product) {
    return FeedItemModel(
      id: 'prod_${product.id}',
      sourceId: product.id,
      type: FeedItemType.marketplaceProduct,
      title: product.title,
      subtitle: 'Rp ${product.price}',
      description: product.description,
      imageUrl: product.imageUrls.isNotEmpty ? product.imageUrls.first : null,
      ownerId: product.userId,
      createdAt: product.createdAt,
      updatedAt: product.updatedAt,
      trustScore: product.trustScore,
      locationParts: product.locationParts,
      locationText: product.locationParts?.idAddress?.kecamatan,
      route: '/marketplace/${product.id}',
    );
  }
}
