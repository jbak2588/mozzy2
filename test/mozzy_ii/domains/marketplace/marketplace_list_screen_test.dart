import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mozzy/mozzy_ii/domains/marketplace/repositories/in_memory_marketplace_repository.dart';
import 'package:mozzy/mozzy_ii/domains/marketplace/providers/marketplace_provider.dart';
import 'package:mozzy/mozzy_ii/domains/marketplace/screens/marketplace_list_screen.dart';
import 'package:mozzy/mozzy_ii/geo/providers/location_provider.dart';
import 'package:mozzy/mozzy_ii/geo/models/location_parts.dart';
import 'package:mozzy/mozzy_ii/domains/marketplace/models/product_model.dart';

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
      ],
      child: const MaterialApp(
        home: MarketplaceListScreen(),
      ),
    );
  }

  testWidgets('MarketplaceListScreen renders and shows title', (tester) async {
    await tester.pumpWidget(createTestWidget());
    await tester.pumpAndSettle();

    expect(find.byKey(const Key('marketplaceListScreen')), findsOneWidget);
    expect(find.byKey(const Key('marketplaceCreateFab')), findsOneWidget);
    expect(find.byKey(const Key('marketplaceSavedButton')), findsOneWidget);
    expect(find.text('Kebayoran Baru, Jakarta Selatan'), findsOneWidget);
    
    // Admin button should appear in debug/test mode
    expect(find.byKey(const Key('marketplaceAdminReviewButton')), findsOneWidget);
  });

  testWidgets('MarketplaceListScreen shows category chips', (tester) async {
    await tester.pumpWidget(createTestWidget());
    await tester.pumpAndSettle();

    expect(find.byType(ChoiceChip), findsAtLeastNWidgets(3));
  });

  testWidgets('MarketplaceListScreen shows products from repo', (tester) async {
    final product = ProductModel(
      id: 'p1',
      userId: 'u1',
      title: 'Repo Product',
      description: 'Desc',
      category: 'electronics',
      price: 1000,
      geoPath: 'ID/Jakarta/Kebayoran Baru',
      createdAt: DateTime.now(),
      locationParts: testLocation,
    );
    await mockRepo.createProduct(product);

    await tester.pumpWidget(createTestWidget());
    await tester.pumpAndSettle();

    expect(find.text('Repo Product'), findsOneWidget);
  });
}
