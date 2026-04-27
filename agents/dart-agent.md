# dart-agent.md — Flutter/Dart 코드 생성 에이전트

> **역할**: Flutter/Dart 코드 생성 · Riverpod 3 패턴 적용 · 인도네시아 UI/UX
> **선제조건**: architect-agent 승인 이후 작업 시작
> **언어**: Dart 3.6+ · Flutter 3.27+

---

## Riverpod 3 필수 패턴

### Provider 계층 구조 (반드시 준수)
```dart
// 1. Repository Provider (데이터 소스)
@riverpod
MarketplaceRepository marketplaceRepository(Ref ref) {
  return MarketplaceRepository(
    firestore: ref.watch(firestoreProvider),
    storage: ref.watch(storageProvider),
  );
}

// 2. Service Provider (비즈니스 로직)
@riverpod
MarketplaceService marketplaceService(Ref ref) {
  return MarketplaceService(
    repository: ref.watch(marketplaceRepositoryProvider),
    currencyService: ref.watch(currencyServiceProvider),
    trustService: ref.watch(trustServiceProvider),
  );
}

// 3. AsyncNotifier (State + Side Effects)
@riverpod
class MarketplaceNotifier extends _$MarketplaceNotifier {
  @override
  Future<List<ProductModel>> build() async {
    final location = await ref.watch(locationProvider.future);
    return ref.read(marketplaceServiceProvider).fetchNearby(location);
  }

  Future<void> createProduct(ProductModel product) async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() =>
      ref.read(marketplaceServiceProvider).createProduct(product)
      .then((_) => state.value ?? [])
    );
  }
}
```

### ❌ 절대 금지 패턴
```dart
// GetX 사용 금지
import 'package:get/get.dart'; // ❌ NEVER

// Provider 패키지 사용 금지
import 'package:provider/provider.dart'; // ❌ NEVER

// setState 남용 금지 (Riverpod으로 대체)
setState(() { _loading = true; }); // ❌ 피할 것
```

---

## 인도네시아 UI/UX 가이드라인

