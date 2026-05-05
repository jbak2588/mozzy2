import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:easy_localization/easy_localization.dart';
import '../providers/deal_provider.dart';
import '../models/deal_model.dart';

class DealsListScreen extends ConsumerStatefulWidget {
  final String? initialTab;
  const DealsListScreen({super.key, this.initialTab});

  @override
  ConsumerState<DealsListScreen> createState() => _DealsListScreenState();
}

class _DealsListScreenState extends ConsumerState<DealsListScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this, initialIndex: widget.initialTab == 'sales' ? 1 : 0);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('marketplace.deals'.tr()),
        bottom: TabBar(
          controller: _tabController,
          tabs: [
            Tab(text: 'marketplace.purchases'.tr()),
            Tab(text: 'marketplace.sales'.tr()),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          _DealsListTab(dealsAsync: ref.watch(buyerDealsProvider), isSales: false),
          _DealsListTab(dealsAsync: ref.watch(sellerDealsProvider), isSales: true),
        ],
      ),
    );
  }
}

class _DealsListTab extends ConsumerWidget {
  final bool isSales;

  final AsyncValue<List<DealModel>> dealsAsync;

  const _DealsListTab({required this.dealsAsync, this.isSales = false});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return dealsAsync.when(
      data: (deals) {
        if (deals.isEmpty) {
          return Center(
              child: Padding(
                padding: const EdgeInsets.all(32.0),
                child: Text(
                  isSales
                      ? 'marketplace.noSalesDeals'.tr()
                      : 'marketplace.noBuyerDeals'.tr(),
                  textAlign: TextAlign.center,
                  style: const TextStyle(color: Colors.grey, height: 1.5),
                ),
              ),
            );
        }
        return ListView.builder(
          itemCount: deals.length,
          itemBuilder: (context, index) {
            final deal = deals[index];
            return ListTile(
              leading: deal.productImageUrl != null
                  ? ClipRRect(
                      borderRadius: BorderRadius.circular(4),
                      child: Image.network(
                        deal.productImageUrl!,
                        width: 50,
                        height: 50,
                        fit: BoxFit.cover,
                      ),
                    )
                  : Container(
                      width: 50,
                      height: 50,
                      color: Colors.grey.shade300,
                      child: const Icon(Icons.image),
                    ),
              title: Text(deal.productTitle),
              subtitle: Text(
                'Rp ${NumberFormat('#,###', 'id_ID').format(deal.amount)}\n${DateFormat('yyyy-MM-dd').format(deal.createdAt.toLocal())}',
              ),
              trailing: _buildStatusBadge(deal.status),
              isThreeLine: true,
              onTap: () {
                context.push('/marketplace/deals/${deal.id}');
              },
            );
          },
        );
      },
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (e, st) => Center(child: Text('Error: $e')),
    );
  }

  Widget _buildStatusBadge(String status) {
    Color color;
    switch (status) {
      case 'completed':
        color = Colors.green;
        break;
      case 'confirmed':
        color = Colors.blue;
        break;
      case 'expired':
      case 'canceled':
      case 'code_locked':
        color = Colors.red;
        break;
      default:
        color = Colors.grey;
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: color),
      ),
      child: Text(
        status.toUpperCase(),
        style: TextStyle(color: color, fontSize: 10, fontWeight: FontWeight.bold),
      ),
    );
  }
}
