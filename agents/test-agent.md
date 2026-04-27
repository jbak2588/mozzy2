# test-agent.md — 테스트 자동화 에이전트

> **목표**: 1,033+ 테스트 · 30% 커버리지 달성 · Riverpod 3 테스트 패턴

---

## 테스트 전략

### 테스트 피라미드 (인도네시아 앱)
```
Unit Tests       70% — Repository, Service, Model
Widget Tests     20% — Card, Form, Screen 위젯
Integration      10% — 주요 User Journey (결제, 게시, 채팅)
```

### Riverpod 3 테스트 패턴 (필수)
```dart
// Repository 테스트
void main() {
  late ProviderContainer container;
  late MockFirestore mockFirestore;

  setUp(() {
    mockFirestore = MockFirestore();
    container = ProviderContainer(
      overrides: [
        firestoreProvider.overrideWithValue(mockFirestore),
      ],
    );
  });

  tearDown(() => container.dispose());

  group('MarketplaceRepository', () {
    test('fetchNearby returns products within kecamatan', () async {
      // Arrange
      when(mockFirestore.collection('used_items')
        .where('locationParts.kecamatan', isEqualTo: 'Coblong')
        .orderBy('signalScore', descending: true)
        .limit(20)
        .get()
      ).thenAnswer((_) async => MockQuerySnapshot([_mockProduct]));

      // Act
      final repo = container.read(marketplaceRepositoryProvider);
      final result = await repo.fetchNearby(kecamatan: 'Coblong');

      // Assert
      expect(result.length, 1);
      expect(result.first.locationParts.kecamatan, 'Coblong');
    });
  });
}
```

### 인도네시아 특화 테스트 케이스
```dart
group('IndonesiaGeoService', () {
  test('reverseGeocode returns Track 1 address for Jakarta', () async { ... });
  test('detectTimezone returns WIB for Jakarta', () { ... });
  test('formatIDR uses Indonesian number format', () {
    expect(formatIDR(1500000), 'Rp 1.500.000');  // 점(.) 천단위
  });
});

group('MidtransService', () {
  test('createTransaction with GoPay payload is correct', () async { ... });
  test('fee calculation for Virtual Account is Rp 4000 flat', () { ... });
  test('wallet balance cannot exceed OJK limit of Rp 20,000,000', () { ... });
});

group('SharedContract', () {
  test('ProductModel implements MozzyPostContract', () {
    final product = ProductModel(...);
    expect(product, isA<MozzyPostContract>());
    expect(product.geoScope, isNotNull);
    expect(product.trustScore, inInclusiveRange(0.0, 1.0));
  });
});
```

### 커버리지 목표 (Feature별)
```
Shared Contract:    95%+  (가장 중요)
Geo/Location:       90%+  (인도네시아 핵심)
Marketplace:        80%+  (주력 Feature)
Monetization:       85%+  (돈 관련)
AI Services:        70%+  (Mock 사용)
각 도메인 평균:     60%+
전체 목표:          30%+
```
