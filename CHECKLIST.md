# CHECKLIST.md — Mozzy Indonesia 단계별 개발 체크리스트

> **사용법**: 각 Phase 시작 전 해당 섹션 전체 읽기 → 완료 시 `[x]` 체크
> **담당 에이전트**: 각 항목 옆에 표시
> **업데이트**: 매주 금요일 진행률 리뷰

---

## 🔲 Phase 0 — 프로젝트 셋업 (Week 1~2)

### 0-A. 개발 환경 구성
- [x] Flutter 3.27+ 설치 확인 (`flutter --version`)
- [x] Dart 3.6+ 확인
- [x] Android Studio / VS Code + Flutter extension 설정
- [x] Firebase CLI 설치 (`npm install -g firebase-tools`)
- [x] FlutterFire CLI 설치 (`dart pub global activate flutterfire_cli`)
- [x] Google Cloud SDK 설치 (Gemini API용)

### 0-B. Firebase 프로젝트 구성 (인도네시아)
- [x] Firebase 프로젝트 생성: `mozzy-indonesia-prod` (mozzy-v2로 대체)
- [ ] Firebase 프로젝트 생성: `mozzy-indonesia-dev`
- [x] 서비스 활성화:
  - [x] Firestore (asia-southeast2 — 자카르타 리전)
  - [x] Authentication (Google Sign-In 단일화 적용)
  - [ ] Storage
  - [ ] Cloud Functions (Node.js 20)
  - [ ] FCM (Push Notification)
  - [ ] Analytics
  - [ ] Crashlytics
- [x] `flutterfire configure` 실행 → `firebase_options.dart` 생성
- [x] `.env` 파일 생성 (MIDTRANS_SERVER_KEY, GEMINI_API_KEY) - 기본 구조 마련
- [x] `.gitignore`에 `.env`, `firebase_options.dart` 추가 확인

### 0-C. Flutter 프로젝트 초기화
- [x] `flutter create mozzy_id --platforms android,ios` 실행
- [x] `pubspec.yaml` 핵심 패키지 추가
- [x] `flutter pub get` 성공
- [x] `flutter run` 기본 실행 확인

### 0-D. 아키텍처 기반 설정 (architect-agent)
- [x] 폴더 구조 생성 (`lib/mozzy_ii/` 전체)
- [x] `CLAUDE.md` 프로젝트 루트에 위치
- [x] `assets/config/countries/ID.json` 생성 (CountryRegistry)
- [x] `assets/translations/id.json` 생성 (인도네시아어 마스터)
- [x] `assets/translations/en.json` 생성
- [x] `assets/translations/ko.json` 생성 (다국어 확장)
- [x] `lib/mozzy_ii/shared/contracts/mozzy_post_contract.dart` 생성 (MozzyPostContract)
- [x] Firestore Security Rules 초안 (`firestore.rules`) 작성
- [x] `firestore.indexes.json` 초안 생성

### 📝 메모 및 주요 결정 사항 (Memos & Decisions)
* **[2026-04-27] 인덱스 최적화 전략 확정**: 132개 인덱스 제한 준수 및 다국가 확장을 위해 `countryCode`를 쿼리 필드가 아닌 경로(Path) 기반으로 격리하기로 결정함. (자세한 내용은 `docs/Firestore_Architecture_Strategy.md` 참조)
* **[2026-04-27] Firebase 비용 지원 연동**: Google for Startups 크레딧은 '프로젝트'가 아닌 '결제 계정' 단위로 적용되므로, 신규 프로젝트 생성 시 기존 계정(bling_app 사용 계정)을 그대로 연결하여 지원 유지 가능.
* **[2026-04-27] Phase 1-B/D 기초 구현 완료**: AuthService(Google 로그인 전환 적용), MozzyFormatters(IDR/날짜), 번역 키(id, en, ko) 업데이트 및 AuthGate 연동 완료.
* **[2026-04-27] Trust Layer & 테스트 완료**: TrustScoreService/Badge 구현 완료 및 주요 서비스들에 대한 단위/위젯 테스트(20개+) 통과 확인. google_sign_in 7.2.0 API 대응 완료.

