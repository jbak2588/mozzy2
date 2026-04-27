# PROMPT-SET.md — Claude Code 개발 지시 프롬프트 세트

> **사용법**: 각 Phase 시작 시, 해당 섹션의 프롬프트를 Claude Code에 그대로 입력
> **순서**: Phase 0 → 1 → 2 ... 순서 준수 (의존성 있음)
> **에이전트 호출**: `--agent agents/{name}-agent.md` 플래그 사용

---

## 🚀 Phase 0 — 프로젝트 셋업 프롬프트

### P0-1. 초기화 (architect-agent 주도)
```
@agents/architect-agent.md

CLAUDE.md를 읽고 Mozzy Indonesia 프로젝트를 초기화한다.

작업 목록:
1. lib/mozzy_ii/ 전체 폴더 구조 생성 (CLAUDE.md의 목표 구조 참조)
2. lib/shared/contracts/post_contract.dart 생성
   - MozzyPostContract abstract class
   - GeoScope enum (neighborhood·city·country·global)
   - ReachMode enum (local_only·progressive·global_relay)
3. assets/config/countries/ID.json 생성 (geo-agent.md의 완전 정의 참조)
4. lib/mozzy_ii/core/config/country_registry_service.dart 생성
5. lib/mozzy_ii/core/utils/rate_limiter.dart 생성

완료 후 폴더 트리를 출력하고 architect-agent 검토 결과를 제시한다.
```

### P0-2. Firebase 연동 (deploy-agent 주도)
```
@agents/deploy-agent.md

Firebase 설정을 완료한다. firebase_options.dart는 이미 생성되어 있다고 가정한다.

작업:
1. lib/main.dart 생성
   - ProviderScope (Riverpod 3)
   - EasyLocalization (id·en 우선)
   - Firebase.initializeApp()
   - Hive.initFlutter()
2. pubspec.yaml에 필수 패키지 추가 (CLAUDE.md 기술스택 참조)
3. .github/workflows/deploy-id.yml 생성 (deploy-agent.md 참조)
4. firestore.rules 초안 생성 (security-agent.md 참조)
5. firestore.indexes.json 초안 생성 (빈 인덱스 배열로 시작)

반드시 Riverpod 3만 사용. GetX·Provider import 절대 금지.
```

### P0-3. i18n 기반 설정 (i18n-agent 주도)
```
@agents/i18n-agent.md

다국어 기반을 설정한다.

작업:
1. assets/translations/id.json 생성 (i18n-agent.md의 완전판 키 전체 포함)
2. assets/translations/en.json 생성 (영문 번역)
3. assets/translations/ko.json 생성 (한국어)
4. lib/mozzy_ii/core/utils/currency_formatter.dart 생성
   - formatIDR(double amount) → "Rp 1.500.000" (인도네시아식 점 구분)
   - formatIDRCompact(double amount) → "1,5Jt" / "500Rb"
   - formatDate(DateTime dt, {String locale = 'id'}) → "12 April 2026"
5. lib/mozzy_ii/core/utils/indonesia_phone_formatter.dart 생성
   - +62 prefix 자동 처리
   - 0xxx → 62xxx 변환

테스트: formatIDR(1500000) == "Rp 1.500.000" 확인
```

---

## 🗺️ Phase 1 — App Shell + Geo 프롬프트

### P1-1. Geo Layer (geo-agent 주도)
```
@agents/geo-agent.md

인도네시아 Track 1+2 듀얼 트랙 Geo Layer를 구현한다.

작업:
1. lib/mozzy_ii/geo/models/location_parts.dart
   - IndonesiaGeoAddress (Track 1: provinsi·kabupaten·kecamatan·kelurahan)
   - GlobalGeoAddress (Track 2: l1·l2·l3)
   - LocationParts (두 트랙 통합 + geoPoint + geoHash + countryCode)

2. lib/mozzy_ii/geo/location/indonesia_location_service.dart
   - reverseGeocode(LatLng) → IndonesiaGeoAddress
   - detectTimezone(String provinsiCode) → IndonesiaTimezone (WIB·WITA·WIT)
   - formatAddress(addr, AddressDetail) → String

3. lib/mozzy_ii/geo/providers/location_provider.dart (Riverpod 3 AsyncNotifier)
   - build(): GPS 위치 획득 → 역지오코딩
   - changeLocation(LocationParts): 수동 위치 변경

4. lib/mozzy_ii/geo/screens/location_permission_screen.dart
   - Bahasa Indonesia 안내 텍스트
   - 권한 거부 시 수동 도시 검색 fallback

5. assets/config/indonesia_provinces.json (34개 Provinsi 데이터)

geo-agent.md의 IndonesiaTimezone·GeoScope·GeoScopeRadius 코드 그대로 구현.
```

