import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:easy_localization/easy_localization.dart';
import '../providers/deal_provider.dart';
import '../providers/marketplace_provider.dart';
import '../models/deal_model.dart';
import '../../../core/utils/formatters.dart';

class DealDetailScreen extends ConsumerStatefulWidget {
  final String dealId;

  const DealDetailScreen({super.key, required this.dealId});

  @override
  ConsumerState<DealDetailScreen> createState() => _DealDetailScreenState();
}

class _DealDetailScreenState extends ConsumerState<DealDetailScreen> {
  final _codeController = TextEditingController();
  bool _isLoading = false;
  String? _errorMsg;

  @override
  void dispose() {
    _codeController.dispose();
    super.dispose();
  }

  Future<void> _verifyCode(DealModel deal) async {
    final userId = ref.read(currentMarketplaceUserIdProvider);
    if (userId == null) return;
    final code = _codeController.text.trim();
    if (code.isEmpty) return;

    setState(() {
      _isLoading = true;
      _errorMsg = null;
    });

    try {
      final repo = ref.read(dealRepositoryProvider);
      await repo.verifySellerConfirmationCode(
        dealId: deal.id,
        sellerId: userId,
        inputCode: code,
      );
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('marketplace.dealCompleted'.tr())),
        );
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          _errorMsg = e.toString().replaceAll('Exception: ', '');
        });
      }
    } finally {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  Widget _buildBuyerCodeSection(DealModel deal) {
    final codeAsync = ref.watch(buyerDealCodeProvider(deal.id));
    return codeAsync.when(
      data: (codeModel) {
        if (codeModel == null) return const Text('Code not found');
        return Column(
          children: [
            Text(
              'marketplace.showThisCodeToSeller'.tr(),
              textAlign: TextAlign.center,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
              decoration: BoxDecoration(
                color: Colors.grey.shade200,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.grey.shade400),
              ),
              child: Text(
                codeModel.confirmationCode,
                style: const TextStyle(
                  fontSize: 32,
                  letterSpacing: 8,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(height: 16),
            Text(
              'Expires: ${DateFormat('yyyy-MM-dd HH:mm').format(deal.codeExpiresAt.toLocal())}',
              style: const TextStyle(color: Colors.grey),
            ),
          ],
        );
      },
      loading: () => const CircularProgressIndicator(),
      error: (e, st) => Text('Error: $e'),
    );
  }

  Widget _buildSellerInputSection(DealModel deal) {
    if (deal.status == 'completed') {
      return Container(
        padding: const EdgeInsets.all(16),
        color: Colors.green.shade100,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.check_circle, color: Colors.green),
            const SizedBox(width: 8),
            Text('marketplace.dealCompleted'.tr(),
                style: const TextStyle(color: Colors.green, fontWeight: FontWeight.bold)),
          ],
        ),
      );
    }

    if (deal.status == 'code_locked') {
      return Container(
        padding: const EdgeInsets.all(16),
        color: Colors.red.shade100,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.lock, color: Colors.red),
            const SizedBox(width: 8),
            Text('marketplace.codeLocked'.tr(),
                style: const TextStyle(color: Colors.red, fontWeight: FontWeight.bold)),
          ],
        ),
      );
    }

    if (deal.status == 'expired') {
      return Text('marketplace.codeExpired'.tr(), style: const TextStyle(color: Colors.red));
    }

    if (deal.status == 'canceled') {
      return const Text('Deal Canceled', style: TextStyle(color: Colors.red));
    }

    final remaining = deal.maxCodeAttempts - deal.codeAttemptCount;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          'marketplace.enterBuyerCode'.tr(),
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8),
        TextField(
          controller: _codeController,
          decoration: InputDecoration(
            hintText: 'e.g. AB12XY',
            border: const OutlineInputBorder(),
            errorText: _errorMsg,
          ),
          textCapitalization: TextCapitalization.characters,
          maxLength: 6,
        ),
        Text(
          '${'marketplace.remainingAttempts'.tr()}: $remaining',
          style: TextStyle(
              color: remaining <= 2 ? Colors.red : Colors.grey, fontSize: 12),
        ),
        const SizedBox(height: 16),
        ElevatedButton(
          onPressed: _isLoading ? null : () => _verifyCode(deal),
          child: _isLoading
              ? const SizedBox(
                  width: 20, height: 20, child: CircularProgressIndicator())
              : Text('marketplace.confirmDeal'.tr()),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final dealAsync = ref.watch(dealByIdProvider(widget.dealId));
    final userId = ref.watch(currentMarketplaceUserIdProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text('marketplace.codDeal'.tr()),
      ),
      body: dealAsync.when(
        data: (deal) {
          if (deal == null) {
            return const Center(child: Text('Deal not found'));
          }
          if (userId == null) {
            return const Center(child: CircularProgressIndicator());
          }

          final isBuyer = userId == deal.buyerId;
          final isSeller = userId == deal.sellerId;

          if (!isBuyer && !isSeller) {
            return const Center(child: Text('Unauthorized'));
          }

          return SingleChildScrollView(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // Product Info
                Row(
                  children: [
                    if (deal.productImageUrl != null)
                      ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: Image.network(
                          deal.productImageUrl!,
                          width: 80,
                          height: 80,
                          fit: BoxFit.cover,
                        ),
                      )
                    else
                      Container(
                        width: 80,
                        height: 80,
                        color: Colors.grey.shade300,
                        child: const Icon(Icons.image),
                      ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            deal.productTitle,
                            style: Theme.of(context).textTheme.titleMedium,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                          const SizedBox(height: 4),
                          Text(
                            'Rp ${NumberFormat('#,###', 'id_ID').format(deal.amount)}',
                            style: Theme.of(context).textTheme.titleSmall?.copyWith(
                                  color: Theme.of(context).primaryColor,
                                  fontWeight: FontWeight.bold,
                                ),
                          ),
                          const SizedBox(height: 4),
                          Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 8, vertical: 2),
                            decoration: BoxDecoration(
                              color: _getStatusColor(deal.status),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Text(
                              deal.status.toUpperCase(),
                              style: const TextStyle(
                                  color: Colors.white, fontSize: 10),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 32),
                const Divider(),
                const SizedBox(height: 32),
                if (isBuyer)
                  _buildBuyerCodeSection(deal)
                else
                  _buildSellerInputSection(deal),
              ],
            ),
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, st) => Center(child: Text('Error: $e')),
      ),
    );
  }

  Color _getStatusColor(String status) {
    switch (status) {
      case 'completed':
        return Colors.green;
      case 'confirmed':
        return Colors.blue;
      case 'expired':
      case 'canceled':
      case 'code_locked':
        return Colors.red;
      default:
        return Colors.grey;
    }
  }
}
