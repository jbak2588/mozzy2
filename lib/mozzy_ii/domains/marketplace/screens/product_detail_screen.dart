import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:easy_localization/easy_localization.dart';
import '../../../core/utils/formatters.dart';
import '../../../trust/widgets/trust_score_badge.dart';
import '../providers/marketplace_provider.dart';
import '../models/product_model.dart';

class ProductDetailScreen extends ConsumerWidget {
  const ProductDetailScreen({
    super.key,
    required this.productId,
  });

  final String productId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final productAsync = ref.watch(productByIdProvider(productId));

    return Scaffold(
      key: const Key('productDetailScreen'),
      appBar: AppBar(
        title: Text('marketplace.detailTitle'.tr()),
      ),
      body: productAsync.when(
        data: (product) {
          if (product == null) {
            return Center(child: Text('marketplace.notFound'.tr()));
          }
          return _ProductDetailContent(product: product);
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (err, _) => Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('common.error'.tr()),
              const SizedBox(height: 8),
              ElevatedButton(
                onPressed: () => ref.invalidate(productByIdProvider(productId)),
                child: Text('common.retry'.tr()),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _ProductDetailContent extends StatelessWidget {
  final ProductModel product;

  const _ProductDetailContent({required this.product});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildImageArea(context),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildHeader(context),
                const Divider(height: 32),
                _buildDescription(context),
                const Divider(height: 32),
                _buildSellerInfo(context),
                const Divider(height: 32),
                _buildAiVerification(context),
                const SizedBox(height: 32),
                _buildStats(context),
                const SizedBox(height: 32),
                _buildActions(context),
                const SizedBox(height: 32),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildImageArea(BuildContext context) {
    final hasImages = product.imageUrls.isNotEmpty;

    return AspectRatio(
      aspectRatio: 1,
      child: Container(
        key: const Key('productDetailImagePlaceholder'),
        color: Colors.grey[200],
        width: double.infinity,
        child: hasImages
            ? Image.network(
                product.imageUrls.first,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) => const Center(
                  child: Icon(Icons.broken_image, size: 64, color: Colors.grey),
                ),
              )
            : Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(Icons.image, size: 100, color: Colors.grey),
                    const SizedBox(height: 16),
                    Text(
                      'marketplace.noImage'.tr(),
                      style: const TextStyle(color: Colors.grey, fontSize: 18),
                    ),
                  ],
                ),
              ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Text(
                product.title,
                style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
              ),
            ),
            const SizedBox(width: 8),
            TrustScoreBadge(score: product.trustScore),
          ],
        ),
        const SizedBox(height: 8),
        Text(
          MozzyFormatters.formatIDR(product.price),
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Theme.of(context).primaryColor,
          ),
        ),
        const SizedBox(height: 8),
        Wrap(
          crossAxisAlignment: WrapCrossAlignment.center,
          spacing: 8,
          children: [
            Text(
              'marketplace.category.${product.category}'.tr(),
              style: TextStyle(color: Colors.grey[600]),
            ),
            const Text('•'),
            const Icon(Icons.location_on, size: 14, color: Colors.grey),
            Text(
              '${product.locationParts?.idAddress?.kecamatan ?? ''}, ${product.locationParts?.idAddress?.kabupaten ?? ''}',
              style: TextStyle(color: Colors.grey[600]),
            ),
          ],
        ),
        const SizedBox(height: 8),
        Text(
          '${'marketplace.createdAt'.tr()}: ${MozzyFormatters.formatDateID(product.createdAt)}',
          style: Theme.of(context).textTheme.bodySmall,
        ),
      ],
    );
  }

  Widget _buildDescription(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'marketplace.description'.tr(),
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
        ),
        const SizedBox(height: 8),
        Text(product.description),
      ],
    );
  }

  Widget _buildSellerInfo(BuildContext context) {
    final sellerId = product.userId;
    final displayId = sellerId.length > 8 ? '${sellerId.substring(0, 8)}...' : sellerId;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'marketplace.seller'.tr(),
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
        ),
        const SizedBox(height: 8),
        Row(
          children: [
            CircleAvatar(
              backgroundColor: Colors.grey[300],
              child: const Icon(Icons.person, color: Colors.white),
            ),
            const SizedBox(width: 12),
            Text(
              'User ID: $displayId',
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildAiVerification(BuildContext context) {
    final statusColor = product.isAiVerified ? Colors.green : (product.aiVerificationStatus == 'failed' ? Colors.red : Colors.orange);
    final bgColor = product.isAiVerified ? Colors.green[50] : (product.aiVerificationStatus == 'failed' ? Colors.red[50] : Colors.orange[50]);
    final borderColor = product.isAiVerified ? Colors.green[100] : (product.aiVerificationStatus == 'failed' ? Colors.red[100] : Colors.orange[100]);

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: borderColor!),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.auto_awesome, color: statusColor),
              const SizedBox(width: 8),
              Text(
                'marketplace.aiVerified'.tr(),
                style: TextStyle(
                  color: statusColor,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const Spacer(),
              if (product.isAiVerified)
                Icon(Icons.check_circle, color: statusColor)
              else if (product.aiVerificationStatus == 'failed')
                Icon(Icons.error_outline, color: statusColor)
              else
                const Icon(Icons.help_outline, color: Colors.grey),
            ],
          ),
          const SizedBox(height: 12),
          _buildAiRow('marketplace.aiStatus'.tr(), product.aiVerificationStatus),
          if (product.aiVerificationScore != null)
            _buildAiRow('marketplace.aiScore'.tr(), '${(product.aiVerificationScore! * 100).toStringAsFixed(0)}%'),
          if (product.aiConditionLabel != null)
            _buildAiRow('marketplace.aiCondition'.tr(), product.aiConditionLabel!),
          if (product.aiSuggestedCategory != null)
            _buildAiRow('marketplace.aiSuggestedCategory'.tr(), product.aiSuggestedCategory!),
          if (product.aiVerificationSummary != null && product.aiVerificationSummary!.isNotEmpty) ...[
            const SizedBox(height: 8),
            Text(
              'marketplace.aiSummary'.tr(),
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13),
            ),
            Text(
              product.aiVerificationSummary!,
              style: const TextStyle(fontSize: 13),
            ),
          ],
          if (product.aiDetectedIssues.isNotEmpty) ...[
            const SizedBox(height: 8),
            Text(
              'marketplace.aiDetectedIssues'.tr(),
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13, color: Colors.red),
            ),
            ...product.aiDetectedIssues.map((issue) => Text('• $issue', style: const TextStyle(fontSize: 12, color: Colors.red))),
          ],
        ],
      ),
    );
  }

  Widget _buildAiRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 4),
      child: Row(
        children: [
          Text('$label: ', style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w500)),
          Text(value, style: const TextStyle(fontSize: 13)),
        ],
      ),
    );
  }

  Widget _buildStats(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        _buildStatItem(Icons.visibility_outlined, product.viewsCount.toString(), 'marketplace.views'.tr()),
        _buildStatItem(Icons.favorite_border, product.likesCount.toString(), 'marketplace.likes'.tr()),
        _buildStatItem(Icons.chat_bubble_outline, product.chatsCount.toString(), 'marketplace.chats'.tr()),
      ],
    );
  }

  Widget _buildStatItem(IconData icon, String value, String label) {
    return Column(
      children: [
        Icon(icon, color: Colors.grey),
        const SizedBox(height: 4),
        Text(value, style: const TextStyle(fontWeight: FontWeight.bold)),
        Text(label, style: const TextStyle(fontSize: 12, color: Colors.grey)),
      ],
    );
  }

  Widget _buildActions(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          width: double.infinity,
          height: 50,
          child: ElevatedButton.icon(
            onPressed: null, // Placeholder: Disabled
            icon: const Icon(Icons.chat),
            label: Text('marketplace.chatSeller'.tr()),
            style: ElevatedButton.styleFrom(
              backgroundColor: Theme.of(context).primaryColor,
              foregroundColor: Colors.white,
              disabledBackgroundColor: Colors.grey,
            ),
          ),
        ),
        const SizedBox(height: 12),
        Row(
          children: [
            Expanded(
              child: OutlinedButton.icon(
                onPressed: null, // Placeholder: Disabled
                icon: const Icon(Icons.favorite_border),
                label: Text('marketplace.save'.tr()),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: OutlinedButton.icon(
                onPressed: null, // Placeholder: Disabled
                icon: const Icon(Icons.report_outlined),
                label: Text('marketplace.report'.tr()),
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        Text(
          'marketplace.comingSoon'.tr(),
          style: const TextStyle(color: Colors.grey, fontStyle: FontStyle.italic),
        ),
      ],
    );
  }
}