### P1-2. 인증 시스템 (dart-agent 주도)
```
@agents/dart-agent.md

인도네시아 특화 인증 시스템을 구현한다.

작업:
1. lib/mozzy_ii/app/auth/
   - auth_service.dart (Firebase Auth 래핑)
   - auth_provider.dart (Riverpod 3 StreamProvider)
   - auth_gate.dart (로그인 상태 라우팅)

2. lib/mozzy_ii/domains/ 외부에 auth_screen 구현:
   - 전화번호 입력 (+62 인도네시아 prefix 고정)
   - SMS OTP 6자리 입력
   - Google 로그인 버튼 (보조)

3. lib/mozzy_ii/domains/users/data/models/user_model.dart (Freezed)
   - uid, displayName, phoneHash (해시만 저장, PDPB)
   - locationParts (인도네시아 주소)
   - trustScore (초기값 0.3)
   - mozzyPlusExpiry, businessPlusExpiry

4. Trust Score 초기화 로직:
   - 신규 가입: 0.3 (Anggota Baru)
   - 전화 인증: +0.2 (0.5 → Terpercaya)
   - 첫 거래 완료: +0.1

보안: NIK 절대 저장 금지. PDPB 준수.
security-agent.md Firestore Rules 반드시 적용.
```

### P1-3. Navigation + Theme (dart-agent)
```
@agents/dart-agent.md

App Shell의 Navigation과 Theme을 구현한다.

작업:
1. lib/mozzy_ii/app/navigation/app_router.dart (GoRouter)
   - 11개 Feature 라우트 정의
   - /news, /marketplace, /jobs, /auction, /clubs,
     /lost-found, /pom, /real-estate, /stores, /together, /chat
   - 딥링크 지원: mozzy://item/{id}

2. lib/mozzy_ii/app/navigation/main_scaffold.dart
   - 하단 탭바 (5개 주요 Feature)
   - FAB (빠른 게시 버튼)

3. lib/mozzy_ii/app/theme/mozzy_theme.dart
   - Primary: 인도네시아 빨강 #CC0001
   - Secondary: 흰색 계열 #F5F5F5
   - Nunito Sans 폰트
   - 터치 영역 최소 48dp

4. lib/mozzy_ii/design_system/ 공통 위젯:
   - MozzyAppBar
   - MozzyButton (Primary·Secondary·Text)
   - ShimmerPlaceholder (로딩 상태)
   - EmptyStateWidget (인도네시아어 텍스트)
   - ErrorRetryWidget

모든 텍스트는 easy_localization 키 사용. 하드코딩 금지.
```

---

## 🛒 Phase 2 — Core Features 프롬프트

### P2-1. Local News (dart-agent + firestore-agent 병렬)
```
@agents/dart-agent.md @agents/firestore-agent.md

병렬 작업: dart-agent는 코드, firestore-agent는 인덱스 담당.

[dart-agent 작업]
1. lib/mozzy_ii/domains/local_news/ 전체 구현
   - PostModel (Freezed, MozzyPostContract 구현 필수)
   - PostRepository (fetchByKecamatan, fetchByCategory, createPost)
   - PostsProvider (Riverpod 3 AsyncNotifier)
   - LocalNewsListScreen (카테고리 탭: Umum·Info·Event·Darurat·Kuliner·Tips)
   - LocalNewsDetailScreen + CrossLinkSection
   - CreatePostScreen (이미지 5장, 카테고리, 위치 자동)

[firestore-agent 작업]
1. posts 컬렉션 인덱스 12개 정의 (firestore-agent.md 예산 참조)
2. Security Rules posts 섹션 추가

공통 요건:
- 금액/날짜/주소 모두 인도네시아 포맷
- 모든 텍스트는 id.json 키 사용
- Firestore 쿼리는 커서 페이지네이션
```

