import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mozzy/mozzy_ii/core/config/integration_test_config.dart';
import 'package:mozzy/mozzy_ii/domains/marketplace/providers/marketplace_provider.dart';
import 'package:mozzy/mozzy_ii/domains/marketplace/repositories/in_memory_marketplace_repository.dart';
import 'package:mozzy/mozzy_ii/domains/marketplace/screens/create_product_screen.dart';
import 'package:mozzy/mozzy_ii/geo/models/location_parts.dart';
import 'package:mozzy/mozzy_ii/geo/providers/location_provider.dart';

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
    expect(find.byKey(const Key('createProductImagePlaceholder')), findsOneWidget);
  });

  testWidgets('creates product when form is valid (digits only)', (tester) async {
    await tester.pumpWidget(createTestWidget());
    await tester.pumpAndSettle();

    await tester.enterText(find.byKey(const Key('createProductTitleField')), 'New Test Product');
    await tester.enterText(find.byKey(const Key('createProductDescriptionField')), 'A great product');
    await tester.enterText(find.byKey(const Key('createProductPriceField')), '150000');
    
    final submitButton = find.byKey(const Key('createProductSubmitButton'));
    await tester.ensureVisible(submitButton);
    await tester.tap(submitButton);
    await tester.pumpAndSettle(); 

    final products = await mockRepo.fetchByKecamatan(kecamatan: 'Kebayoran Baru');
    expect(products.length, 1);
    expect(products.first.price, 150000);
  });

  testWidgets('creates product when form is valid (with dots)', (tester) async {
    await tester.pumpWidget(createTestWidget());
    await tester.pumpAndSettle();

    await tester.enterText(find.byKey(const Key('createProductTitleField')), 'Product with Dots');
    await tester.enterText(find.byKey(const Key('createProductDescriptionField')), 'Desc');
    await tester.enterText(find.byKey(const Key('createProductPriceField')), '1.500.000');
    
    final submitButton = find.byKey(const Key('createProductSubmitButton'));
    await tester.ensureVisible(submitButton);
    await tester.tap(submitButton);
    await tester.pumpAndSettle(); 

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
