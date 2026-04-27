# security-agent.md — 보안 · PDPB · Firestore Rules 에이전트

> **역할**: 인도네시아 PDPB(개인정보보호법) 준수 · Firestore Rules · 보안 스캔

---

## 인도네시아 PDPB 핵심 요건

### 절대 금지 (PDPB 위반)
```
❌ NIK (Nomor Induk Kependudukan, 주민등록번호) Firestore 평문 저장
❌ KTP 이미지 Firebase Storage 무기한 보관 (최대 30일)
❌ 사용자 위치 데이터 제3자 공유 (명시적 동의 없이)
❌ 만 17세 미만 사용자 개인정보 수집 (부모 동의 없이)
```

### 필수 구현
```dart
// 1. 데이터 최소화 원칙
class UserModel {
  final String uid;
  final String displayName;
  final String? phoneHash;     // 전화번호 해시만 저장
  // NIK은 절대 저장하지 않음
}

// 2. 동의 관리
class ConsentService {
  Future<void> requestConsent(List<ConsentType> types);
  Future<bool> hasConsent(ConsentType type);
  Future<void> revokeConsent(ConsentType type);
}

// 3. 데이터 삭제권 (Right to Erasure)
class DataDeletionService {
  Future<void> deleteAllUserData(String userId) async {
    // Firestore 문서, Storage 파일, FCM 토큰 일괄 삭제
  }
}
```

### Firestore Rules 핵심 (인도네시아)
```javascript
// 위치 데이터 보호 — 정밀 좌표는 본인만 접근
match /users/{userId} {
  allow read: if isAuthenticated() && (
    isOwner(userId) ||
    // 타인은 대략적 위치만 (kecamatan 레벨)
    !request.resource.data.keys().hasAny(['exactGeoPoint', 'geoHash'])
  );
}

// KTP 인증 데이터 — 엄격 접근 제한
match /kyc_data/{userId} {
  allow read, write: if isAuthenticated() && isOwner(userId);
  // 관리자도 원본 데이터 접근 불가 (해시만)
}
```

---

# perf-agent.md — 성능 최적화 에이전트

> **역할**: 인도네시아 저사양 기기 최적화 · 위젯 트리 · 번들 사이즈

---

## 인도네시아 기기 환경

```
저가 기기 (타겟 40%):  RAM 2GB, Snapdragon 4xx, 32GB 스토리지
중가 기기 (타겟 45%):  RAM 4GB, Snapdragon 6xx
고가 기기 (타겟 15%):  RAM 8GB+, Snapdragon 8xx
평균 LTE 속도:          ~20Mbps (도심), ~5Mbps (외곽)
```

## 성능 최적화 체크리스트

### 이미지 최적화
```dart
// ✅ WebP 변환 + 압축 (업로드 전)
Future<File> compressForUpload(File image) async {
  final result = await FlutterImageCompress.compressWithFile(
    image.path,
    format: CompressFormat.webp,
    quality: 80,
    minWidth: 1080,
    minHeight: 1080,
  );
  // 결과 크기 검증: 1MB 초과 시 quality 낮춤
}

// ✅ 썸네일 별도 생성 (리스트용 300px)
Future<String> generateThumbnail(String imageUrl) async { ... }
```

### 위젯 최적화
```dart
// ✅ const 생성자 최대 활용
const SizedBox(height: 8),
const Divider(),

// ✅ RepaintBoundary로 비싼 위젯 격리
RepaintBoundary(child: MapWidget()),

// ✅ ListView.builder (절대 ListView(children:[...]) 금지)
ListView.builder(
  itemCount: items.length,
  itemExtent: 120,  // 고정 높이 필수 (저사양 기기 성능↑)
  itemBuilder: (_, i) => ProductCard(item: items[i]),
)
```

### 번들 크기 최적화
```yaml
# pubspec.yaml - 불필요한 패키지 금지
# ❌ 피할 것:
#   - get (GetX) — Riverpod으로 대체
#   - lottie 과도한 사용 — 저사양 기기 부담
#   - firebase_ml_vision — ML Kit로 대체

# 타겟 APK 크기: < 30MB (저장공간 부족 기기 고려)
```

---

# review-agent.md — 코드 리뷰 에이전트

> **역할**: PR 리뷰 · 코드 품질 · 아키텍처 위반 탐지

## PR 리뷰 체크리스트

```markdown
### 아키텍처
- [ ] 레이어 경계 위반 없음 (Feature 간 직접 import 없음)
- [ ] MozzyPostContract 구현됨
- [ ] Riverpod 3만 사용 (GetX/Provider import 없음)

### 인도네시아 특화
- [ ] 인도네시아 주소 Track 1 (Provinsi→Kelurahan) 지원
- [ ] 금액 표시가 IDR (Rp) 기준
- [ ] 인도네시아어(id) 번역 키 존재
- [ ] PDPB 위반 사항 없음

### 코드 품질
- [ ] 하드코딩 문자열 없음 (i18n 키 사용)
- [ ] 하드코딩 통화 없음 (CurrencyService 사용)
- [ ] 에러 핸들링 존재
- [ ] 로딩/에러 상태 UI 존재

### 테스트
- [ ] 신규 기능에 대한 테스트 존재
- [ ] Mock 객체 올바르게 사용
```