### 0-E. CI/CD 파이프라인 (deploy-agent)
- [x] GitHub 저장소 생성 (Private) (수동)
- [x] GitHub Actions 워크플로우 생성 (`.github/workflows/deploy-id.yml`)
- [ ] Firebase App Distribution 설정 (수동 연결 필요 - 추후 진행)
- [x] 브랜치 전략 문서화: `main` → Production, `develop` → Staging
- [ ] Secrets 설정: `FIREBASE_TOKEN`, `MIDTRANS_SERVER_KEY`, `GEMINI_API_KEY` (수동 설정 필요 - 추후 진행)

**Phase 0 완료 기준**: `flutter test` 통과 + Firebase 연결 확인 + CI 첫 빌드 성공 ➔ **(✅ 완료)**

---

## 🔲 Phase 1 — App Shell + Geo Layer (Week 3~6)

### 1-A. App Shell 구현 (dart-agent)
- [x] `main.dart` — ProviderScope + EasyLocalization 래핑
- [x] `app/theme/mozzy_theme.dart` — 인도네시아 디자인 테마 (색상, 폰트)
- [x] `app/navigation/app_router.dart` — GoRouter 설정 (11개 Feature 라우트)
- [x] `app/auth/auth_gate.dart` — 인증 상태 기반 라우팅
- [ ] `app/deep_link/deep_link_service.dart` — 딥링크 처리 (추후 연동)

### 1-B. 인증 시스템 (dart-agent + security-agent)
- [ ] 전화번호 인증 (인도네시아 +62 SMS OTP) - 보류 (Google 로그인 단일화)
- [x] Google 소셜 로그인 (빠른 개발을 위해 단일화 적용)
- [x] 익명 로그인 (둘러보기 모드)
- [x] 사용자 프로필 생성 (최소 정보 — PDPB 준수)
- [ ] KTP 검증 옵션 (Trust Score 향상용, 선택사항)
- [x] 로그인 상태 Riverpod Provider 구현 (AuthService, authStateProvider)

### 1-C. 인도네시아 Geo Layer (geo-agent)
- [x] `IndonesiaLocationService` 구현
  - [x] GPS 위치 획득 (Geolocator)
  - [x] 역지오코딩 → Track 1 주소 (Provinsi→Kelurahan) 변환
  - [x] 타임존 자동 감지 (WIB/WITA/WIT)
- [x] `CountryRegistryService` 구현 (ID.json 로드)
- [x] `LocationProvider` Riverpod 3 구현
- [x] 위치 권한 요청 UI (인도네시아어)
- [x] 위치 수동 변경 기능 (도시 검색) (Provider에 updateLocationManually 구현 및 Screen Fallback 대기)
- [x] `SharedMapBrowserScreen` 기본 구조 (Google Maps)

### 1-D. 인도네시아 i18n 기반 (i18n-agent)
- [x] `id.json` 완성 (공통 UI 키 포함)
- [x] `en.json` 완성
- [x] `ko.json` 완성 (한국어 지원 추가)
- [x] `easy_localization` 설정 완료
- [x] 앱 내 언어 변경 기능 (메인 홈 화면에 적용)
- [x] 인도네시아 숫자/날짜/통화 포맷터 구현 (MozzyFormatters)
  - [x] `formatIDR()` 함수 (Rp 1.500.000 형식)
  - [x] `formatIDRCompact()` (1,5Jt / 500Rb)
  - [x] 인도네시아식 날짜 (12 April 2026)

### 1-E. Trust Layer 기반 (security-agent + dart-agent)
- [x] `TrustScoreService` 기본 구현
- [x] Trust Level 정의: Anggota Baru → Terpercaya → Terverifikasi → Hero Lokal
- [x] `TrustScoreBadge` 위젯
- [ ] 신고 시스템 기본 구조

### 1-F. Phase 1 테스트 (test-agent)
- [x] `IndonesiaLocationService` 단위 테스트 10개+
- [x] `CountryRegistryService` 단위 테스트 5개+
- [x] IDR 포맷터 단위 테스트 8개+
- [x] Auth flow 위젯 테스트 5개+

**Phase 1 완료 기준**: 앱 실행 → 위치 감지 → 인도네시아 주소(Kecamatan) 표시 → 로그인 완료 ➔ **(✅ 완료)**
---

## 🔲 Phase 2 — Core 3 Features MVP (Week 7~10)

