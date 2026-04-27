# firestore-agent.md — Firestore 스키마 & 인덱스 최적화 에이전트

> **역할**: Firestore 스키마 설계 · 132 인덱스 한도 관리 · 쿼리 튜닝 · Security Rules
> **권한**: 인덱스 추가/삭제 최종 승인권 보유
> **한도**: 복합 인덱스 총계 132개 이하 유지 (현재 기준)

---

## 인도네시아 컬렉션 스키마

### 핵심 컬렉션 목록
```
posts              → Local News
used_items         → Marketplace
job_posts          → Jobs
auctions           → Auction
groups             → Clubs (group_proposals 포함)
lost_found         → Lost & Found
pom                → POM/뽐
real_estate        → Real Estate
shops              → Local Stores
together_posts     → Together
chat_rooms         → Chat (messages 서브컬렉션)
users              → 사용자 프로필
notifications      → FCM 알림 큐
metadata           → exchange_rates, country_configs
```

### 인도네시아 전용 필드 (모든 컬렉션 공통)
```javascript
// 인도네시아 Track 1 주소 (반드시 포함)
locationParts: {
  provinsi: "Jawa Barat",
  kabupaten: "Kota Bandung",
  kecamatan: "Coblong",
  kelurahan: "Lebak Siliwangi",
  // Track 2 글로벌 표준 (병행)
  l1: "Jawa Barat",
  l2: "Bandung",
  l3: "Coblong",
  geoHash: "qqguh...",    // GeoHash 인덱싱용
  countryCode: "ID"
}

// Shared Contract 필드
geoScope: "neighborhood" | "city" | "country" | "global"
trustScore: 0.85
signalScore: 0.72
discoveryChannels: ["feed", "map", "search"]
```

---

## 인덱스 관리 전략

### 현재 인덱스 예산 배분 (132개)
```
App Shell / 공통:     8개
Local News:          12개
Marketplace:         18개  ← 가장 중요
Jobs:                12개
Auction:             10개
Clubs:                8개
Lost & Found:         8개
POM:                  10개
Real Estate:          10개
Local Stores:         12개
Together:              8개
Chat:                  6개
Discovery/Feed:       10개
─────────────────────────
합계:                132개
```

### 인덱스 추가 규칙
1. 새 인덱스 추가 전 반드시 현재 총계 확인
2. 단일 필드 인덱스는 카운트 제외 (자동 생성)
3. 복합 인덱스 추가 시: 기존 인덱스 제거 가능 여부 먼저 검토
4. 쿼리 패턴 변경으로 인덱스 절약 가능한지 검토

### 핵심 인덱스 정의 (Marketplace 예시)
```json
{
  "collectionGroup": "used_items",
  "queryScope": "COLLECTION",
  "fields": [
    { "fieldPath": "locationParts.kabupaten", "order": "ASCENDING" },
    { "fieldPath": "geoScope", "order": "ASCENDING" },
    { "fieldPath": "createdAt", "order": "DESCENDING" }
  ]
},
{
  "collectionGroup": "used_items",
  "queryScope": "COLLECTION",
  "fields": [
    { "fieldPath": "locationParts.kecamatan", "order": "ASCENDING" },
    { "fieldPath": "isAiVerified", "order": "ASCENDING" },
    { "fieldPath": "signalScore", "order": "DESCENDING" }
  ]
}
```

---

## Security Rules (인도네시아 PDPB 준수)

```javascript
rules_version = '2';
service cloud.firestore {
  match /databases/{database}/documents {

    // 공통 헬퍼 함수
    function isAuthenticated() {
      return request.auth != null;
    }
    function isOwner(userId) {
      return request.auth.uid == userId;
    }
    function isIndonesiaUser() {
      return request.auth.token.countryCode == 'ID';
    }
    function hasValidTrustScore() {
      return resource.data.trustScore >= 0.3;
    }

    // 사용자 프로필 (PDPB: 본인만 민감정보 접근)
    match /users/{userId} {
      allow read: if isAuthenticated() &&
        (isOwner(userId) || !request.resource.data.keys().hasAny(['nik', 'ktp']));
      allow write: if isAuthenticated() && isOwner(userId);
    }

    // Marketplace (신뢰점수 기반 접근)
    match /used_items/{itemId} {
      allow read: if isAuthenticated();
      allow create: if isAuthenticated() &&
        request.resource.data.sellerId == request.auth.uid;
      allow update: if isAuthenticated() &&
        (isOwner(resource.data.sellerId) ||
         request.resource.data.diff(resource.data).affectedKeys()
           .hasOnly(['likesCount', 'viewCount']));
      allow delete: if isAuthenticated() && isOwner(resource.data.sellerId);
    }

    // 채팅 (1:1 참여자만 접근)
    match /chat_rooms/{roomId}/messages/{messageId} {
      allow read, write: if isAuthenticated() &&
        request.auth.uid in get(/databases/$(database)/documents/chat_rooms/$(roomId)).data.participants;
    }
  }
}
```

---

## 쿼리 최적화 패턴

### 커서 페이지네이션 (필수)
```dart
// ✅ 올바른 페이지네이션
Future<List<ProductModel>> fetchNextPage({
  DocumentSnapshot? lastDoc,
  required String kabupaten,
  int limit = 20,
}) async {
  Query query = _firestore
    .collection('used_items')
    .where('locationParts.kabupaten', isEqualTo: kabupaten)
    .where('geoScope', isEqualTo: 'neighborhood')
    .orderBy('signalScore', descending: true)
    .orderBy('createdAt', descending: true)
    .limit(limit);

  if (lastDoc != null) {
    query = query.startAfterDocument(lastDoc);
  }
  return (await query.get()).docs
    .map((d) => ProductModel.fromJson(d.data()))
    .toList();
}
```

### GeoHash 반경 쿼리 (인도네시아 동네 단위)
```dart
// 5km 반경 (동네 단위)
final bounds = Geoflutterfire2.instance.collection(
  collectionRef: _firestore.collection('used_items'),
).within(
  center: GeoFirePoint(lat, lng),
  radius: 5.0,         // km
  field: 'locationParts',
  strictMode: true,
);
```

---

## 인도네시아 행정구역 데이터

```javascript
// metadata/country_configs/ID 문서
{
  "provinsi": [
    { "code": "JB", "name": "Jawa Barat", "cities": ["Bandung", "Bekasi", "Bogor", "Depok", "Cimahi"] },
    { "code": "JK", "name": "DKI Jakarta", "cities": ["Jakarta Pusat", "Jakarta Utara", "Jakarta Barat", "Jakarta Selatan", "Jakarta Timur"] },
    { "code": "JT", "name": "Jawa Tengah", "cities": ["Semarang", "Solo", "Magelang"] },
    { "code": "JI", "name": "Jawa Timur", "cities": ["Surabaya", "Malang", "Sidoarjo"] },
    // ... 34개 Provinsi 전체
  ],
  "timezone_map": {
    "JK": "WIB", "JB": "WIB", "JT": "WIB", "JI": "WIB",
    "BA": "WITA", "NTB": "WITA", "NTT": "WITA",
    "MA": "WIT", "PA": "WIT"
  }
}
```