---

# deploy-agent.md — CI/CD · 배포 에이전트

> **역할**: GitHub Actions · Firebase App Distribution · PlayStore · AppStore

## 인도네시아 배포 파이프라인

```yaml
# .github/workflows/deploy-id.yml
name: Deploy Mozzy Indonesia

on:
  push:
    branches: [main]
    paths: ['lib/**', 'assets/**', 'pubspec.yaml']

jobs:
  test:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v4
      - uses: subosito/flutter-action@v2
        with: { flutter-version: '3.27.0' }
      - run: flutter test --coverage
      - run: |
          COVERAGE=$(lcov --summary coverage/lcov.info | grep "lines" | grep -o '[0-9.]*%')
          echo "Coverage: $COVERAGE"
          # 30% 미만이면 배포 중단

  build-android-id:
    needs: test
    runs-on: ubuntu-latest
    env:
      COUNTRY_CODE: ID
      MIDTRANS_SERVER_KEY: ${{ secrets.MIDTRANS_SERVER_KEY_ID }}
      MIDTRANS_PRODUCTION: true
    steps:
      - run: flutter build appbundle --release
          --dart-define=COUNTRY_CODE=ID
          --dart-define=MIDTRANS_SERVER_KEY=$MIDTRANS_SERVER_KEY
          --dart-define=MIDTRANS_PRODUCTION=true

  deploy-firebase-dist:
    needs: build-android-id
    runs-on: ubuntu-latest
    steps:
      - uses: wzieba/Firebase-Distribution-Github-Action@v1
        with:
          appId: ${{ secrets.FIREBASE_APP_ID_ANDROID_ID }}
          token: ${{ secrets.FIREBASE_TOKEN }}
          groups: beta-indonesia  # 인도네시아 베타 테스터 그룹
          releaseNotes: "Mozzy Indonesia Beta - ${{ github.sha }}"
```

## PlayStore 인도네시아 출시 전 체크리스트
```
□ 앱 설명: Bahasa Indonesia 버전 존재
□ 스크린샷: 인도네시아 도시(자카르타/반둥) 배경
□ 컨텐츠 등급: 인도네시아 PEGI/ESRB 완료
□ 개인정보처리방침: Bahasa Indonesia + PDPB 준수 명시
□ 결제 수단: Midtrans (인도네시아 승인 PSP) 사용 명시
□ 앱 권한 설명: 위치/카메라/저장소 사용 목적 Bahasa Indonesia로 명시
```

---

# market-agent.md — 인도네시아 시장 분석 에이전트

> **역할**: 현지화 전략 · 경쟁사 분석 · KPI 추적 · GTM(Go-to-Market)

## 인도네시아 경쟁사 분석

| 경쟁사 | 강점 | 약점 | Mozzy 차별화 |
|--------|------|------|-------------|
| Tokopedia | 커머스 최강 | 하이퍼로컬 없음 | 동네 기반 중고/지역 커뮤니티 |
| Gojek | 슈퍼앱 인지도 | 지역 커뮤니티 없음 | AI 동네 아이덴티티 |
| Kaskus | 커뮤니티 강함 | 오래된 UX, 모바일 부족 | 현대적 모바일 UX + AI |
| OLX | 중고거래 1위 | AI 없음, 신뢰도 낮음 | AI 검수 + Trust Score |
| Facebook Groups | 소셜 강함 | 거래 안전성 없음 | 검증된 로컬 거래 생태계 |

## 인도네시아 GTM 전략 (Phase 1)

### 런칭 도시 우선순위
```
1순위: Kota Bandung (반둥)
  이유: 인구 260만, 대학생 밀집, 디지털 친화, 경쟁 덜함
  전략: 대학가(Coblong, Sukajadi) 중심 바이럴 캠페인

2순위: Jakarta Selatan (남자카르타)
  이유: 구매력 최상위, 트렌드 세터
  전략: Influencer 마케팅 + Business 광고주 유치

3순위: Kota Surabaya (수라바야)
  이유: 자바 동부 최대 도시, 가격 민감도 높아 중고거래 활성
  전략: Marketplace 집중 마케팅
```

### 인도네시아 KPI 대시보드
```
월별 추적 지표:
- DAU/MAU 비율 (목표: 40%+)
- 도시별 MAU 성장률
- Feature별 세션 진입률
- Midtrans 결제 성공률 (목표: 95%+)
- GoPay vs OVO vs DANA 결제 비율
- D7/D30 리텐션 (도시별)
- MRR (IDR 기준)
- App Store Rating (인도네시아 리뷰)
- CS 티켓 수 / 해결 시간
```