### 2-A. Local News (Berita Lokal) — architect-agent → dart-agent
- [ ] `PostModel` (MozzyPostContract 구현, Track 1 주소 포함)
- [ ] `PostRepository` (Firestore CRUD + 커서 페이지네이션)
- [ ] `PostsProvider` Riverpod 3
- [ ] `LocalNewsListScreen` (카테고리 탭 — 인도네시아화)
  - 카테고리: Umum, Info, Event, Darurat, Kuliner, Tips Hidup
- [ ] `LocalNewsDetailScreen` + CrossLinkSection
- [ ] `CreatePostScreen` (이미지 5장, 카테고리, 위치 자동)
- [ ] 인도네시아 언어 태그 시스템

### 2-B. Marketplace (Jual Beli) — dart-agent + ai-agent
- [ ] `ProductModel` (MozzyPostContract, isAiVerified, IDR 가격)
- [ ] `MarketplaceRepository` (GeoHash 반경 쿼리)
- [ ] `MarketplaceListScreen` (그리드/리스트 전환)
- [ ] `ProductDetailScreen` + AI 검수 배지
- [ ] `CreateProductScreen`
  - [ ] 이미지 업로드 (최대 5장, WebP 압축)
  - [ ] IDR 가격 입력 (인도네시아식 포맷)
  - [ ] 인도네시아 카테고리 (Electronics, Fashion, Furniture...)
  - [ ] 거래 방식: COD (Ketemu Langsung) / Pengiriman
- [ ] `MarketplaceAiService` Gemini 3.0 연동 + Rate Limiter
- [ ] AI 검수 플로우 UI (로딩 → 결과 리포트 → 배지)
- [ ] 찜하기(Simpan) 기능
- [ ] SharedMapBrowser 연동 (mapVisibility)

### 2-C. Chat (Pesan) — dart-agent
- [ ] `ChatRoomModel`, `MessageModel`
- [ ] 1:1 채팅 (모든 Feature에서 "Chat dengan Penjual/Pemasang" 진입)
- [ ] Firebase Realtime 기반 실시간 메시지
- [ ] 읽음 확인 (Read Receipt)
- [ ] 이미지 전송
- [ ] FCM 푸시 알림 (미읽 메시지)
- [ ] 차단/신고 기능

### 2-D. Firestore 인덱스 최적화 (firestore-agent)
- [ ] `posts` 컬렉션 인덱스 12개 정의
- [ ] `used_items` 컬렉션 인덱스 18개 정의
- [ ] `chat_rooms` 컬렉션 인덱스 6개 정의
- [ ] 총 인덱스 수 132개 이하 확인
- [ ] `firestore.indexes.json` 배포 완료

### 2-E. 오프라인 캐시 (perf-agent)
- [ ] Hive 초기화 및 스키마 설계
- [ ] `PostLocalDataSource` (뉴스 캐시 24시간)
- [ ] `ProductLocalDataSource` (마켓 캐시 1시간)
- [ ] 네트워크 상태 감지 → 오프라인 배너 표시 (인도네시아어)

### 2-F. Phase 2 테스트
- [ ] PostRepository 테스트 15개+
- [ ] ProductModel Shared Contract 테스트 10개+
- [ ] MarketplaceAiService Mock 테스트 8개+
- [ ] Chat 실시간 테스트 5개+
- [ ] IDR 포맷 통합 테스트

**Phase 2 완료 기준**: 반둥 Coblong 기준 뉴스 표시 + 물품 등록/AI검수 + 채팅 완료

---

## 🔲 Phase 3 — 나머지 8개 Feature (Week 11~14)

### 3-A. Jobs (Lowongan Kerja)
- [ ] `JobPostModel` (인도네시아 급여 체계 — Rp/bulan, Rp/hari)
- [ ] `JobsListScreen` (지도 기반 탐색)
- [ ] `JobDetailScreen` + Local Store 연동
- [ ] `CreateJobScreen` (인도네시아 업종 카테고리)
- [ ] AI 직무 설명 자동 생성 (Bahasa Indonesia)
- [ ] Local Stores "채용 탭" 연동
- [ ] "Lamar Sekarang" → 채팅 진입

