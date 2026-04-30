import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mozzy/mozzy_ii/domains/marketplace/repositories/in_memory_marketplace_repository.dart';
import 'package:mozzy/mozzy_ii/domains/marketplace/providers/marketplace_provider.dart';
import 'package:mozzy/mozzy_ii/domains/marketplace/screens/product_detail_screen.dart';
import 'package:mozzy/mozzy_ii/domains/marketplace/models/product_model.dart';
import 'package:mozzy/mozzy_ii/geo/models/location_parts.dart';
import 'package:intl/date_symbol_data_local.dart';

void main() {
  late InMemoryMarketplaceRepository mockRepo;

  setUpAll(() async {
    await initializeDateFormatting('id_ID', null);
  });

  setUp(() {
    mockRepo = InMemoryMarketplaceRepository();
  });

  Widget createTestWidget(String productId) {
    return ProviderScope(
      overrides: [
        marketplaceRepositoryProvider.overrideWithValue(mockRepo),
      ],
      child: MaterialApp(
        home: ProductDetailScreen(productId: productId),
      ),
    );
  }

  testWidgets('renders ProductDetailScreen and shows product info', (tester) async {
    final product = ProductModel(
      id: 'p1',
      userId: 'seller_12345678',
      title: 'Detail Product',
      description: 'Long description of the product',
      category: 'electronics',
      price: 5000000,
      geoPath: 'ID/Jakarta/Kebayoran Baru',
      createdAt: DateTime(2026, 4, 30),
      locationParts: const LocationParts(
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
      ),
      isAiVerified: true,
      aiVerificationStatus: 'verified_ok',
    );
    await mockRepo.createProduct(product);

    await tester.pumpWidget(createTestWidget('p1'));
    await tester.pumpAndSettle();

    expect(find.byKey(const Key('productDetailScreen')), findsOneWidget);
    expect(find.text('Detail Product'), findsOneWidget);
    expect(find.text('Rp 5.000.000'), findsOneWidget);
    expect(find.text('Long description of the product'), findsOneWidget);
    expect(find.textContaining('Kebayoran Baru'), findsOneWidget);
    expect(find.textContaining('Jakarta Selatan'), findsOneWidget);
    
    // Redacted seller ID check
    expect(find.textContaining('seller_12345678'), findsNothing);
    expect(find.textContaining('seller_1'), findsOneWidget);
    
    // i18n keys check (since EasyLocalization is not fully initialized in this simple test)
    // It should display the keys or the translated values if it works.
    // In many tests without full setup it shows the key.
    // But since I'm not using .tr() in the expect, let's see.
    // Actually, it's better to just check if the widgets are there.
    expect(find.byIcon(Icons.auto_awesome), findsOneWidget);
  });

  testWidgets('shows placeholder image if imageUrls empty', (tester) async {
     final product = ProductModel(
      id: 'p2',
      userId: 'u2',
      title: 'No Image Product',
      description: 'Desc',
      category: 'fashion',
      price: 100000,
      geoPath: 'ID/Jakarta/Kebayoran Baru',
      createdAt: DateTime.now(),
      imageUrls: [],
    );
    await mockRepo.createProduct(product);

    await tester.pumpWidget(createTestWidget('p2'));
    await tester.pumpAndSettle();

    expect(find.byIcon(Icons.image), findsOneWidget);
  });

  testWidgets('shows not found state if product null', (tester) async {
    await tester.pumpWidget(createTestWidget('non_existent'));
    await tester.pumpAndSettle();

    // The key for not found is 'marketplace.notFound'
    expect(find.textContaining('notFound'), findsOneWidget);
  });
}