### P2-2. Marketplace AI 검수 (dart-agent + ai-agent 체인)
```
chain:
  1. @agents/architect-agent.md "Marketplace 도메인 아키텍처 검토"
  2. @agents/dart-agent.md "Marketplace 구현"
  3. @agents/ai-agent.md "AI 검수 서비스 연동"

[dart-agent 작업]
lib/mozzy_ii/domains/marketplace/ 전체:
- ProductModel (isAiVerified, aiVerificationData, IDR 가격)
- MarketplaceRepository (GeoHash 반경 쿼리)
- MarketplaceListScreen (그리드/리스트 전환)
- ProductDetailScreen (AI 검수 배지, CrossLinkSection)
- CreateProductScreen (이미지 5장 + WebP 압축, IDR 입력, 거래방식 COD/Pengiriman)
- SavedItemsProvider (찜하기)

[ai-agent 작업]
lib/mozzy_ii/domains/marketplace/domain/services/marketplace_ai_service.dart:
- verifyProduct() — Gemini 3.0 호출 (ai-agent.md 구현 코드 그대로)
- Rate Limiter 적용 (maxPerMinute: 10)
- 인도네시아어 프롬프트 사용 (Bahasa Indonesia)
- AI 검수 결과 UI: AiVerificationResultSheet

반드시: IDR 가격 표시 formatIDR() 사용
```

### P2-3. 채팅 시스템 (dart-agent)
```
@agents/dart-agent.md

실시간 채팅 시스템을 구현한다.

작업:
1. lib/mozzy_ii/domains/chat/
   - ChatRoomModel, MessageModel (Freezed)
   - ChatRepository (Firebase Realtime DB 또는 Firestore)
   - ChatListScreen (채팅방 목록)
   - ChatDetailScreen (실시간 메시지)
   - 이미지 전송, 읽음 확인

2. 모든 Feature에서 채팅 진입점:
   - "Chat dengan Penjual" (Marketplace)
   - "Hubungi Pemasang" (Jobs)
   - "Tanya Pemilik" (Stores)

3. FCM 푸시 알림 (미읽 메시지)
   - Cloud Function: onNewMessage → FCM 발송
   - Bahasa Indonesia 알림 텍스트

4. 차단/신고 기능

Chat 추천 광고 Placeholder G 위치 지정 (구현은 Phase 4).
```

### P2-4. Phase 2 통합 테스트 (test-agent)
```
@agents/test-agent.md

Phase 2에서 구현된 코드의 테스트를 작성한다.

작업:
1. test/domains/local_news/post_repository_test.dart (15개+)
   - fetchByKecamatan 반환값 검증
   - 페이지네이션 커서 동작
   - MozzyPostContract 구현 확인

2. test/domains/marketplace/product_model_test.dart (10개+)
   - Shared Contract 필드 존재
   - IDR 포맷 검증
   - AI 검수 데이터 직렬화

3. test/domains/marketplace/marketplace_ai_service_test.dart (8개+)
   - Mock Gemini 응답 처리
   - Rate Limiter 동작 확인
   - 인도네시아어 프롬프트 포함 여부

4. test/core/currency_formatter_test.dart (8개)
   - formatIDR(1500000) == "Rp 1.500.000"
   - formatIDRCompact(1500000) == "1,5Jt"
   - formatIDRCompact(500000) == "500Rb"

커버리지 목표: Marketplace 80%+, Shared Contract 95%+
```

---

## 💳 Phase 4 — 수익화 프롬프트

### P4-1. Midtrans 결제 (monetization-agent)
```
@agents/monetization-agent.md

인도네시아 결제 시스템을 구현한다.

작업:
1. lib/mozzy_ii/monetization/payment/midtrans_service.dart
   - monetization-agent.md의 MidtransService 코드 그대로 구현
   - 개발/운영 환경 dart-define으로 분리
   - GoPay·OVO·DANA·VA·Alfamart·QRIS 모두 구현

2. lib/mozzy_ii/monetization/payment/payment_screen.dart
   - 결제 수단 선택 UI (인도네시아어)
   - 각 수단별 아이콘 (GoPay=초록, OVO=보라, DANA=파랑)
   - 결제 금액 IDR 표시

3. Cloud Functions/functions/src/midtrans_webhook.ts
   - 결제 완료 웹훅 처리
   - Firestore 주문 상태 업데이트
   - 판매자 wallet 크레딧

4. lib/mozzy_ii/monetization/wallet/mozzy_wallet_service.dart
   - OJK 최대 잔액 Rp 20,000,000 제한
   - 충전/출금 플로우

5. lib/mozzy_ii/monetization/subscription/subscription_service.dart
   - Mozzy+: Rp 29,000/월
   - Business+: Rp 99,000/월
   - Google Play Billing 연동

결제 성공/실패 알림은 반드시 Bahasa Indonesia.
```

