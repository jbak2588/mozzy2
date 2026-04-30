import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mozzy/mozzy_ii/domains/marketplace/models/product_model.dart';
import 'package:mozzy/mozzy_ii/domains/marketplace/widgets/marketplace_product_card.dart';
import 'package:mozzy/mozzy_ii/geo/models/location_parts.dart';

void main() {
  testWidgets('MarketplaceProductCard renders fields correctly', (tester) async {
    final product = ProductModel(
      id: 'p1',
      userId: 'u1',
      title: 'Test Product',
      description: 'Test Description',
      category: 'electronics',
      price: 1500000,
      geoPath: 'ID/Jakarta/Kebayoran Baru',
      createdAt: DateTime.now(),
      imageUrls: [],
      isAiVerified: true,
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
    );

    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: MarketplaceProductCard(product: product),
        ),
      ),
    );

    expect(find.text('Test Product'), findsOneWidget);
    expect(find.text('Rp 1.500.000'), findsOneWidget);
    expect(find.byKey(const Key('marketplaceProductImagePlaceholder')), findsOneWidget);
    expect(find.byIcon(Icons.auto_awesome), findsOneWidget);
  });

  testWidgets('MarketplaceProductCard shows placeholder when no image', (tester) async {
    final product = ProductModel(
      id: 'p2',
      userId: 'u1',
      title: 'No Image Product',
      description: 'Test Description',
      category: 'fashion',
      price: 50000,
      geoPath: 'ID/Jakarta/Kebayoran Baru',
      createdAt: DateTime.now(),
      imageUrls: [],
    );

    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: MarketplaceProductCard(product: product),
        ),
      ),
    );

    expect(find.byKey(const Key('marketplaceProductImagePlaceholder')), findsOneWidget);
    expect(find.byIcon(Icons.image), findsOneWidget);
  });
}