### 3-B. Auction (Lelang)
- [ ] `AuctionModel` (입찰 트랜잭션, AI 감정 연동)
- [ ] 실시간 입찰 (Firestore 트랜잭션)
- [ ] AI 감정 Gemini 3.0 연동
- [ ] 낙찰 FCM 알림
- [ ] 에스크로 기본 구조 (Midtrans 연동)

### 3-C. Clubs (Komunitas)
- [ ] `GroupModel`, `GroupProposalModel`
- [ ] 그룹 제안 → 자동 개설 Cloud Function
- [ ] 인도네시아 관심사 카테고리 (Olahraga, Kuliner, Belajar...)
- [ ] Together 이벤트 연동

### 3-D. Lost & Found (Barang Hilang)
- [ ] `LostFoundModel` (type: lost/found)
- [ ] `LostFoundAiService` 이미지 유사도 매칭
- [ ] Kecamatan 단위 자동 알림
- [ ] Local News "속보" 자동 게시 연동

### 3-E. POM/뽐 (Pamer!)
- [ ] `PomModel` (image/video, linkedContentType/Id)
- [ ] 틱톡 스타일 풀스크린 뷰어
- [ ] 숏폼 비디오 업로드 + 썸네일 생성
- [ ] 크리에이터 수익 배분 로직 (광고 수익 30%)
- [ ] 모든 Feature → Pom 홍보 연동

### 3-F. Real Estate (Properti)
- [ ] `RealEstateModel` (인도네시아 부동산: Kos, Kontrak, Sewa, Jual)
- [ ] 인도네시아 부동산 거래 유형 (Sewa Bulanan, Kontrak Tahunan)
- [ ] 지도 기반 매물 탐색
- [ ] 중개업자 Business+ 계정 연동

### 3-G. Local Stores (Toko Sekitar)
- [ ] `ShopModel` (5탭 구조: Info·Produk·Lowongan·Berita·Ulasan)
- [ ] 가게 대시보드 (Business Center)
- [ ] Marketplace·Jobs·News 통합 탭
- [ ] 쿠폰/프로모션 생성
- [ ] Business+ 구독 월정액 결제

### 3-H. Together (Bareng Yuk!)
- [ ] `TogetherPostModel` (디지털 전단지 UI)
- [ ] 세 가지 테마: Neon/Paper/Dark
- [ ] QR 티켓 생성 + 스캐너 (Together Pass)
- [ ] Google Maps 모임 장소 핀 설정

### 3-I. Phase 3 테스트
- [ ] 각 Feature Model Shared Contract 테스트 (8 Feature × 5개 = 40개+)
- [ ] Cross-Feature 연결 통합 테스트 10개+
- [ ] AI 서비스 Rate Limiter 테스트 5개+

---

## 🔲 Phase 4 — 수익화 시스템 (Week 15~18)

### 4-A. Midtrans 결제 통합 (monetization-agent)
- [ ] `MidtransService` 구현 (개발/운영 환경 분리)
- [ ] GoPay 결제 플로우 (딥링크 고젝 앱 연동)
- [ ] OVO 결제 플로우
- [ ] DANA 결제 플로우
- [ ] Virtual Account (BCA/Mandiri/BNI/BRI) 플로우
- [ ] Alfamart/Indomaret 결제 코드 발급
- [ ] QRIS 지원
- [ ] 결제 웹훅 처리 (Cloud Function)
- [ ] 결제 이력 화면

### 4-B. Mozzy Wallet (인도네시아 OJK 준수)
- [ ] `MozzyWalletService` (최대 잔액 Rp 20,000,000)
- [ ] 충전 플로우 (Midtrans 경유)
- [ ] 출금 플로우 (KYC 검증 필수)
- [ ] 월 거래 한도 관리 (OJK: Rp 40,000,000)
- [ ] 지갑 내역 화면

### 4-C. 구독 시스템 (monetization-agent)
- [ ] Mozzy+ 구독: Rp 29,000/월, Rp 290,000/년
- [ ] Business+ 구독: Rp 99,000/월, Rp 990,000/년
- [ ] 구독 혜택 차별화 UI
- [ ] Google Play Billing / App Store IAP 연동
- [ ] 구독 상태 Riverpod Provider
- [ ] 구독 만료 알림 FCM

