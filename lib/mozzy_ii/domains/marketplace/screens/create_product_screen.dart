import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import 'package:uuid/uuid.dart';
import 'dart:io';
import 'dart:async';

import '../../../core/utils/scaffold_messenger_service.dart';
import '../../../geo/utils/geo_path_builder.dart';
import '../../../geo/utils/default_indonesia_location.dart';
import '../../../geo/models/location_parts.dart';
import '../models/product_model.dart';
import '../models/ai_verification_report_model.dart';
import '../providers/marketplace_provider.dart';
import '../providers/marketplace_location_provider.dart';
import 'package:flutter/foundation.dart';
import '../../../core/config/integration_test_config.dart';

class CreateProductScreen extends ConsumerStatefulWidget {
  const CreateProductScreen({super.key});

  @override
  ConsumerState<CreateProductScreen> createState() =>
      _CreateProductScreenState();
}

class _CreateProductScreenState extends ConsumerState<CreateProductScreen> {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _priceController = TextEditingController();

  String _selectedCategory = 'electronics';
  bool _isSaving = false;
  String _savingStatus = 'optimizing'; // optimizing | uploading | verifying
  List<XFile> _selectedImages = [];

  final _categories = [
    'electronics',
    'fashion',
    'home',
    'baby',
    'sports',
    'vehicles',
    'books',
    'other',
  ];

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    _priceController.dispose();
    super.dispose();
  }

  int? _parsePrice(String value) {
    // Remove Rp, dots, commas and spaces
    final cleaned = value
        .replaceAll('Rp', '')
        .replaceAll('.', '')
        .replaceAll(',', '')
        .trim();
    final parsed = int.tryParse(cleaned);
    if (parsed == null || parsed <= 0) return null;
    return parsed;
  }

  Future<void> _pickImages() async {
    final picker = ImagePicker();
    try {
      final images = await picker.pickMultiImage(
        imageQuality: 70, // Basic optimization
      );
      if (images.isNotEmpty) {
        setState(() {
          // Limit to 5 images total
          final total = [..._selectedImages, ...images];
          _selectedImages = total.take(5).toList();
        });
      }
    } catch (e) {
      debugPrint('Error picking images: $e');
    }
  }

  void _removeImage(int index) {
    setState(() {
      _selectedImages.removeAt(index);
    });
  }

  Future<void> _submit() async {
    if (_isSaving) return;

    if (_formKey.currentState!.validate()) {
      if (_selectedImages.isEmpty) {
        ScaffoldMessengerService.showError(
          context,
          'marketplace.imageRequired'.tr(),
        );
        return;
      }

      setState(() => _isSaving = true);

      final userId = ref.read(currentMarketplaceUserIdProvider);
      if (userId == null) {
        if (!mounted) return;
        ScaffoldMessengerService.showError(
          context,
          'marketplace.loginRequired'.tr(),
        );
        setState(() => _isSaving = false);
        return;
      }

      if (kDebugMode) debugPrint('[CreateProduct] loading effective location...');
      LocationParts location;
      try {
        location = await ref
            .read(effectiveMarketplaceLocationProvider.future)
            .timeout(const Duration(seconds: 8));
      } catch (e) {
        if (kDebugMode) {
          debugPrint('[CreateProduct] effective location fetch failed, using fallback: $e');
        }
        location = defaultJakartaSenayanLocation();
      }

      if (kDebugMode) {
        debugPrint('[CreateProduct] effective location loaded: ${location.idAddress?.kecamatan}');
      }

      final price = _parsePrice(_priceController.text);
      if (price == null) {
        if (!mounted) return;
        ScaffoldMessengerService.showError(
          context,
          'marketplace.priceInvalid'.tr(),
        );
        setState(() => _isSaving = false);
        return;
      }

      final productId = const Uuid().v4();
      List<String> uploadedUrls = [];
      List<XFile> optimizedImages = [];
      dynamic aiVerificationResult;

      try {
        // 1. Optimize images
        if (kDebugMode) debugPrint('[CreateProduct] submit start productId=$productId');
        setState(() => _savingStatus = 'optimizing');
        optimizedImages = await ref
            .read(marketplaceImageOptimizationServiceProvider)
            .optimizeProductImages(_selectedImages)
            .timeout(const Duration(seconds: 30));
        if (kDebugMode) debugPrint('[CreateProduct] optimizing done optimized=${optimizedImages.length}');

        // 2. Upload optimized images
        setState(() => _savingStatus = 'uploading');
        uploadedUrls = await ref
            .read(marketplaceImageUploadServiceProvider)
            .uploadProductImages(
              productId: productId,
              sellerId: userId,
              images: optimizedImages,
            )
            .timeout(const Duration(seconds: 60));
        if (kDebugMode) debugPrint('[CreateProduct] uploading done urls=${uploadedUrls.length}');

        // 3. AI Verification (Foundation)
        setState(() => _savingStatus = 'verifying');
        if (kDebugMode) debugPrint('[CreateProduct] ai verification start');
        try {
          aiVerificationResult = await ref
              .read(marketplaceAiVerificationServiceProvider)
              .verifyProductImages(
                productId: productId,
                title: _titleController.text.trim(),
                description: _descriptionController.text.trim(),
                category: _selectedCategory,
                imageUrls: uploadedUrls,
                imageFiles: optimizedImages,
              )
              .timeout(const Duration(seconds: 45));
          if (kDebugMode) debugPrint('[CreateProduct] ai verification done status=${aiVerificationResult?.status}');
        } catch (e) {
          debugPrint('AI verification failed (non-blocking): $e');
          // Fallback to error status
        }
      } catch (e) {
        if (!mounted) return;
        debugPrint('Error during optimization/upload/AI: $e');

        String errorKey = 'marketplace.imageUploadFailed';
        if (e is TimeoutException) {
          errorKey = 'common.timeout';
        } else if (e.toString().contains('optimization')) {
          errorKey = 'marketplace.imageOptimizationFailed';
        }

        ScaffoldMessengerService.showError(context, errorKey.tr());
        setState(() => _isSaving = false);
        return;
      }

      final newProduct = ProductModel(
        id: productId,
        userId: userId,
        title: _titleController.text.trim(),
        description: _descriptionController.text.trim(),
        category: _selectedCategory,
        price: price,
        imageUrls: uploadedUrls,
        locationParts: location,
        geoPath: buildIndonesiaGeoPath(location),
        createdAt: DateTime.now().toUtc(),
        isAiVerified: aiVerificationResult?.status == 'passed',
        aiVerificationStatus: aiVerificationResult?.status ?? 'needs_review',
        aiVerificationScore: aiVerificationResult?.score,
        aiVerificationSummary: aiVerificationResult?.summary,
        aiDetectedIssues: aiVerificationResult?.detectedIssues ?? [],
        aiSuggestedCategory: aiVerificationResult?.suggestedCategory,
        aiConditionLabel: aiVerificationResult?.conditionLabel,
        aiVerifiedAt: aiVerificationResult != null
            ? DateTime.now().toUtc()
            : null,
      );

      try {
        if (kDebugMode) debugPrint('[CreateProduct] firestore create start');
        await ref
            .read(createProductProvider)
            .call(newProduct)
            .timeout(const Duration(seconds: 15));
        if (kDebugMode) debugPrint('[CreateProduct] firestore create done');

        // 4. Save AI Report (Non-blocking)
        if (aiVerificationResult != null) {
          try {
            final report = AiVerificationReportModel(
              id: const Uuid().v4(),
              productId: productId,
              sellerId: userId,
              status: aiVerificationResult.status,
              score: aiVerificationResult.score,
              summary: aiVerificationResult.summary,
              detectedIssues: aiVerificationResult.detectedIssues,
              suggestedCategory: aiVerificationResult.suggestedCategory,
              conditionLabel: aiVerificationResult.conditionLabel,
              createdAt: DateTime.now().toUtc(),
            );

            final reportRepo = ref.read(aiVerificationReportRepositoryProvider);
            await reportRepo.saveReport(report);
            await reportRepo.enqueueReviewIfNeeded(report: report);
          } catch (e) {
            debugPrint('Error saving AI report: $e');
          }
        }

        // Invalidate lists so they refresh
        ref.invalidate(productsByKecamatanProvider);
        ref.invalidate(productsByCategoryProvider);

        if (!mounted) return;
        ScaffoldMessengerService.showSuccess(
          context,
          'marketplace.createSuccess'.tr(),
        );
        if (mounted) context.pop();
      } catch (e) {
        if (!mounted) return;
        ScaffoldMessengerService.showError(
          context,
          'marketplace.createFailed'.tr(),
        );
        setState(() => _isSaving = false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: const Key('createProductScreen'),
      appBar: AppBar(title: Text('marketplace.createTitle'.tr())),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              _buildImagePicker(context),
              const SizedBox(height: 24),
              TextFormField(
                key: const Key('createProductTitleField'),
                controller: _titleController,
                decoration: InputDecoration(
                  labelText: 'marketplace.titleHint'.tr(),
                ),
                validator: (value) => (value == null || value.trim().isEmpty)
                    ? 'marketplace.titleRequired'.tr()
                    : null,
              ),
              const SizedBox(height: 16),
              TextFormField(
                key: const Key('createProductDescriptionField'),
                controller: _descriptionController,
                decoration: InputDecoration(
                  labelText: 'marketplace.descriptionHint'.tr(),
                ),
                maxLines: 5,
                validator: (value) => (value == null || value.trim().isEmpty)
                    ? 'marketplace.descriptionRequired'.tr()
                    : null,
              ),
              const SizedBox(height: 16),
              TextFormField(
                key: const Key('createProductPriceField'),
                controller: _priceController,
                decoration: InputDecoration(
                  labelText: 'marketplace.priceHint'.tr(),
                  prefixText: 'Rp ',
                  hintText: 'marketplace.priceFormatHint'.tr(),
                ),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'marketplace.priceRequired'.tr();
                  }
                  if (_parsePrice(value) == null) {
                    return 'marketplace.priceInvalid'.tr();
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              DropdownButtonFormField<String>(
                key: const Key('createProductCategoryDropdown'),
                initialValue: _selectedCategory,
                decoration: InputDecoration(
                  labelText: 'marketplace.selectCategory'.tr(),
                ),
                items: _categories
                    .map(
                      (cat) => DropdownMenuItem(
                        value: cat,
                        child: Text('marketplace.category.$cat'.tr()),
                      ),
                    )
                    .toList(),
                onChanged: (value) {
                  if (value != null) {
                    setState(() => _selectedCategory = value);
                  }
                },
              ),
              const SizedBox(height: 32),
              ElevatedButton(
                key: const Key('createProductSubmitButton'),
                onPressed: _submit,
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                ),
                child: _isSaving
                    ? Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IntegrationTestConfig.enabled
                              ? const Icon(Icons.sync, color: Colors.white)
                              : const SizedBox(
                                  height: 24,
                                  width: 24,
                                  child: CircularProgressIndicator(
                                    color: Colors.white,
                                    strokeWidth: 2,
                                  ),
                                ),
                          const SizedBox(width: 12),
                          Text(_getSavingStatusText()),
                        ],
                      )
                    : Text('marketplace.submit'.tr()),
              ),
            ],
          ),
        ),
      ),
    );
  }

  String _getSavingStatusText() {
    switch (_savingStatus) {
      case 'optimizing':
        return 'marketplace.optimizingImages'.tr();
      case 'uploading':
        return 'common.loading'.tr(); // Or a specific key
      case 'verifying':
        return 'marketplace.verifyingWithAi'.tr();
      default:
        return 'common.loading'.tr();
    }
  }

  Widget _buildImagePicker(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'marketplace.selectedImages'.tr(),
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            Text(
              '${_selectedImages.length}/5',
              style: TextStyle(
                color: _selectedImages.length >= 5 ? Colors.red : Colors.grey,
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        Text(
          'marketplace.imageOptimizationNote'.tr(),
          style: TextStyle(
            fontSize: 12,
            color: Colors.grey[600],
            fontStyle: FontStyle.italic,
          ),
        ),
        const SizedBox(height: 8),
        SizedBox(
          height: 100,
          child: ListView.builder(
            key: const Key('createProductImagePreviewList'),
            scrollDirection: Axis.horizontal,
            itemCount:
                _selectedImages.length + (_selectedImages.length < 5 ? 1 : 0),
            itemBuilder: (context, index) {
              if (index == _selectedImages.length) {
                return _buildAddImageButton();
              }
              return _buildImagePreview(index);
            },
          ),
        ),
      ],
    );
  }

  Widget _buildAddImageButton() {
    return GestureDetector(
      key: const Key('createProductAddImageButton'),
      onTap: _pickImages,
      onLongPress: () {
        if (IntegrationTestConfig.enabled || kDebugMode) {
          setState(() {
            _selectedImages.add(XFile('test_path/fake_image.jpg'));
          });
        }
      },
      child: Container(
        width: 100,
        margin: const EdgeInsets.only(right: 8),
        decoration: BoxDecoration(
          color: Colors.grey[200],
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: Colors.grey[300]!),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.add_a_photo, color: Colors.grey),
            const SizedBox(height: 4),
            Text(
              'marketplace.addImages'.tr(),
              style: const TextStyle(fontSize: 12, color: Colors.grey),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildImagePreview(int index) {
    return Stack(
      key: Key('createProductImagePreview_$index'),
      children: [
        Container(
          width: 100,
          margin: const EdgeInsets.only(right: 8),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            color: Colors.grey[200],
          ),
          clipBehavior: Clip.antiAlias,
          child: Image.file(
            File(_selectedImages[index].path),
            fit: BoxFit.cover,
            errorBuilder: (context, error, stackTrace) {
              return const Center(
                child: Icon(Icons.broken_image, color: Colors.grey),
              );
            },
          ),
        ),
        Positioned(
          top: 4,
          right: 12,
          child: GestureDetector(
            key: Key('createProductRemoveImage_$index'),
            onTap: () => _removeImage(index),
            child: Container(
              padding: const EdgeInsets.all(2),
              decoration: const BoxDecoration(
                color: Colors.black54,
                shape: BoxShape.circle,
              ),
              child: const Icon(Icons.close, size: 16, color: Colors.white),
            ),
          ),
        ),
      ],
    );
  }
}
