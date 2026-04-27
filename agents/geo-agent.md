# geo-agent.md — 인도네시아 지오/위치 시스템 에이전트

> **역할**: 인도네시아 Track 1+2 듀얼 트랙 · CountryRegistry · 주소 포매팅 · 지도

---

## 인도네시아 행정구역 체계 (Track 1)

```
Indonesia (ID)
├── Provinsi (34개 주)                    ← L1
│   ├── DKI Jakarta
│   ├── Jawa Barat
│   ├── Jawa Tengah
│   ├── Jawa Timur
│   ├── Sumatera Utara
│   └── ... (총 34개)
├── Kabupaten / Kota (514개 시/군)        ← L2
│   ├── Kota Bandung
│   ├── Kota Surabaya
│   └── Kabupaten Bogor ...
├── Kecamatan (약 7,200개 구)             ← L3 (동네 기본 단위)
└── Kelurahan / Desa (약 83,000개 마을)  ← L4 (최소 하이퍼로컬 단위)
```

### CountryRegistry ID.json 완전 정의
```json
{
  "countryCode": "ID",
  "countryName": "Indonesia",
  "trackVersion": "1+2",
  "geoTrack": {
    "track1": {
      "levels": ["provinsi", "kabupaten", "kecamatan", "kelurahan"],
      "displayFormat": "{kecamatan}, {kabupaten}",
      "searchLevel": "kecamatan",
      "hyperlocalLevel": "kelurahan"
    },
    "track2": {
      "levels": ["l1", "l2", "l3"],
      "mapping": { "l1": "provinsi", "l2": "kabupaten", "l3": "kecamatan" }
    }
  },
  "currency": "IDR",
  "currencySymbol": "Rp",
  "currencyFormat": "Rp #,###",
  "thousandSeparator": ".",
  "decimalSeparator": ",",
  "languages": ["id", "jv", "su", "ms"],
  "primaryLanguage": "id",
  "phonePrefix": "+62",
  "phoneFormat": "0xxx-xxxx-xxxx",
  "timezones": [
    { "code": "WIB", "offset": 7, "provinces": ["JK","JB","JT","JI","SS","SB","BB","BT","LA","BE","KU"] },
    { "code": "WITA", "offset": 8, "provinces": ["BA","NTB","NTT","KT","KS","KU","SR","ST","SG"] },
    { "code": "WIT", "offset": 9, "provinces": ["MA","MU","PA","PB"] }
  ],
  "paymentMethods": ["gopay","ovo","dana","virtual_account","alfamart","indomaret","bca","mandiri"],
  "mapConfig": {
    "defaultCenter": { "lat": -2.548926, "lng": 118.0148634 },
    "defaultZoom": 5,
    "cityZoom": 12,
    "neighborhoodZoom": 15
  },
  "regulatoryBody": {
    "financial": "OJK",
    "data": "Kominfo",
    "privacy": "PDPB"
  }
}
```

---

## LocationService 구현 (인도네시아 특화)

```dart
// lib/mozzy_ii/geo/location/indonesia_location_service.dart
class IndonesiaLocationService {

  /// GPS → 인도네시아 행정구역 역지오코딩
  Future<IndonesiaGeoAddress> reverseGeocode(LatLng position) async {
    // 1. Google Geocoding API 호출
    final result = await _geocodingApi.reverseGeocode(position);
    
    // 2. 인도네시아 행정구역 파싱
    return IndonesiaGeoAddress(
      provinsi: _extractComponent(result, 'administrative_area_level_1'),
      kabupaten: _extractComponent(result, 'administrative_area_level_2'),
      kecamatan: _extractComponent(result, 'administrative_area_level_3'),
      kelurahan: _extractComponent(result, 'administrative_area_level_4'),
      geoPoint: GeoPoint(position.latitude, position.longitude),
      geoHash: GeoFirePoint(position.latitude, position.longitude).hash,
      countryCode: 'ID',
    );
  }

  /// 주소 표시 포맷
  String formatAddress(IndonesiaGeoAddress addr, AddressDetail detail) {
    return switch (detail) {
      AddressDetail.minimal  => '${addr.kecamatan}',
      AddressDetail.standard => '${addr.kecamatan}, ${addr.kabupaten}',
      AddressDetail.full     => '${addr.kelurahan}, ${addr.kecamatan}, ${addr.kabupaten}, ${addr.provinsi}',
    };
  }

  /// 타임존 자동 감지 (Provinsi 기반)
  IndonesiaTimezone detectTimezone(String provinsiCode) {
    const witbProvinces = ['JK','JB','JT','JI','SS','SB'];
    const witaProvinces = ['BA','NTB','NTT','KT','KS'];
    if (witbProvinces.contains(provinsiCode)) return IndonesiaTimezone.WIB;
    if (witaProvinces.contains(provinsiCode)) return IndonesiaTimezone.WITA;
    return IndonesiaTimezone.WIT;
  }
}
```

---

## SharedMapBrowser (인도네시아 지도 통합)

```dart
// 모든 Feature의 지도 진입점 통합
class SharedMapBrowserScreen extends ConsumerWidget {
  final MapFilter initialFilter;

  Widget build(BuildContext context, WidgetRef ref) {
    final items = ref.watch(mapItemsProvider(initialFilter));
    
    return Stack(children: [
      // Google Maps
      GoogleMap(
        initialCameraPosition: CameraPosition(
          target: LatLng(-6.200000, 106.816666), // 자카르타 기본
          zoom: 12,
        ),
        markers: _buildMarkers(items),
        onCameraMove: (pos) => ref.read(mapViewportProvider.notifier).update(pos),
      ),
      
      // Feature 필터 칩
      Positioned(
        top: 8, left: 8, right: 8,
        child: FilterChipRow(
          options: MapFilter.values,
          selected: initialFilter,
        ),
      ),
      
      // 하단 슬라이딩 패널 (선택된 아이템)
      DraggableScrollableSheet(
        initialChildSize: 0.3,
        builder: (_, controller) => MapItemListPanel(
          items: items,
          scrollController: controller,
        ),
      ),
    ]);
  }
}
```

---

## GeoScope 반경 기준 (인도네시아)

```dart
enum GeoScope {
  neighborhood,  // Kelurahan 단위 (약 2~5km²)
  city,          // Kabupaten/Kota 단위 (도시)
  country,       // 인도네시아 전국
  global         // 글로벌 릴레이
}

// 반경 매핑
extension GeoScopeRadius on GeoScope {
  double get radiusKm => switch (this) {
    GeoScope.neighborhood => 3.0,
    GeoScope.city         => 30.0,
    GeoScope.country      => double.infinity, // 인도네시아 전국
    GeoScope.global       => double.infinity,
  };

  String get firestoreField => switch (this) {
    GeoScope.neighborhood => 'locationParts.kecamatan',
    GeoScope.city         => 'locationParts.kabupaten',
    GeoScope.country      => 'locationParts.provinsi',
    GeoScope.global       => 'geoScope', // global 필터
  };
}
```