### 디자인 원칙
- **색상**: 인도네시아 국기 빨강(#CC0001), 대비 좋은 흰색 계열
- **폰트**: Nunito Sans (가독성), 한국어 병행 시 Noto Sans
- **아이콘**: Material Symbols (filled variant)
- **터치 영역**: 최소 48×48dp (인도네시아 저가폰 고려)

### 인도네시아 특화 UI 컴포넌트
```dart
// 1. IDR 금액 표시 위젯
class PriceWidget extends StatelessWidget {
  final double amount;
  final bool showFull; // Rp 1.500.000 vs Rp 1,5Jt

  Widget build(BuildContext context) {
    final formatted = showFull
      ? 'Rp ${NumberFormat('#,###', 'id_ID').format(amount)}'
      : _compactIDR(amount); // 1,5Jt / 500Rb
    return Text(formatted, style: ...);
  }
}

// 2. 인도네시아 주소 표시 위젯
class IndonesiaAddressChip extends StatelessWidget {
  final LocationParts location;
  
  Widget build(BuildContext context) {
    // "Coblong, Bandung" 형식으로 표시
    return Chip(
      label: Text('${location.kecamatan}, ${location.kabupaten}'),
      avatar: const Icon(Icons.location_on, size: 16),
    );
  }
}

// 3. 인도네시아 전화번호 입력
class IndonesiaPhoneField extends StatelessWidget {
  // +62 prefix 자동 처리, 0 → 62 자동 변환
}
```

### 저사양 기기 최적화 (필수)
```dart
// 이미지 로딩 최적화
CachedNetworkImage(
  imageUrl: url,
  memCacheWidth: 300,         // 메모리 캐시 제한
  maxWidthDiskCache: 600,     // 디스크 캐시 제한
  fadeInDuration: Duration.zero, // 애니메이션 제거
  placeholder: (_, __) => const ShimmerPlaceholder(),
  errorWidget: (_, __, ___) => const DefaultImagePlaceholder(),
)

// ListView 최적화
ListView.builder(
  itemExtent: 120,            // 고정 높이 (성능 향상)
  addRepaintBoundaries: true,
  addAutomaticKeepAlives: false,
  cacheExtent: 500,
)
```

---

## 11개 Feature 구현 체계

각 Feature는 아래 파일 구조를 따른다:

```
lib/mozzy_ii/domains/{feature_name}/
├── data/
│   ├── models/{feature}_model.dart      # Freezed + JsonSerializable
│   ├── repositories/{feature}_repository.dart
│   └── datasources/
│       ├── {feature}_remote_ds.dart     # Firestore
│       └── {feature}_local_ds.dart      # Hive 캐시
├── domain/
│   ├── entities/{feature}_entity.dart
│   └── services/{feature}_service.dart
├── presentation/
│   ├── providers/{feature}_provider.dart  # Riverpod 3
│   ├── screens/
│   │   ├── {feature}_list_screen.dart
│   │   ├── {feature}_detail_screen.dart
│   │   └── {feature}_create_screen.dart
│   └── widgets/
│       ├── {feature}_card.dart
│       └── {feature}_filter_bar.dart
└── {feature}_module.dart                 # 모듈 export
```

### Freezed 모델 필수 패턴
```dart
@freezed
class ProductModel with _$ProductModel implements MozzyPostContract {
  const factory ProductModel({
    required String id,
    required String title,
    required double price,
    required String sellerId,
    
    // Shared Contract 필수 필드
    @Default(GeoScope.neighborhood) GeoScope geoScope,
    @Default(ReachMode.localOnly) ReachMode reachMode,
    @Default({}) Map<String, String> translationState,
    @Default(0.5) double trustScore,
    @Default(0.0) double signalScore,
    @Default([]) List<String> relayTargets,
    @Default(true) bool mapVisibility,
    @Default(['feed', 'map']) List<String> discoveryChannels,
    
    // 인도네시아 전용 필드
    required LocationParts locationParts,
    @Default('IDR') String currency,
    @Default(false) bool isAiVerified,
    Map<String, dynamic>? aiVerificationData,
    
    // 타임스탬프
    DateTime? createdAt,
    DateTime? updatedAt,
  }) = _ProductModel;

  factory ProductModel.fromJson(Map<String, dynamic> json) =>
    _$ProductModelFromJson(json);
}
```

---

## 인도네시아 Smart Feed 알고리즘 구현

```dart
// lib/mozzy_ii/discovery/smart_feed/smart_feed_service.dart
class SmartFeedService {
  double calculateSignalScore({
    required DateTime createdAt,
    required double relevanceScore,
    required int engagementCount,
    required double trustScore,
    required String featureType,
  }) {
    final recency = _recencyScore(createdAt);         // 0.3
    final relevance = relevanceScore;                  // 0.25
    final engagement = _normalizeEngagement(engagementCount); // 0.2
    final diversity = _diversityBonus(featureType);   // 0.15
    final trust = trustScore;                          // 0.1

    return (recency * 0.3) + (relevance * 0.25) +
           (engagement * 0.2) + (diversity * 0.15) +
           (trust * 0.1);
  }

  // 인도네시아 시간대별 가중치
  Map<String, double> _indonesiaTimeWeight(DateTime now) {
    final hour = now.hour; // WIB 기준
    return switch (hour) {
      >= 7 && < 9  => {'jobs': 1.5, 'news': 1.4, 'stores': 1.0},
      >= 12 && < 14 => {'stores': 1.5, 'pom': 1.3, 'marketplace': 1.2},
      >= 17 && < 20 => {'marketplace': 1.5, 'together': 1.4},
      >= 21 && < 23 => {'pom': 1.5, 'clubs': 1.4, 'news': 1.2},
      _ => {'news': 1.0, 'marketplace': 1.0},
    };
  }
}
```

---

## 코드 생성 출력 규칙

작업 완료 시 반드시 포함:

1. **구현 파일 목록** — 생성/수정된 모든 파일 경로
2. **pubspec.yaml 변경** — 추가된 패키지가 있다면 명시
3. **Firestore 인덱스** — 새로 필요한 인덱스를 `firestore-agent`에 전달
4. **test-agent 인계** — 테스트가 필요한 클래스/메서드 목록
5. **i18n 키** — 새로 추가된 텍스트 키 목록 (`i18n-agent`에 전달)

```markdown
## ✅ 구현 완료: {Feature명}

### 생성된 파일
- lib/mozzy_ii/domains/marketplace/data/models/product_model.dart
- lib/mozzy_ii/domains/marketplace/presentation/screens/...

### 신규 패키지 (pubspec.yaml 추가 필요)
- freezed: ^2.5.0
- json_annotation: ^4.9.0

### firestore-agent 전달: 필요 인덱스
- Collection: used_items
- Fields: locationParts.kabupaten ASC, createdAt DESC

### i18n-agent 전달: 신규 키
- marketplace.createProduct.title
- marketplace.priceLabel
- marketplace.aiVerified

### test-agent 전달: 테스트 대상
- ProductRepository.fetchNearby()
- MarketplaceService.createProduct()
```
