// ============================================================================
// Mozzy DocHeader
// Module        : Marketplace Domain
// File          : lib/mozzy_ii/domains/marketplace/screens/admin_review_screen.dart
// Purpose       : AI 검토 대기열 확인을 위한 관리자 화면 foundation.
// ============================================================================

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:go_router/go_router.dart';
import '../../../core/config/integration_test_config.dart';
import '../providers/marketplace_provider.dart';
import '../models/ai_review_queue_item_model.dart';

class AdminReviewScreen extends ConsumerWidget {
  const AdminReviewScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final queueAsync = ref.watch(aiReviewQueueProvider);

    return Scaffold(
      key: const Key('adminReviewScreen'),
      appBar: AppBar(
        title: Text('marketplace.adminReview'.tr()),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () => ref.invalidate(aiReviewQueueProvider),
          ),
        ],
      ),
      body: queueAsync.when(
        data: (items) {
          if (items.isEmpty) {
            return Center(
              key: const Key('adminReviewEmptyState'),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.check_circle_outline, size: 64, color: Colors.grey),
                  const SizedBox(height: 16),
                  Text(
                    'marketplace.noReviewItems'.tr(),
                    style: const TextStyle(fontSize: 18, color: Colors.grey),
                  ),
                ],
              ),
            );
          }

          return ListView.builder(
            key: const Key('adminReviewQueueList'),
            padding: const EdgeInsets.all(16),
            itemCount: items.length,
            itemBuilder: (context, index) {
              final item = items[index];
              return _buildQueueItemCard(context, item);
            },
          );
        },
        loading: () => Center(
          child: IntegrationTestConfig.enabled
              ? const Text('Loading Review Queue...')
              : const CircularProgressIndicator(),
        ),
        error: (err, stack) => Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('marketplace.adminReviewLoadFailed'.tr()),
              const SizedBox(height: 8),
              ElevatedButton(
                onPressed: () => ref.invalidate(aiReviewQueueProvider),
                child: Text('common.retry'.tr()),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildQueueItemCard(BuildContext context, AiReviewQueueItemModel item) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: InkWell(
        onTap: () {
          // Future: Navigate to detail with review controls
          context.push('/marketplace/${item.productId}');
        },
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Text(
                      'Product ID: ${item.productId}',
                      style: const TextStyle(fontWeight: FontWeight.bold),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  _buildStatusBadge(item.status),
                ],
              ),
              const SizedBox(height: 8),
              Text(
                '${'marketplace.reviewReason'.tr()}: ${item.reason}',
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(height: 12),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _buildPriorityBadge(item.priority),
                  Text(
                    DateFormat('yyyy-MM-dd HH:mm').format(item.createdAt.toLocal()),
                    style: const TextStyle(fontSize: 12, color: Colors.grey),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildStatusBadge(String status) {
    Color color;
    String label;

    switch (status) {
      case 'needs_review':
        color = Colors.orange;
        label = 'marketplace.needsReview'.tr();
        break;
      case 'failed':
        color = Colors.red;
        label = 'marketplace.reviewFailed'.tr();
        break;
      case 'error':
        color = Colors.grey;
        label = 'marketplace.reviewError'.tr();
        break;
      default:
        color = Colors.blue;
        label = status;
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(4),
        border: Border.all(color: color),
      ),
      child: Text(
        label,
        style: TextStyle(color: color, fontSize: 11, fontWeight: FontWeight.bold),
      ),
    );
  }

  Widget _buildPriorityBadge(String priority) {
    Color color;
    switch (priority) {
      case 'high':
      case 'urgent':
        color = Colors.red;
        break;
      case 'normal':
        color = Colors.blue;
        break;
      case 'low':
      default:
        color = Colors.grey;
    }

    return Row(
      children: [
        Icon(Icons.flag, size: 14, color: color),
        const SizedBox(width: 4),
        Text(
          '${'marketplace.reviewPriority'.tr()}: $priority',
          style: TextStyle(color: color, fontSize: 12, fontWeight: FontWeight.bold),
        ),
      ],
    );
  }
}