### 4-D. 광고 시스템 8종 (monetization-agent)
- [ ] Placeholder A — Local News 피드 인라인
- [ ] Placeholder B — 리스트 상단 배너
- [ ] Placeholder C — 상세 화면 추천
- [ ] Placeholder D — POM 풀스크린 Interstitial
- [ ] Placeholder E — 동네 히어로 배너
- [ ] Placeholder F — 지도 오버레이 스폰서
- [ ] Placeholder G — Chat 맥락 추천
- [ ] Placeholder H — 지도 핀 프리미엄
- [ ] 광고주 셀프서비스 콘솔 (Business+ 전용)
- [ ] Kecamatan 단위 타겟팅 기능

### 4-E. Boost 시스템 (dart-agent)
- [ ] Boost 결제 플로우 (IDR)
- [ ] Boost 기간/범위 설정 (Kecamatan / Kabupaten / Provinsi)
- [ ] Boost 효과 분석 대시보드 (Business+)

### 4-F. Phase 4 테스트
- [ ] MidtransService 각 결제수단 Mock 테스트 (7개 수단 × 3 = 21개+)
- [ ] Wallet 한도 초과 테스트 5개+
- [ ] 구독 상태 전환 테스트 8개+
- [ ] 광고 Placeholder 렌더링 테스트 8개+

**Phase 4 완료 기준**: GoPay 실결제 성공 + 구독 결제 완료 + 광고 노출 확인

---

## 🔲 Phase 5 — 스마트 기능 (Week 19~22)

### 5-A. Smart Feed + Neighborhood Identity (ai-agent + dart-agent)
- [ ] `SmartFeedService` 구현 (signalScore 공식)
  - [ ] Recency 0.3 · Relevance 0.25 · Engagement 0.2 · Diversity 0.15 · Trust 0.1
- [ ] 인도네시아 시간대별 가중치 (WIB 기준 시간별 Feature 가중치)
- [ ] `UnifiedDiscoveryFeed` (11개 Feature 혼합 피드)
- [ ] `NeighborhoodIdentityScreen` (동네 프로필)
  - [ ] 인도네시아 통계 그리드 (Warga Aktif, Postingan Hari Ini)
  - [ ] 인기 태그 #kuliner #properti #lowongan
  - [ ] Feature별 Top 3 콘텐츠

### 5-B. 7대 Cross-Feature 전략 구현 (dart-agent)
- [ ] **전략 1**: CrossLinkSection 위젯 (모든 상세 화면)
- [ ] **전략 2**: Pom as Universal Promotion (linkedContentType/Id)
- [ ] **전략 3**: Local Stores 5탭 통합
- [ ] **전략 4**: Together × All Features 연결
- [ ] **전략 5**: Smart Feed 개인화
- [ ] **전략 6**: Neighborhood Identity 통계
- [ ] **전략 7**: NudgeEngine 행동 기반 알림

### 5-C. ML Kit 번역 (i18n-agent + ai-agent)
- [ ] 온디바이스 번역 모델 다운로드 (id·en·ko)
- [ ] 게시글 번역 버튼 UI
- [ ] 번역 결과 캐시 (`translationState` 필드)
- [ ] 언어 자동 감지

### 5-D. 성능 최적화 (perf-agent)
- [ ] 저사양 기기 감지 (`DeviceCapabilityService`)
- [ ] 이미지 품질 자동 조정 (기기 RAM 기준)
- [ ] 비디오 자동재생 데이터 절약 옵션
- [ ] 앱 시작 시간 최적화 (목표: < 2초)
- [ ] 메모리 누수 프로파일링

### 5-E. 보안 강화 (security-agent)
- [ ] PDPB 컴플라이언스 최종 검토
- [ ] Firestore Rules 전체 테스트
- [ ] 사용자 데이터 삭제 기능 구현 (Right to Erasure)
- [ ] SSL Pinning
- [ ] 루팅 기기 감지 (금융 기능 보호)

---

## 🔲 Phase 6 — 베타 런칭 (Week 23~26)

### 6-A. 인도네시아 베타 테스트
- [ ] Firebase App Distribution으로 베타 그룹 초대
  - [ ] 반둥(Bandung) 50명 베타 테스터
  - [ ] 자카르타(Jakarta) 30명 베타 테스터