---

## 🧠 Phase 5 — 스마트 기능 프롬프트

### P5-1. Smart Feed + NudgeEngine (ai-agent + dart-agent)
```
@agents/ai-agent.md @agents/dart-agent.md

Smart Feed와 NudgeEngine을 구현한다.

[ai-agent 작업]
1. lib/mozzy_ii/discovery/smart_feed/smart_feed_service.dart
   - signalScore 계산 공식 구현 (dart-agent.md 코드 참조)
   - 인도네시아 시간대별 가중치 (WIB 기준)
   - Kecamatan 단위 관련성 점수

2. lib/mozzy_ii/growth/nudge/nudge_engine.dart
   - ai-agent.md의 NudgeEngine 코드 그대로 구현
   - 인도네시아어 넛지 메시지
   - FCM 발송 연동

[dart-agent 작업]
3. lib/mozzy_ii/discovery/smart_feed/unified_feed_screen.dart
   - 11개 Feature 혼합 피드
   - 시간대별 상단 Feature 변경
   - 무한 스크롤 + signalScore 정렬

4. lib/mozzy_ii/growth/neighborhood/neighborhood_identity_screen.dart
   - 동네 통계 그리드 (Warga Aktif, Postingan Hari Ini)
   - 인기 태그 #kuliner #properti
   - Feature별 Top 3 콘텐츠 섹션
```

### P5-2. Cross-Feature 7대 전략 (dart-agent)
```
@agents/dart-agent.md

7대 Cross-Feature 전략을 일괄 구현한다.

작업:
1. lib/mozzy_ii/discovery/cross_link/cross_link_section.dart
   - 모든 상세 화면 하단 "Lainnya di {kecamatan}"
   - 6개 타입: product·shop·together·job·room·post

2. PomModel 확장 (linkedContentType·linkedContentId)
   - "Promosikan di Pamer" 버튼 → 모든 Feature 상세화면
   - 연결된 원본 콘텐츠 딥링크

3. Local Stores 5탭 완성 (Produk·Lowongan·Berita·Ulasan·Info)

4. Together × All Features 연결
   - Marketplace → "Bazar Akhir Pekan" 자동 추천
   - Jobs → "Job Fair" 이벤트

5. CrossLinkService.getRelatedContent() 구현
   - Kecamatan 기반 관련 콘텐츠 Firestore 쿼리

각 Cross-Link는 i18n 키 사용. crossLink.* 키 확인.
```

---

## 🚀 Phase 6 — 런칭 준비 프롬프트

### P6-1. 최종 보안 감사 (security-agent)
```
@agents/security-agent.md

런칭 전 최종 보안 감사를 수행한다.

체크:
1. Firestore Rules 전체 테스트 (모든 컬렉션)
2. PDPB 컴플라이언스 체크리스트 검토
3. NIK/KTP 데이터 평문 저장 여부 전수 검사 (grep -r "nik\|ktp" lib/)
4. 개인정보처리방침 Bahasa Indonesia 버전 검토
5. 앱 권한 목록 검토 (최소 권한 원칙)
6. API 키 하드코딩 여부 검사 (grep -r "AIza\|MIDTRANS" lib/)

발견된 이슈 목록을 심각도(Critical·High·Medium·Low)로 분류하여 보고.
```

### P6-2. 성능 최종 최적화 (perf-agent)
```
@agents/perf-agent.md

런칭 전 성능 최적화를 완료한다.

작업:
1. 앱 시작 시간 측정 → 2초 이하 달성 방안
2. APK 크기 측정 → 30MB 이하 확인
3. 저사양 기기 시뮬레이션 테스트 (RAM 2GB 에뮬레이터)
4. 이미지 업로드 속도 최적화 (WebP + 압축)
5. 모든 ListView.builder에 itemExtent 설정 확인
6. const 생성자 사용 누락 위젯 전수 확인

보고서: 현재 수치 → 목표 → 달성 방안
```

