import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mozzy/mozzy_ii/core/config/integration_test_config.dart';
import 'package:mozzy/mozzy_ii/domains/marketplace/providers/marketplace_provider.dart';
import 'package:mozzy/mozzy_ii/domains/marketplace/repositories/in_memory_marketplace_repository.dart';
import 'package:mozzy/mozzy_ii/domains/marketplace/screens/create_product_screen.dart';
import 'package:mozzy/mozzy_ii/geo/models/location_parts.dart';
import 'package:mozzy/mozzy_ii/geo/providers/location_provider.dart';
import 'package:mozzy/mozzy_ii/domains/marketplace/services/in_memory_marketplace_image_upload_service.dart';
import 'package:mozzy/mozzy_ii/domains/marketplace/services/in_memory_marketplace_image_optimization_service.dart';
import 'package:mozzy/mozzy_ii/domains/marketplace/services/in_memory_marketplace_ai_verification_service.dart';

class MockLocationNotifier extends LocationNotifier {
  final LocationParts _value;
  MockLocationNotifier(this._value);
  @override
  Future<LocationParts?> build() async => _value;
}

void main() {
  late InMemoryMarketplaceRepository mockRepo;
  late LocationParts testLocation;

  setUp(() {
    mockRepo = InMemoryMarketplaceRepository();
    testLocation = const LocationParts(
      countryCode: 'ID',
      latitude: 0,
      longitude: 0,
      geoHash: 'abc',
      idAddress: IndonesiaGeoAddress(
        provinsi: 'DKI Jakarta',
        kabupaten: 'Jakarta Selatan',
        kecamatan: 'Kebayoran Baru',
        kelurahan: 'Senayan',
      ),
    );
  });

  Widget createTestWidget() {
    return ProviderScope(
      overrides: [
        marketplaceRepositoryProvider.overrideWithValue(mockRepo),
        marketplaceImageUploadServiceProvider.overrideWithValue(InMemoryMarketplaceImageUploadService()),
        marketplaceImageOptimizationServiceProvider.overrideWithValue(InMemoryMarketplaceImageOptimizationService()),
        marketplaceAiVerificationServiceProvider.overrideWithValue(InMemoryMarketplaceAiVerificationService()),
        locationProvider.overrideWith(() => MockLocationNotifier(testLocation)),
        currentMarketplaceUserIdProvider.overrideWithValue(IntegrationTestConfig.testUserId),
      ],
      child: const MaterialApp(
        home: CreateProductScreen(),
      ),
    );
  }

  testWidgets('renders CreateProductScreen and its fields', (tester) async {
    await tester.pumpWidget(createTestWidget());
    await tester.pumpAndSettle();

    expect(find.byKey(const Key('createProductScreen')), findsOneWidget);
    expect(find.byKey(const Key('createProductTitleField')), findsOneWidget);
    expect(find.byKey(const Key('createProductDescriptionField')), findsOneWidget);
    expect(find.byKey(const Key('createProductPriceField')), findsOneWidget);
    expect(find.byKey(const Key('createProductCategoryDropdown')), findsOneWidget);
    expect(find.byKey(const Key('createProductSubmitButton')), findsOneWidget);
    expect(find.byKey(const Key('createProductAddImageButton')), findsOneWidget);
  });

  testWidgets('shows validation error if no image is selected', (tester) async {
    await tester.pumpWidget(createTestWidget());
    await tester.pumpAndSettle();

    await tester.enterText(find.byKey(const Key('createProductTitleField')), 'Test Product');
    await tester.enterText(find.byKey(const Key('createProductDescriptionField')), 'Desc');
    await tester.enterText(find.byKey(const Key('createProductPriceField')), '150000');
    
    final submitButton = find.byKey(const Key('createProductSubmitButton'));
    await tester.ensureVisible(submitButton);
    await tester.tap(submitButton);
    await tester.pumpAndSettle();

    // Check for imageRequired error key
    expect(find.textContaining('imageRequired'), findsWidgets);
  });

  testWidgets('creates product when form is valid (with dots)', (tester) async {
    await tester.pumpWidget(createTestWidget());
    await tester.pumpAndSettle();

    await tester.enterText(find.byKey(const Key('createProductTitleField')), 'Product with Dots');
    await tester.enterText(find.byKey(const Key('createProductDescriptionField')), 'Desc');
    await tester.enterText(find.byKey(const Key('createProductPriceField')), '1.500.000');
    
    // Inject image
    await tester.longPress(find.byKey(const Key('createProductAddImageButton')));
    await tester.pumpAndSettle();

    final submitButton = find.byKey(const Key('createProductSubmitButton'));
    await tester.ensureVisible(submitButton);
    await tester.tap(submitButton);
    await tester.pump(); // Start saving
    await tester.pump(const Duration(milliseconds: 500)); // Wait for async flow
    await tester.pumpAndSettle(); // Finish animations if any

    final products = await mockRepo.fetchByKecamatan(kecamatan: 'Kebayoran Baru');
    expect(products.any((p) => p.title == 'Product with Dots'), true);
    final p = products.firstWhere((p) => p.title == 'Product with Dots');
    expect(p.price, 1500000);
  });

  testWidgets('shows validation error for invalid price', (tester) async {
    await tester.pumpWidget(createTestWidget());
    await tester.pumpAndSettle();

    await tester.enterText(find.byKey(const Key('createProductPriceField')), 'abc');
    
    final submitButton = find.byKey(const Key('createProductSubmitButton'));
    await tester.ensureVisible(submitButton);
    await tester.tap(submitButton);
    await tester.pumpAndSettle();

    // Since EasyLocalization is not initialized, it shows the key.
    expect(find.textContaining('priceInvalid'), findsWidgets);
  });
}
