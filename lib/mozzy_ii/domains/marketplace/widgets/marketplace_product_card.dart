import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:go_router/go_router.dart';
import '../../../core/utils/formatters.dart';
import '../../../trust/widgets/trust_score_badge.dart';
import '../models/product_model.dart';

class MarketplaceProductCard extends StatelessWidget {
  final ProductModel product;

  const MarketplaceProductCard({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return Card(
      key: Key('marketplaceProductCard_${product.id}'),
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: () => context.push('/marketplace/${product.id}'),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(child: _buildImage(context)),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    product.title,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    MozzyFormatters.formatIDR(product.price),
                    style: TextStyle(
                      color: Theme.of(context).primaryColor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          'marketplace.category.${product.category}'.tr(),
                          style: Theme.of(context).textTheme.bodySmall,
                        ),
                      ),
                      TrustScoreBadge(score: product.trustScore),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      const Icon(
                        Icons.location_on,
                        size: 12,
                        color: Colors.grey,
                      ),
                      const SizedBox(width: 2),
                      Expanded(
                        child: Text(
                          '${product.locationParts?.idAddress?.kecamatan ?? ''}, ${product.locationParts?.idAddress?.kabupaten ?? ''}',
                          style: Theme.of(context).textTheme.bodySmall,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      if (product.likesCount > 0) ...[
                        const SizedBox(width: 4),
                        const Icon(
                          Icons.favorite,
                          size: 10,
                          color: Colors.grey,
                        ),
                        const SizedBox(width: 2),
                        Text(
                          '${product.likesCount}',
                          style: Theme.of(context).textTheme.bodySmall,
                        ),
                      ],
                    ],
                  ),
                  if (product.isAiVerified) ...[
                    const SizedBox(height: 4),
                    Row(
                      children: [
                        const Icon(
                          Icons.auto_awesome,
                          size: 12,
                          color: Colors.red,
                        ),
                        const SizedBox(width: 4),
                        Text(
                          'marketplace.aiVerified'.tr(),
                          style: const TextStyle(
                            fontSize: 10,
                            color: Colors.red,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ] else if (product.aiVerificationStatus !=
                      'not_requested') ...[
                    const SizedBox(height: 4),
                    Text(
                      '${'marketplace.aiStatus'.tr()}: ${product.aiVerificationStatus}',
                      style: const TextStyle(fontSize: 10, color: Colors.grey),
                    ),
                  ],
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildImage(BuildContext context) {
    if (product.imageUrls.isEmpty) {
      return Container(
        key: const Key('marketplaceProductImagePlaceholder'),
        color: Colors.grey[200],
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.image, color: Colors.grey, size: 48),
              const SizedBox(height: 4),
              Text(
                'marketplace.noImage'.tr(),
                style: const TextStyle(color: Colors.grey, fontSize: 10),
              ),
            ],
          ),
        ),
      );
    }

    return Image.network(
      product.imageUrls.first,
      fit: BoxFit.cover,
      errorBuilder: (context, error, stackTrace) {
        return Container(
          key: const Key('marketplaceProductImagePlaceholder'),
          color: Colors.grey[200],
          child: const Center(
            child: Icon(Icons.broken_image, color: Colors.grey),
          ),
        );
      },
    );
  }
}
