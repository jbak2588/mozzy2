import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:go_router/go_router.dart';
import 'package:uuid/uuid.dart';

import '../../../core/utils/scaffold_messenger_service.dart';
import '../../../geo/providers/location_provider.dart';
import '../../../geo/utils/geo_path_builder.dart';
import '../models/product_model.dart';
import '../providers/marketplace_provider.dart';

class CreateProductScreen extends ConsumerStatefulWidget {
  const CreateProductScreen({super.key});

  @override
  ConsumerState<CreateProductScreen> createState() => _CreateProductScreenState();
}

class _CreateProductScreenState extends ConsumerState<CreateProductScreen> {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _priceController = TextEditingController();

  String _selectedCategory = 'electronics';
  bool _isSaving = false;

  final _categories = [
    'electronics', 'fashion', 'home', 'baby', 'sports', 'vehicles', 'books', 'other'
  ];

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    _priceController.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    if (_isSaving) return;

    if (_formKey.currentState!.validate()) {
      setState(() => _isSaving = true);

      final userId = ref.read(currentMarketplaceUserIdProvider);
      if (userId == null) {
        if (!mounted) return;
        ScaffoldMessengerService.showError(context, 'marketplace.loginRequired'.tr());
        setState(() => _isSaving = false);
        return;
      }

      final location = await ref.read(locationProvider.future);
      if (location == null) {
        if (!mounted) return;
        ScaffoldMessengerService.showError(context, 'marketplace.locationRequired'.tr());
        setState(() => _isSaving = false);
        return;
      }

      final newProduct = ProductModel(
        id: const Uuid().v4(),
        userId: userId,
        title: _titleController.text.trim(),
        description: _descriptionController.text.trim(),
        category: _selectedCategory,
        price: int.parse(_priceController.text),
        locationParts: location,
        geoPath: buildIndonesiaGeoPath(location),
        createdAt: DateTime.now().toUtc(),
      );

      try {
        await ref.read(createProductProvider).call(newProduct);
        
        // Invalidate lists so they refresh
        ref.invalidate(productsByKecamatanProvider);
        ref.invalidate(productsByCategoryProvider);

        if (!mounted) return;
        ScaffoldMessengerService.showSuccess(context, 'marketplace.createSuccess'.tr());
        if (mounted) context.pop();
      } catch (e) {
        if (!mounted) return;
        ScaffoldMessengerService.showError(context, 'marketplace.createFailed'.tr());
        setState(() => _isSaving = false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: const Key('createProductScreen'),
      appBar: AppBar(
        title: Text('marketplace.createTitle'.tr()),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              _buildImagePlaceholder(context),
              const SizedBox(height: 24),
              TextFormField(
                key: const Key('createProductTitleField'),
                controller: _titleController,
                decoration: InputDecoration(labelText: 'marketplace.titleHint'.tr()),
                validator: (value) => (value == null || value.trim().isEmpty)
                    ? 'marketplace.titleRequired'.tr() : null,
              ),
              const SizedBox(height: 16),
              TextFormField(
                key: const Key('createProductDescriptionField'),
                controller: _descriptionController,
                decoration: InputDecoration(labelText: 'marketplace.descriptionHint'.tr()),
                maxLines: 5,
                validator: (value) => (value == null || value.trim().isEmpty)
                    ? 'marketplace.descriptionRequired'.tr() : null,
              ),
              const SizedBox(height: 16),
              TextFormField(
                key: const Key('createProductPriceField'),
                controller: _priceController,
                decoration: InputDecoration(
                  labelText: 'marketplace.priceHint'.tr(),
                  prefixText: 'Rp ',
                ),
                keyboardType: TextInputType.number,
                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'marketplace.priceRequired'.tr();
                  }
                  if (int.tryParse(value) == null || int.parse(value) <= 0) {
                    return 'marketplace.priceInvalid'.tr();
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              DropdownButtonFormField<String>(
                key: const Key('createProductCategoryDropdown'),
                value: _selectedCategory,
                decoration: InputDecoration(labelText: 'marketplace.selectCategory'.tr()),
                items: _categories.map((cat) => DropdownMenuItem(
                  value: cat,
                  child: Text('marketplace.category.$cat'.tr()),
                )).toList(),
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
                    ? const SizedBox(
                        height: 24,
                        width: 24,
                        child: CircularProgressIndicator(color: Colors.white),
                      )
                    : Text('marketplace.submit'.tr()),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildImagePlaceholder(BuildContext context) {
    return Container(
      height: 150,
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey[300]!),
      ),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.camera_alt, size: 50, color: Colors.grey),
            const SizedBox(height: 8),
            Text(
              'marketplace.imagesComingSoon'.tr(),
              style: const TextStyle(color: Colors.grey),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
