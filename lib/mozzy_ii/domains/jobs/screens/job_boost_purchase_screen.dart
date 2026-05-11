import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:go_router/go_router.dart';
import '../providers/job_provider.dart';
import '../../monetization/providers/boost_package_provider.dart';
import '../../monetization/models/boost_package_model.dart';
import '../../payments/providers/payment_action_provider.dart';
import '../../payments/models/payment_provider_type.dart';
import '../../../core/config/beta_feature_flags.dart';
import '../widgets/job_boost_package_card.dart';

class JobBoostPurchaseScreen extends ConsumerStatefulWidget {
  final String jobId;

  const JobBoostPurchaseScreen({
    super.key,
    required this.jobId,
  });

  @override
  ConsumerState<JobBoostPurchaseScreen> createState() => _JobBoostPurchaseScreenState();
}

class _JobBoostPurchaseScreenState extends ConsumerState<JobBoostPurchaseScreen> {
  BoostPackageModel? selectedPackage;

  @override
  Widget build(BuildContext context) {
    final jobAsync = ref.watch(jobDetailProvider(widget.jobId));
    final packages = ref.watch(jobBoostPackagesProvider);
    final paymentState = ref.watch(paymentActionProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text('monetization.boostLowongan'.tr()),
      ),
      body: jobAsync.when(
        data: (job) {
          if (job == null) {
            return Center(child: Text('common.error'.tr()));
          }

          // Initial selection
          selectedPackage ??= packages.isNotEmpty ? packages.first : null;

          return SingleChildScrollView(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // Job Summary Card
                Card(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          job.title,
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(job.companyName),
                      ],
                    ),
                  ),
                ),
                if (BetaFeatureFlags.isPrivateBeta && !BetaFeatureFlags.isPaymentProduction()) ...[
                  const SizedBox(height: 16),
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Colors.orange.shade100,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Row(
                      children: [
                        const Icon(Icons.warning_amber_rounded, color: Colors.orange),
                        const SizedBox(width: 8),
                        Expanded(
                          child: Text(
                            'beta.sandboxOnly'.tr(),
                            style: const TextStyle(color: Colors.deepOrange),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
                const SizedBox(height: 24),
                Text(
                  'monetization.chooseBoostPackage'.tr(),
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 12),
                ...packages.map((pkg) => JobBoostPackageCard(
                  package: pkg,
                  isSelected: selectedPackage?.id == pkg.id,
                  onTap: () => setState(() => selectedPackage = pkg),
                )),
                const SizedBox(height: 32),
                ElevatedButton(
                  onPressed: paymentState.isLoading || selectedPackage == null
                      ? null
                      : () => _handlePayment(context),
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                  ),
                  child: paymentState.isLoading
                      ? const CircularProgressIndicator()
                      : Text('monetization.payNow'.tr()),
                ),
              ],
            ),
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => Center(child: Text('Error: $e')),
      ),
    );
  }

  Future<void> _handlePayment(BuildContext context) async {
    if (selectedPackage == null) return;

    final result = await ref.read(paymentActionProvider.notifier).createJobBoostPayment(
      jobId: widget.jobId,
      packageId: selectedPackage!.id,
      provider: PaymentProviderType.xendit,
    );

    if (!context.mounted) return;

    if (result != null) {
      context.push('/payments/${result.paymentId}');
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('monetization.createPaymentFailed'.tr())),
      );
    }
  }
}