- [ ] 베타 피드백 수집 채널 (Google Form — Bahasa Indonesia)
- [ ] 크래시 리포트 모니터링 (목표: 크래시 프리 98%+)
- [ ] 성능 모니터링 (Firebase Performance)

### 6-B. PlayStore 출시 준비 (deploy-agent)
- [ ] 앱 아이콘 (Adaptive Icon — Android)
- [ ] 스플래시 스크린 (인도네시아 국기 컬러)
- [ ] PlayStore 등록:
  - [ ] 앱 이름: "Mozzy - Komunitas Lokal"
  - [ ] 설명 (Bahasa Indonesia — 4,000자)
  - [ ] 짧은 설명 (80자)
  - [ ] 스크린샷 8장 (자카르타/반둥 배경)
  - [ ] 홍보 동영상 (30초, Bahasa Indonesia)
  - [ ] 개인정보처리방침 URL (PDPB 준수)
  - [ ] 컨텐츠 등급 완료
- [ ] 내부 테스트 → 비공개 테스트 → 공개 테스트 단계별 출시

### 6-C. AppStore 출시 준비 (deploy-agent)
- [ ] Apple Developer 계정 확인
- [ ] App Store Connect 등록 (인도네시아 지역 설정)
- [ ] TestFlight 베타 배포
- [ ] App Store 심사 제출

### 6-D. 런칭 KPI 모니터링 (market-agent)
- [ ] Firebase Analytics 대시보드 설정
- [ ] 도시별 DAU 추적
- [ ] Feature별 진입률 추적
- [ ] 결제 성공률 모니터링 (Midtrans 대시보드)
- [ ] CS 채널 개설 (WhatsApp Business — 인도네시아 주력)

**Phase 6 완료 기준**: PlayStore 공개 출시 + 반둥 DAU 500+ + 크래시 < 2%

---

## 🔲 Phase 7 — Growth & Global Relay 준비 (Week 27+)

### 7-A. 성장 최적화 (market-agent)
- [ ] D7/D30 리텐션 분석 → 개선 조치
- [ ] A/B 테스트 프레임워크 (Firebase Remote Config)
- [ ] 추천 프로그램 (Refer & Earn — IDR 보상)
- [ ] 인도네시아 인플루언서 파트너십 (KOL 마케팅)

### 7-B. 수라바야 확장
- [ ] 수라바야(Surabaya) 행정구역 데이터 검증
- [ ] 수라바야 로컬 가게 DB 구축
- [ ] 수라바야 베타 그룹 (50명)

### 7-C. Global Relay 준비 (Phase 2 국가 대비)
- [ ] `reachMode: progressive` 구현 (동네 → 시 → 국가 → 글로벌)
- [ ] 한국(KR), 베트남(VN), 필리핀(PH) CountryRegistry JSON 준비
- [ ] Global Relay Translation (Gemini API 기반)
- [ ] 다국통화 CurrencyService 환율 실시간 연동

### 7-D. 최종 기술 지표 달성 확인
- [ ] 테스트 커버리지 30%+ 달성
- [ ] 앱 크래시 프리 99.5%+
- [ ] 빌드 시간 2분 이하
- [ ] Firestore 인덱스 132개 이하 유지
- [ ] App Store Rating 4.0+ (인도네시아 리뷰)

---

## 📊 전체 진행률 대시보드

| Phase | 기간 | 총 항목 | 완료 | 진행률 |
|-------|------|---------|------|-------|
| Phase 0 | Week 1-2 | 35개 | 0 | 0% |
| Phase 1 | Week 3-6 | 40개 | 0 | 0% |
| Phase 2 | Week 7-10 | 45개 | 0 | 0% |
| Phase 3 | Week 11-14 | 55개 | 0 | 0% |
| Phase 4 | Week 15-18 | 50개 | 0 | 0% |
| Phase 5 | Week 19-22 | 35개 | 0 | 0% |
| Phase 6 | Week 23-26 | 30개 | 0 | 0% |
| Phase 7 | Week 27+ | 20개 | 0 | 0% |
| **전체** | **27주+** | **310개** | **0** | **0%** |

---

*마지막 업데이트: 2026-04-26 | 다음 리뷰: Phase 0 완료 후*
