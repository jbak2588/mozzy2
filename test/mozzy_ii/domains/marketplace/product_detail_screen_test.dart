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

  Widget createTestWidget(String productId, {String? userId = 'test-user-id'}) {
    return ProviderScope(
      overrides: [
        marketplaceRepositoryProvider.overrideWithValue(mockRepo),
        currentMarketplaceUserIdProvider.overrideWithValue(userId),
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
    
    // Placeholder key check
    expect(find.byKey(const Key('productDetailImagePlaceholder')), findsOneWidget);
    
    // i18n keys check
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

    expect(find.byKey(const Key('productDetailImagePlaceholder')), findsOneWidget);
    expect(find.byIcon(Icons.image), findsOneWidget);
  });

  testWidgets('shows not found state if product null', (tester) async {
    await tester.pumpWidget(createTestWidget('non_existent'));
    await tester.pumpAndSettle();

    expect(find.textContaining('notFound'), findsOneWidget);
  });

  testWidgets('toggles like button when tapped', (tester) async {
    final product = ProductModel(
      id: 'p1',
      userId: 'u1',
      title: 'Like Test Product',
      description: 'Desc',
      category: 'electronics',
      price: 1000,
      geoPath: 'ID/Jakarta',
      createdAt: DateTime.now(),
    );
    await mockRepo.createProduct(product);

    await tester.pumpWidget(createTestWidget('p1'));
    await tester.pumpAndSettle();

    final likeButton = find.byKey(const Key('productLikeButton'));
    expect(likeButton, findsOneWidget);

    // Ensure visible before tapping
    await tester.ensureVisible(likeButton);
    await tester.pumpAndSettle();

    // Initial state: not liked
    await tester.tap(likeButton);
    await tester.pumpAndSettle();

    final isLiked = await mockRepo.isProductLikedByUser(productId: 'p1', userId: 'test-user-id');
    expect(isLiked, isTrue);

    // Tap again to unlike
    await tester.tap(likeButton);
    await tester.pumpAndSettle();

    final isLikedAgain = await mockRepo.isProductLikedByUser(productId: 'p1', userId: 'test-user-id');
    expect(isLikedAgain, isFalse);
  });
}