### P6-3. PlayStore 출시 자동화 (deploy-agent)
```
@agents/deploy-agent.md

PlayStore 자동 배포 파이프라인을 완성한다.

작업:
1. .github/workflows/deploy-playstore-id.yml 생성
   - flutter build appbundle --release
   - --dart-define=COUNTRY_CODE=ID
   - Google Play API로 내부 테스트 트랙 자동 업로드

2. Fastlane 설정 (android/Fastfile)
   - lane :beta_indonesia
   - lane :production_indonesia

3. 버전 관리 자동화 (pubspec.yaml version bump)
   - 빌드 번호: GitHub Actions run_number 사용

4. 배포 완료 Slack 알림 (팀 채널)

deploy-agent.md의 PlayStore 체크리스트 모두 완료 확인.
```

---

## 🔧 공통 유틸리티 프롬프트

### U-1. 전체 코드 품질 검사 (review-agent)
```
@agents/review-agent.md

현재까지 구현된 전체 코드를 리뷰한다.

체크 항목 (review-agent.md 체크리스트 전체):
1. GetX·Provider import 존재 여부 (grep -r "import 'package:get" lib/)
2. 하드코딩 통화 (grep -r "₩\|KRW\|USD" lib/)
3. 하드코딩 한국어 문자열 (grep -r "[가-힣]" lib/ 제외 주석)
4. Firestore 인덱스 총계 (jq '.indexes | length' firestore.indexes.json)
5. MozzyPostContract 미구현 모델 탐지
6. IDR 포맷 직접 사용 여부 (formatIDR() 미사용)

결과를 Critical·Warning·Info로 분류하여 보고.
dart-agent에게 수정 작업 인계.
```

### U-2. 인도네시아 현지화 전수 검사 (i18n-agent)
```
@agents/i18n-agent.md

인도네시아어 현지화 전수 검사를 수행한다.

작업:
1. id.json의 모든 키가 코드에서 실제 사용되는지 확인
2. 코드에서 사용하는 i18n 키가 id.json에 존재하는지 확인
3. en.json·ko.json의 누락 키 목록 추출
4. 인도네시아식 숫자/날짜 포맷 사용 여부 검증
5. Bahasa Indonesia 문장 검수 (문법적으로 자연스러운지)

누락/불일치 키 목록을 출력하고 자동 수정 스크립트 제공.
```

### U-3. 테스트 커버리지 리포트 (test-agent)
```
@agents/test-agent.md

전체 테스트 커버리지를 측정하고 30% 달성 계획을 수립한다.

작업:
1. flutter test --coverage 실행
2. genhtml coverage/lcov.info -o coverage/html 실행
3. 커버리지 30% 미달 파일 목록 추출
4. 우선순위 높은 파일 (Shared Contract, Geo, Monetization) 테스트 추가
5. 커버리지 배지를 README.md에 추가

목표: 전체 30%+ (Shared Contract 95%+, Monetization 85%+)
```

---

## 🆘 긴급 수정 프롬프트

### E-1. 아키텍처 위반 긴급 수정
```
@agents/architect-agent.md @agents/dart-agent.md

아키텍처 위반을 긴급 수정한다.

위반 사항: [위반 내용 입력]

architect-agent:
1. 위반 원인 분석
2. 올바른 구현 방향 제시
3. Shared Contract 준수 방안

dart-agent:
1. 위반 코드 수정
2. 레이어 경계 준수 재구현
3. 관련 테스트 수정

수정 완료 후 architect-agent 재검토 필수.
```

### E-2. 결제 오류 긴급 대응
```
@agents/monetization-agent.md

결제 오류를 긴급 수정한다.

증상: [오류 내용 입력]

작업:
1. Midtrans 대시보드 로그 확인 방법 안내
2. 오류 코드별 처리 로직 확인
3. 사용자 환불 프로세스 안내 (인도네시아어)
4. 재발 방지 코드 수정

인도네시아 결제 오류 시 사용자에게 WhatsApp CS 안내 (Bahasa Indonesia).
```
