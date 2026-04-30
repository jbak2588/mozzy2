

| 🇮🇩  MOZZY INDONESIA 단위별 개발 진행표 · 체크리스트 · UI/UX 디자인 가이드 *Development Sprint Board  ·  Unit Checklist  ·  Design Standards* |
| :---: |

| 📋  8 Phase 310개 체크 항목 27주+ 개발 일정 |  | 🤖  13 Agents   멀티 에이전트 병렬·체인 자동화 개발 |  | 🎨  UI/UX 인도네시아 디자인 표준 컬러·타이포·컴포넌트 |
| :---: | :---- | :---: | :---- | :---: |

Ver 1.0  |  2026년 4월 26일  |  Confidential

# **PART 1  |  전체 개발 로드맵 오버뷰**

8개 Phase, 총 27주+ 일정으로 인도네시아 MVP부터 글로벌 릴레이 준비까지 진행합니다. 각 Phase는 전담 에이전트가 순차·병렬 작업으로 수행합니다.

## **▌ Phase별 일정 & 목표 요약**

| Phase | 기간 | 주제 | 핵심 산출물 | 담당 에이전트 | 진행 상태 |
| :---: | :---: | ----- | ----- | ----- | ----- |
| 0 | Week 1\~2 | 프로젝트 셋업 | Firebase·CI/CD·폴더구조·Contract | architect·deploy | ○ 시작 전 |
| 1 | Week 3\~6 | App Shell \+ Geo | 인증·위치·i18n·Track1+2·Trust기반 | geo·dart·i18n | ○ 시작 전 |
| 2 | Week 7\~10 | Core 3 Feature | 뉴스·마켓·채팅 MVP 완성 | dart·firestore·test | ○ 시작 전 |
| 3 | Week 11\~14 | 8개 Feature 완성 | 11개 Feature CRUD 완성 | dart·ai·security | ○ 시작 전 |
| 4 | Week 15\~18 | 수익화 시스템 | GoPay·OVO·구독·광고8종 | monetization·deploy | ○ 시작 전 |
| 5 | Week 19\~22 | Smart Feed·AI | Smart Feed·7대Cross·NudgeEngine | ai·dart·perf | ○ 시작 전 |
| 6 | Week 23\~26 | 베타 런칭 | PlayStore·AppStore 공개 | deploy·market | ○ 시작 전 |
| 7 | Week 27+ | 성장·글로벌 준비 | DAU성장·29개국 릴레이 준비 | market·ai·deploy | ○ 시작 전 |

**Current Status:** Phase 1 — Completed and Locked (see docs/phase_reports/phase1_completion_report.md)

**Phase 2 Next Focus:** Local News (Kickoff prepared — route correction applied). First units to start:

- P2-U1: PostModel (☑)
- P2-U2: PostRepository (Firestore CRUD) (☑)
- P2-U3: LocalNewsListScreen (☑)
- P2-U4: LocalNewsDetailScreen (☑)
- P2-U5: CreatePostScreen (☑)
- P2-U6: Local News tests (△)
- P2-U7: Local News E2E integration test (☑)
- P2-U8: Human manual Android smoke test (□)
- P2-U9: Local News basic comments (☑)
- P2-U10-A: Reply support foundation (☑)
- P2-U10-B: Secret comments visibility and rules (☑)

## **▌ 에이전트 책임 매트릭스**

| 에이전트 | 주요 역할 | 관여 Phase | Gate Keeper 역할 |
| :---: | ----- | ----- | ----- |
| architect | 5-Layer 경계·SharedContract 수호 | ALL | Feature 구현 전 승인 필수 |
| dart | Flutter/Dart·Riverpod3 코드 생성 | 0\~7 | 코드 생성 주체 |
| firestore | 스키마·132인덱스·SecurityRules | 0\~5 | 인덱스 추가 최종 승인 |
| test | 1033+테스트·30%커버리지 | 1\~7 | 커버리지 30% 미달 시 블로킹 |
| i18n | Bahasa Indonesia·25개언어 | 0\~7 | 번역 누락 시 배포 블로킹 |
| review | PR리뷰·위반 탐지 | 1\~7 | PR merge 최종 승인 |
| security | PDPB·Firestore Rules·보안감사 | 0\~6 | 런칭 전 필수 감사 |
| perf | 저사양기기 최적화·APK크기 | 2\~6 | APK 30MB초과 시 블로킹 |
| geo | 인도네시아 Track1+2·CountryRegistry | 0\~2 | 위치 기능 설계 승인 |
| ai | Gemini3.0·MLKit·NudgeEngine | 2\~7 | AI 비용 관리 |
| monetization | Midtrans·OJK·광고8종 | 4\~7 | 결제 테스트 승인 |
| deploy | CI/CD·PlayStore·AppStore | 0\~7 | 배포 파이프라인 관리 |
| market | GTM·KPI·경쟁사 | 5\~7 | 런칭 전략 승인 |

# **PART 2  |  단위별 개발 진행표 (Unit Development Board)**

각 Phase를 개발 단위(Unit)로 세분화하여 작업 의존성·담당 에이전트·완료 기준을 명시합니다.

| Phase 0  프로젝트 셋업 & 인프라 📅 Week 1 \~ 2 (14일)  |  담당: architect → dart → test → review → deploy |
| :---- |

| \# | 개발 단위 (Unit) | 세부 작업 | 담당 에이전트 | 완료 기준 | 상태 |
| :---: | ----- | ----- | ----- | ----- | :---: |
| P0-U1 | **개발 환경 구성** | Flutter 3.27+·Dart 3.6+·Android Studio·Firebase CLI·FlutterFire CLI 설치 및 버전 확인 | deploy·dart | 모든 CLI 명령 정상 실행 | ☑ |
| P0-U2 | **Firebase 프로젝트 생성** | mozzy-indonesia-prod·dev 생성 / asia-southeast2 리전 / Firestore·Auth·Storage·FCM·Analytics 활성화 | deploy | firebase deploy 성공 | ☑ |
| P0-U3 | **Flutter 프로젝트 초기화** | flutter create / pubspec.yaml 패키지 구성 / Riverpod3·Freezed·easy\_localization 설치 | dart | flutter pub get & run 성공 | ☑ |
| P0-U4 | **5-Layer 폴더 구조 생성** | lib/mozzy\_ii/ 전체 폴더 트리 생성 / 각 레이어 경계 확립 | architect | tree 구조 architect 승인 | ☑ |
| P0-U5 | **Shared Contract 정의** | MozzyPostContract·GeoScope·ReachMode 추상 클래스 / Dart 추상 클래스 파일 | architect·dart | Dart 컴파일 오류 없음 | ☑ |
| P0-U6 | **CountryRegistry ID.json** | assets/config/countries/ID.json 완성 / 34개 Provinsi·타임존·결제수단·통화 포함 | geo | JSON 파싱 테스트 통과 | ☑ |
| P0-U7 | **i18n 기반 파일** | assets/translations/id.json 마스터 / en.json·ko.json 생성 / easy\_localization 초기화 | i18n | 앱 실행 시 인도네시아어 표시 | ☑ |
| P0-U8 | **Firestore 초안** | firestore.rules·firestore.indexes.json 초안 / Security Rules 기본 구조 | firestore·security | firebase emulators:start 정상 | □ |
| P0-U9 | **CI/CD 파이프라인** | GitHub Actions 워크플로우 / Firebase App Distribution 연결 / Secrets 설정 | deploy | 첫 CI 빌드 Green | ☑ |
| P0-U10 | **RateLimiter 유틸리티** | lib/core/utils/rate\_limiter.dart / AI API 비용 관리 / 단위 테스트 | dart·test | RateLimiter 테스트 5개 통과 | □ |
| P0-U11 | **CurrencyService** | formatIDR()·formatIDRCompact() / 인도네시아식 포맷 (점 천단위) / 테스트 | dart·test | formatIDR(1500000)='Rp 1.500.000' | ☑ |

<!-- [2026-04-27 진행상황] Phase 0의 환경 구성, Firebase, i18n 구조 및 초기 설정 거의 완료. -->

| Phase 1  App Shell \+ Geo Layer 📅 Week 3 \~ 6 (28일)  |  담당: architect → dart → test → review → deploy |
| :---- |

| \# | 개발 단위 (Unit) | 세부 작업 | 담당 에이전트 | 완료 기준 | 상태 |
| :---: | ----- | ----- | ----- | ----- | :---: |
| P1-U1 | **인도네시아 Geo 모델** | LocationParts·IndonesiaGeoAddress·GlobalGeoAddress·GeoScope·IndonesiaTimezone 데이터 클래스 (Freezed) | geo·dart | Freezed 코드 생성 완료 | ☑ |
| P1-U2 | **LocationService** | GPS 획득·역지오코딩·Track1 주소 파싱·타임존 감지(WIB/WITA/WIT) | geo·dart | Coblong,Bandung 역지오코딩 성공 | ☑ |
| P1-U3 | **LocationProvider** | Riverpod3 AsyncNotifier / 수동 위치 변경 / 오프라인 캐시 | geo·dart | Provider 상태 전환 테스트 | ☑ |
| P1-U4 | **주소 포맷터** | formatAddress(IndonesiaGeoAddress,AddressDetail) / minimal·standard·full 3단계 | i18n·dart | 3개 레벨 포맷 테스트 | □ |
| P1-U5 | **전화번호 인증** | \+62 SMS OTP / Firebase Phone Auth / 0→62 자동 변환 UI | dart·security | OTP 발송·검증 성공 | □ |
| P1-U6 | **구글 소셜 로그인** | google\_sign\_in 연동 / 익명 로그인 (둘러보기) / auth\_gate.dart | dart | Google 로그인 성공 | ☑ |
| P1-U7 | **UserModel** | Freezed·NIK 미수집·phoneHash·trustScore·locationParts / PDPB 준수 | dart·security | PDPB 필드 검증 통과 | ☑ |
| P1-U8 | **App Theme** | 인도네시아 빨강 \#CC0001 / Nunito Sans / Material3 / 다크 모드 | dart | ThemeData 렌더 확인 | ☑ |
| P1-U9 | **GoRouter 설정** | 11개 Feature 라우트 / 딥링크 mozzy://item/{id} / auth 가드 | dart | 모든 라우트 네비게이션 확인 | ☑ |
| P1-U10 | **BottomNavigationBar** | 5개 주요 탭 / FAB 빠른 게시 / 배지 알림 카운트 | dart | 탭 전환 애니메이션 확인 | ☑ |
| P1-U11 | **SharedMapBrowser 기반** | Google Maps 기본 / 마커 / 카테고리 필터칩 / DraggableScrollableSheet | dart·geo | 지도 렌더링 확인 | ☑ |
| P1-U12 | **TrustScoreService** | 기본 Trust Score 로직 / Trust Level 4단계 / TrustScoreBadge 위젯 | dart | 신규가입 0.3 → OTP완료 0.5 | ☑ |
| P1-U13 | **신고 시스템 기반** | Report 모달 / Firestore reports 컬렉션 / FCM 관리자 알림 | dart·firestore | 신고 저장 확인 | □ |
| P1-U14 | **Hive 오프라인 캐시 초기화** | HiveBoxes 정의 / 오프라인 배너 UI (인도네시아어) / NetworkStatusService | dart·perf | 오프라인 모드 전환 확인 | □ |
| P1-U15 | **Phase 1 테스트** | LocationService 10개+ / 포맷터 8개+ / Auth flow 5개+ / Trust Score 5개+ | test | 28개+ 테스트 통과 | ☑ |

<!-- [2026-04-27 진행상황] Phase 1의 GeoLayer 기초, GoRouter, Theme, Google Login 및 Formatters 구현 완료. 속도를 위해 Auth는 Google 로그인으로 단일화. -->


| Phase 2  Core 3 Features MVP 📅 Week 7 \~ 10 (28일)  |  담당: architect → dart → test → review → deploy |
| :---- |

| \# | 개발 단위 (Unit) | 세부 작업 | 담당 에이전트 | 완료 기준 | 상태 |
| :---: | ----- | ----- | ----- | ----- | :---: |
| P2-U1 | **PostModel** | Freezed·MozzyPostContract 구현·Track1 주소·카테고리(Umum·Info·Event·Darurat·Kuliner·Tips) | dart | Contract 필드 전체 존재 | ☑ |
| P2-U2 | **PostRepository** | Firestore CRUD / fetchByKecamatan / fetchByCategory / 커서 페이지네이션 | dart·firestore | startAfterDocument 동작 | ☑ |
| P2-U3 | **PostsProvider** | Riverpod3 AsyncNotifier / 실시간 Stream / 필터 상태 | dart | 스트림 업데이트 확인 | ☑ |
| P2-U4 | **LocalNewsListScreen** | 카테고리 탭바 / 무한 스크롤 / signalScore 정렬 / Shimmer 로딩 | dart | 6개 카테고리 탭 동작 | ☑ |
| P2-U5 | **LocalNewsDetailScreen** | 본문·이미지·댓글·CrossLinkSection 기초 | dart | 상세 화면 렌더링 | ☑ |
| P2-U6 | **CreatePostScreen** | 이미지 5장 업로드·WebP 압축 / 카테고리 선택 / 위치 자동 삽입 | dart·perf | 이미지 업로드 1MB 이하 | ☑ |
| P2-U7 | **Local News 인덱스** | posts 컬렉션 인덱스 12개 정의 / Security Rules 추가 | firestore | 12개 인덱스 배포 | ☑ |
| P2-B1 | **Marketplace Foundation** | ProductModel + Repository + InMemory + Providers | dart | Tests passed | ☑ |
| P2-U8 | **ProductModel** | Freezed·isAiVerified·IDR 가격·거래방식(COD/Pengiriman)·MozzyPostContract | dart | AIVerification 직렬화 | □ |
| P2-U9 | **MarketplaceRepository** | GeoHash 반경 쿼리 / fetchNearby(kecamatan) / 커서 페이지 | dart·firestore | 5km 반경 쿼리 동작 | □ |
| P2-B2 | **MarketplaceListScreen** | 그리드/리스트 전환 / 필터바 (카테고리·가격·거래방식) / 지도 연동 | dart | 그리드 전환 확인 | ☑ |
| P2-B3 | **ProductDetailScreen** | AI 검수 배지 / 가격 IDR 포맷 / '찜하기' / CrossLinkSection / Chat 진입 | dart | 상세 화면 렌더링 | ☑ |
| P2-B4 | **CreateProductScreen** | 이미지 5장·WebP / IDR 입력 / 카테고리 / COD·Pengiriman 선택 | dart | 물품 등록 Firestore 저장 | ☑ |
| P2-B5 | **Marketplace automated integration test** | Product List -> Detail -> Create E2E flow | test | 자동화 테스트 패스 | ☑ |
| P2-B6 | **Marketplace UI/Data Cleanup** | Image placeholder UX / IDR input parsing / Key standardization | dart | 통합 테스트 통과 | ☑ |
| P2-B7 | **Marketplace real image upload foundation** | Firebase Storage / Image Picker / WebP compression | dart | 이미지 업로드 성공 | □ |
| P2-U13 | **MarketplaceAiService** | Gemini3.0 이미지 분석 / 인도네시아어 프롬프트 / RateLimiter 10/분 | ai | AI 검수 결과 JSON 파싱 | □ |
| P2-U14 | **AI 검수 UI 플로우** | AiVerificationSheet / 로딩 → 결과 리포트 → 'Terverifikasi AI' 배지 | dart·ai | AI 검수 플로우 완료 | □ |
| P2-U15 | **Marketplace 인덱스** | used\_items 인덱스 18개 / GeoHash 인덱스 / Security Rules | firestore | 18개 인덱스 배포 | □ |
| P2-U16 | **ChatRoomModel·MessageModel** | Freezed / participants / unreadCount / lastMessage | dart | 직렬화 테스트 | □ |
| P2-U17 | **ChatRepository** | Firestore 실시간 / 메시지 CRUD / 읽음 처리 | dart·firestore | 실시간 수신 확인 | □ |
| P2-U18 | **ChatListScreen·ChatDetailScreen** | 채팅방 목록 / 실시간 메시지 / 이미지 전송 / 읽음 확인 | dart | 양방향 채팅 확인 | □ |
| P2-U19 | **FCM Chat 알림** | onNewMessage Cloud Function / 인도네시아어 알림 텍스트 / 딥링크 | deploy·dart | 미읽 알림 수신 확인 | □ |
| P2-U20 | **Hive 캐시 구현** | PostLocalDataSource(24h) / ProductLocalDataSource(1h) / 오프라인 fallback | dart·perf | 오프라인 콘텐츠 표시 | □ |
| P2-U21 | **Phase 2 테스트** | Post 15개+ / ProductModel Contract 10개+ / AI 8개+ / IDR 포맷 8개+ | test | 41개+ 테스트 통과 | □ |

| Phase 3  나머지 8개 Feature 완성 📅 Week 11 \~ 14 (28일)  |  담당: architect → dart → test → review → deploy |
| :---- |

| \# | 개발 단위 (Unit) | 세부 작업 | 담당 에이전트 | 완료 기준 | 상태 |
| :---: | ----- | ----- | ----- | ----- | :---: |
| P3-U1 | **Jobs — 모델·레포** | JobPostModel(Freezed·IDR급여) / JobRepository / fetchByKabupaten | dart·firestore | Jobs 인덱스 12개 | □ |
| P3-U2 | **Jobs — 화면** | JobsListScreen / JobDetailScreen / CreateJobScreen (인도네시아 업종) | dart | 구인 등록 Firestore 저장 | □ |
| P3-U3 | **Jobs AI 직무설명** | Gemini로 인도네시아어 직무설명 자동 생성 / 편집 가능 | ai | 한국어 → 인도네시아어 생성 | □ |
| P3-U4 | **Auction — 모델·레포** | AuctionModel / 실시간 입찰 Firestore Transaction / AI 감정 | dart·ai | 동시 입찰 충돌 없음 | □ |
| P3-U5 | **Auction — 화면·알림** | AuctionDetailScreen / 입찰 애니메이션 / 낙찰 FCM 알림 | dart | 낙찰 알림 수신 | □ |
| P3-U6 | **Clubs — 모델·레포** | GroupModel·GroupProposalModel / 자동 개설 Cloud Function | dart·firestore | 그룹 자동 개설 확인 | □ |
| P3-U7 | **Clubs — 화면** | ClubListScreen / ClubDetailScreen / 관심사 카테고리 (인도네시아) | dart | 카테고리 탐색 동작 | □ |
| P3-U8 | **Lost & Found — 모델·레포** | LostFoundModel(lost/found) / kecamatan 자동 알림 | dart·firestore | 분실 등록 저장 | □ |
| P3-U9 | **Lost & Found AI 매칭** | Gemini 이미지 유사도 / 위치·시간 교차 검증 / 매칭 알림 | ai | 매칭 스코어 0.0\~1.0 | □ |
| P3-U10 | **POM — 모델·레포** | PomModel(image/video/album) / linkedContentType·Id | dart·firestore | POM 인덱스 10개 | □ |
| P3-U11 | **POM — 화면** | 풀스크린 뷰어 / 숏폼 비디오 / 썸네일 / 크리에이터 수익 UI | dart | 비디오 재생 확인 | □ |
| P3-U12 | **Real Estate — 모델·레포** | RealEstateModel(Kos·Kontrak·Sewa·Jual) / 부동산 인덱스 10개 | dart·firestore | 매물 등록 저장 | □ |
| P3-U13 | **Real Estate — 화면** | PropertyListScreen / MapSearchScreen / PropertyDetailScreen | dart | 지도 기반 탐색 | □ |
| P3-U14 | **Local Stores — 모델·레포** | ShopModel / 5탭 구조 / Business+ 여부 | dart·firestore | 가게 인덱스 12개 | □ |
| P3-U15 | **Local Stores — 화면** | ShopDetailScreen 5탭 (Info·Produk·Lowongan·Berita·Ulasan) / BusinessCenter | dart | 5탭 전환 동작 | □ |
| P3-U16 | **Together — 모델·레포** | TogetherPostModel / 3테마(Neon·Paper·Dark) / 참여 인원 | dart·firestore | Together 인덱스 8개 | □ |
| P3-U17 | **Together — 화면·QR** | TogetherDetailScreen / 디지털 전단지 UI / QR 티켓 발급 및 스캐너 | dart | QR 스캔 인증 성공 | □ |
| P3-U18 | **CrossLinkSection 위젯** | 모든 상세화면 하단 '이 동네에서 더 보기' / 6타입 콘텐츠 | dart | 6타입 크로스링크 동작 | □ |
| P3-U19 | **POM 홍보 연동** | 모든 Feature 상세화면 '→ Pamer에서 홍보' 버튼 / linkedContentId | dart | 홍보 생성 저장 | □ |
| P3-U20 | **Phase 3 테스트** | 8 Feature × 5개 Contract 테스트 \+ Cross-Feature 10개+ | test | 50개+ 테스트 통과 | □ |

| Phase 4  수익화 시스템 📅 Week 15 \~ 18 (28일)  |  담당: architect → dart → test → review → deploy |
| :---- |

| \# | 개발 단위 (Unit) | 세부 작업 | 담당 에이전트 | 완료 기준 | 상태 |
| :---: | ----- | ----- | ----- | ----- | :---: |
| P4-U1 | **MidtransService** | GoPay·OVO·DANA·VA·Alfamart·QRIS 결제 / 개발·운영 환경 분리 / dart-define | monetization | 각 수단 Mock 테스트 통과 | □ |
| P4-U2 | **GoPay 딥링크** | 고젝 앱 딥링크 연동 / callback\_url mozzy://payment/callback | monetization | 고젝 앱 연결 확인 | □ |
| P4-U3 | **VA 결제** | BCA·Mandiri·BNI·BRI 가상계좌 생성 / 만료시간 24시간 | monetization | VA 번호 생성 확인 | □ |
| P4-U4 | **Alfamart 코드** | 편의점 결제 코드 발급 / 유효시간 3일 / UI 안내 | monetization | 결제 코드 발급 확인 | □ |
| P4-U5 | **결제 웹훅** | Cloud Function midtrans\_webhook / 결제완료→Firestore 업데이트 / 재시도 로직 | deploy·monetization | 웹훅 수신 및 처리 | □ |
| P4-U6 | **PaymentScreen** | 결제 수단 선택 UI (GoPay=초록·OVO=보라·DANA=파랑) / IDR 금액 표시 | dart | 7개 수단 UI 렌더링 | □ |
| P4-U7 | **MozzyWalletService** | 잔액 최대 Rp 20M (OJK) / 충전·출금 플로우 / KYC 검증 연동 | monetization·security | OJK 한도 테스트 | □ |
| P4-U8 | **구독 — Mozzy+** | Rp 29,000/월 / Rp 290,000/년 / Google Play Billing / 혜택 UI | monetization | 구독 결제 완료 | □ |
| P4-U9 | **구독 — Business+** | Rp 99,000/월 / 가게 구독 / 대시보드 접근 권한 | monetization | 가게 구독 권한 확인 | □ |
| P4-U10 | **구독 상태 Provider** | MozzyPlusProvider·BusinessPlusProvider / 만료 알림 FCM | dart | 만료 알림 수신 | □ |
| P4-U11 | **광고 Placeholder A\~D** | 뉴스 인라인·리스트 배너·상세 추천·POM 전환 광고 | dart | 4종 렌더링 확인 | □ |
| P4-U12 | **광고 Placeholder E\~H** | 동네히어로·지도오버레이·Chat추천·지도핀 프리미엄 | dart | 4종 렌더링 확인 | □ |
| P4-U13 | **광고주 셀프서비스** | Business+ 광고 생성 콘솔 / Kecamatan 타겟팅 / 예산 설정 | dart | 광고 저장 확인 | □ |
| P4-U14 | **Boost 시스템** | Boost 결제 플로우 / 범위 (Kecamatan·Kabupaten·Provinsi) / 효과 분석 | monetization·dart | Boost 노출 확인 | □ |
| P4-U15 | **Phase 4 테스트** | 결제 수단 7종 × 3 테스트 / OJK 한도 / 구독 전환 / 광고 8종 | test | 30개+ 테스트 통과 | □ |

| Phase 5  Smart Feed & AI 연결 전략 📅 Week 19 \~ 22 (28일)  |  담당: architect → dart → test → review → deploy |
| :---- |

| \# | 개발 단위 (Unit) | 세부 작업 | 담당 에이전트 | 완료 기준 | 상태 |
| :---: | ----- | ----- | ----- | ----- | :---: |
| P5-U1 | **SmartFeedService** | signalScore 공식 구현 / recency·relevance·engagement·diversity·trust 가중치 | ai | signalScore 범위 0.0\~1.0 | □ |
| P5-U2 | **인도네시아 시간 가중치** | WIB 기준 시간대별 Feature 가중치 / 주말 별도 처리 | ai·dart | 시간대별 가중치 적용 | □ |
| P5-U3 | **UnifiedDiscoveryFeed** | 11개 Feature 혼합 피드 / signalScore 정렬 / 무한 스크롤 | dart | 혼합 피드 렌더링 | □ |
| P5-U4 | **NeighborhoodIdentityScreen** | 동네 통계 그리드 / 인기 태그 / Feature별 Top3 / 인도네시아어 | dart | Coblong 동네 프로필 | □ |
| P5-U5 | **NudgeEngine** | 행동 기반 FCM 넛지 / 인도네시아어 메시지 / RateLimiter | ai·dart | 넛지 알림 발송 확인 | □ |
| P5-U6 | **ML Kit 번역** | 온디바이스 id·en·ko 모델 / 자동 언어 감지 / translationState 캐시 | ai | id→en 번역 성공 | □ |
| P5-U7 | **번역 UI** | '번역 보기' 버튼 / 번역 완료 후 자동 업데이트 / 캐시 표시 | dart | 번역 버튼 동작 | □ |
| P5-U8 | **Together × All Features** | Marketplace→'바자르' 제안 / Jobs→'Job Fair' / 자동 Together 추천 | dart | Cross-Feature 추천 동작 | □ |
| P5-U9 | **Store-Centric 완성** | 가게 5탭 완성 / Marketplace·Jobs·News 실시간 연동 | dart | 5탭 데이터 연동 | □ |
| P5-U10 | **DeviceCapabilityService** | RAM 2GB 감지 / 이미지 품질 자동 조정 / 비디오 자동재생 제어 | perf | 저사양 모드 전환 | □ |
| P5-U11 | **이미지 최적화** | WebP 압축·memCacheWidth 300 / 썸네일 300px / itemExtent 고정 | perf | APK 30MB 이하 확인 | □ |
| P5-U12 | **앱 시작 시간 최적화** | Cold Start 2초 이하 / defer 로딩 / const 생성자 전수 확인 | perf | 2초 이하 달성 | □ |
| P5-U13 | **PDPB 최종 검토** | NIK 평문 grep / KTP 보관 정책 / 동의 관리 / 삭제권 구현 | security | 0개 PDPB 위반 | □ |
| P5-U14 | **Firestore Rules 강화** | 전 컬렉션 Rules 최종 / 정밀 좌표 본인만 접근 / KYC 데이터 보호 | security·firestore | Rules 테스트 전 통과 | □ |
| P5-U15 | **Phase 5 테스트** | SmartFeed 10개+ / NudgeEngine 5개+ / 번역 5개+ / 성능 프로파일 | test | 20개+ 테스트 통과 | □ |

| Phase 6  베타 런칭 📅 Week 23 \~ 26 (28일)  |  담당: architect → dart → test → review → deploy |
| :---- |

| \# | 개발 단위 (Unit) | 세부 작업 | 담당 에이전트 | 완료 기준 | 상태 |
| :---: | ----- | ----- | ----- | ----- | :---: |
| P6-U1 | **베타 테스터 모집** | 반둥 50명 / 자카르타 30명 / Firebase App Distribution 그룹 | market | 80명 초대 완료 | □ |
| P6-U2 | **크래시 모니터링** | Crashlytics 대시보드 설정 / 크래시 알림 Slack 연동 | deploy | 크래시율 \< 2% | □ |
| P6-U3 | **Firebase Performance** | 앱 시작·네트워크·화면렌더 추적 / 성능 이상 알림 | deploy | 모니터링 대시보드 확인 | □ |
| P6-U4 | **베타 피드백 수집** | Google Form (Bahasa Indonesia) / NPS 점수 / 기능별 만족도 | market | 피드백 80명+ 수집 | □ |
| P6-U5 | **PlayStore 메타데이터** | 앱이름·설명·짧은설명 (Bahasa Indonesia) / 스크린샷 8장 (반둥·자카르타) | market | PlayStore 심사 통과 | □ |
| P6-U6 | **PlayStore 법적 서류** | 개인정보처리방침 URL (PDPB) / 컨텐츠 등급 / 앱 권한 설명 | security·market | Play정책 100% 준수 | □ |
| P6-U7 | **AppStore 등록** | App Store Connect / TestFlight 배포 / 인도네시아 지역 설정 | deploy | TestFlight 빌드 업로드 | □ |
| P6-U8 | **PlayStore 단계적 출시** | 내부 → 비공개 → 공개 테스트 단계 진행 | deploy | 공개 출시 완료 | □ |
| P6-U9 | **WhatsApp CS 채널** | Business 계정 개설 / 자동 응답 (인도네시아어) / 티켓 트래킹 | market | CS 채널 운영 시작 | □ |
| P6-U10 | **Firebase Analytics 대시보드** | 도시별 DAU / Feature별 진입률 / 결제 전환율 / 커스텀 이벤트 | deploy·market | 주간 리포트 자동화 | □ |
| P6-U11 | **최종 보안 감사** | security-agent 전체 코드 스캔 / API 키 하드코딩 grep / PDPB 최종 | security | 0개 Critical 이슈 | □ |
| P6-U12 | **앱 아이콘·스플래시** | Adaptive Icon (Android) / 인도네시아 국기 컬러 스플래시 | dart | 모든 해상도 확인 | □ |

| Phase 7  성장 & 글로벌 확장 준비 📅 Week 27+ (지속)  |  담당: architect → dart → test → review → deploy |
| :---- |

| \# | 개발 단위 (Unit) | 세부 작업 | 담당 에이전트 | 완료 기준 | 상태 |
| :---: | ----- | ----- | ----- | ----- | :---: |
| P7-U1 | **리텐션 분석** | D7·D30 리텐션 코호트 분석 / Feature별 리텐션 / 개선 조치 | market·ai | D7 25%+ 달성 | □ |
| P7-U2 | **A/B 테스트 프레임워크** | Firebase Remote Config / UI 변형 테스트 / Smart Feed 파라미터 | ai·dart | A/B 실험 2개 이상 | □ |
| P7-U3 | **추천 프로그램** | Refer & Earn / IDR 보상 / 딥링크 추적 | dart·monetization | 추천 전환 추적 | □ |
| P7-U4 | **수라바야 확장** | 행정구역 데이터 검증 / 로컬 가게 DB / 베타 그룹 50명 | geo·market | 수라바야 DAU 2,000+ | □ |
| P7-U5 | **KOL 파트너십** | 인도네시아 인플루언서 계약 / 반둥·자카르타 10명 | market | KOL 콘텐츠 10개 게시 | □ |
| P7-U6 | **Global Relay 준비** | reachMode:progressive 구현 / 글로벌 릴레이 번역 플로우 | ai·dart | 글로벌 릴레이 테스트 | □ |
| P7-U7 | **다국가 CountryRegistry** | KR·VN·PH·TH·MY JSON 준비 / 통화·결제·주소 체계 | geo | 5개국 JSON 검증 | □ |
| P7-U8 | **MRR 목표 달성 리뷰** | Rp 150M/월 (6개월 목표) / Feature별 수익 분석 / 가격 조정 | market·monetization | MRR Rp 150M+ 달성 | □ |

# **PART 3  |  UI/UX 디자인 표준 가이드**

인도네시아 사용자를 위한 Mozzy 디자인 시스템입니다. 모든 UI 구현 시 이 가이드를 따릅니다.

## **▌ 3.1 핵심 디자인 원칙 (5대 원칙)**

| 🇮🇩 Indonesia First |  | 🤝 Trust by Design |  | ⚡ Performance First |  | 🌐 Hyperlocal Identity |  | 🔗 Connected Experience |
| :---: | :---- | :---: | :---- | :---: | :---- | :---: | :---- | :---: |

| Indonesia First 인도네시아어(Bahasa Indonesia) 기본 표시 IDR(Rp) 통화 포맷: 점(.) 천단위 구분 인도네시아 국기 빨강 \#CC0001 브랜드 컬러 Kecamatan/Kelurahan 단위 동네 정체성 WIB·WITA·WIT 타임존 자동 감지 Trust by Design 모든 콘텐츠에 Trust Score 시각화 AI 검수 배지 'Terverifikasi AI' 명시 Fake 콘텐츠 자동 스크리닝 표시 신뢰 레벨 배지: Anggota → Hero Lokal |  | Performance First APK 크기 30MB 이하 Cold Start 2초 이하 RAM 2GB 저사양 기기 최적화 이미지: WebP \+ max 1MB LTE 5Mbps 환경 대응 경량 모드 Connected Experience CrossLinkSection: 모든 상세화면 하단 SharedMapBrowser: 전 Feature 통합 지도 POM 홍보: 모든 Feature에서 진입 Smart Feed: 시간대별 개인화 |
| :---- | :---- | :---- |

## **▌ 3.2 컬러 시스템**

### **브랜드 컬러 팔레트**

Mozzy Indonesia의 컬러는 인도네시아 국기(빨강+흰색)에서 영감을 받아 신뢰감과 활력을 동시에 표현합니다.

|   |   |   |   |   |
| :---: | :---: | :---: | :---: | :---: |
| **Primary Red** \#CC0001 *브랜드 핵심* | **Accent Red** \#E63946 *CTA 버튼* | **Background** \#FFFFFF *기본 배경* | **Surface** \#F8F9FA *카드 배경* | **Text Primary** \#212529 *본문 텍스트* |

|   |   |   |   |   |
| :---: | :---: | :---: | :---: | :---: |
| **Text Secondary** \#6C757D *부제목·설명* | **Border** \#DEE2E6 *구분선* | **Success** \#107C41 *완료·긍정* | **Warning** \#B45309 *주의·경고* | **Info** \#1D4ED8 *정보·링크* |

### **Feature별 대표 컬러**

| Feature | 인도네시아명 | 아이콘 컬러 | 배경 컬러 | 용도 |
| :---: | ----- | ----- | ----- | ----- |
| Local News | Berita Lokal | \#CC0001 | \#FFF5F5 | 긴급·정보 알림 |
| Marketplace | Jual Beli | \#E63946 | \#FFE4E6 | 판매·구매 |
| Jobs | Lowongan Kerja | \#1D4ED8 | \#DBEAFE | 채용·취업 |
| Auction | Lelang | \#B45309 | \#FEF3C7 | 경매·입찰 |
| Clubs | Komunitas | \#6D28D9 | \#EDE9FE | 커뮤니티 |
| Lost & Found | Barang Hilang | \#0F4C5C | \#ECFEFF | 분실·습득 |
| POM | Pamer\! | \#BE185D | \#FDF2F8 | 창작·공유 |
| Real Estate | Properti | \#065F46 | \#D1FAE5 | 부동산 |
| Local Stores | Toko Sekitar | \#92400E | \#FEF3C7 | 로컬 비즈 |
| Together | Bareng Yuk\! | \#1E40AF | \#EFF6FF | 모임·이벤트 |
| Chat | Pesan | \#374151 | \#F3F4F6 | 메시지 |

## **▌ 3.3 타이포그래피 시스템**

### **폰트 패밀리**

| 주요 폰트: Nunito Sans Latin 문자(영어·인도네시아어) 기본 가독성 최적화, 둥근 형태로 친근감 Regular(400) · SemiBold(600) · Bold(700) 보조 폰트: Noto Sans 한국어·자바어(jv)·순다어(su) 지원 다국어 혼용 화면에서 자동 폴백 Google Fonts CDN 사용 |  | 시스템 폰트 폴백 Android: Roboto → Nunito Sans iOS: SF Pro → Nunito Sans Flutter fontFamily: 'NunitoSans' Flutter 폰트 설정 pubspec.yaml:   \- family: NunitoSans     fonts:       \- asset: assets/fonts/NunitoSans-Regular.ttf       \- asset: assets/fonts/NunitoSans-Bold.ttf |
| :---- | :---- | :---- |

### **타입 스케일 (Flutter TextStyle)**

| 레벨 | 용도 | Flutter 크기 | fontWeight | color | 예시 |
| :---: | ----- | ----- | ----- | ----- | ----- |
| Display | 앱 타이틀·히어로 | 28sp | Bold 700 | \#1A1A2E | Mozzy |
| Headline 1 | 섹션 헤더 | 22sp | Bold 700 | \#1A1A2E | Berita Lokal |
| Headline 2 | 카드 제목 | 18sp | SemiBold 600 | \#1A1A2E | iPhone 14 Pro 256GB |
| Body Large | 본문 주요 | 16sp | Regular 400 | \#212529 | Kondisi baik, bisa nego |
| Body Medium | 본문 기본 | 14sp | Regular 400 | \#212529 | Kecamatan Coblong, Bandung |
| Body Small | 부연 정보 | 12sp | Regular 400 | \#6C757D | 2 jam yang lalu |
| Label | 배지·태그 | 11sp | SemiBold 600 | varies | Terverifikasi AI |
| Caption | 가격·날짜 | 12sp | SemiBold 600 | \#CC0001 | Rp 1.500.000 |
| Button | 버튼 텍스트 | 16sp | Bold 700 | \#FFFFFF | Beli Sekarang |

## **▌ 3.4 간격 & 그리드 시스템**

| 기본 간격 단위 (8dp 그리드) 토큰 값 용도 spacing-xs 4dp 아이콘 내부 패딩 spacing-sm 8dp 요소 간 최소 간격 spacing-md 16dp 카드 내부 패딩 spacing-lg 24dp 섹션 간 간격 spacing-xl 32dp 페이지 섹션 spacing-2xl 48dp 화면 상단 여백  |  | 터치 영역 & 반응형 터치 영역 최소 기준 최소 터치: 48×48dp (인도네시아 저가폰) 권장 터치: 56×56dp (엄지 터치 최적화) 버튼 높이: 48dp (최소) \~ 56dp (권장) 리스트 아이템: 최소 56dp 높이 BottomNav 탭: 최소 48dp 터치 영역 화면 여백 기준 수평 마진: 16dp (기본) / 8dp (목록) 상단 여백: SafeArea \+ 8dp 하단 여백: SafeArea \+ BottomNav 카드 내부: 16dp 패딩 섹션 간격: 24dp  |
| ----- | :---- | :---- |

## **▌ 3.5 핵심 컴포넌트 라이브러리**

### **버튼 시스템**

| 종류 | 스타일 | 사용처 | Flutter 구현 | 상태 |
| :---: | ----- | ----- | ----- | ----- |
| Primary | bg=\#CC0001 text=white bold | 주요 CTA: 구매·등록·제출 | ElevatedButton | 기본·호버·비활성 |
| Secondary | border=\#CC0001 text=\#CC0001 | 보조 액션: 저장·취소 | OutlinedButton | 기본·호버·비활성 |
| Text | text=\#CC0001 no border | 링크형: '더 보기'·'건너뛰기' | TextButton | 기본·호버 |
| Danger | bg=\#B91C1C text=white | 삭제·신고 확인 | ElevatedButton | 비활성 포함 |
| Ghost | bg=transparent text=white | 이미지 위 오버레이 | TextButton | 투명 배경 |
| Icon+Text | icon left \+ label | Marketplace '채팅' 버튼 | ElevatedButton | 아이콘 16dp |

### **카드 컴포넌트**

| 카드 종류 | 크기 | 핵심 구성 | 특이사항 |
| :---: | ----- | ----- | ----- |
| ProductCard | 그리드: 160×220dp | 썸네일·제목·IDR가격·신뢰배지·위치 | WebP 썸네일 300px |
| NewsCard | 전체폭 × 90dp | 카테고리칩·제목·작성자·시간·좋아요 | Shimmer 로딩 |
| JobCard | 전체폭 × 80dp | 업종·직함·급여(IDR)·거리·마감일 | 마감임박 배지 |
| StoreCard | 전체폭 × 96dp | 가게사진·이름·카테고리·평점·거리 | Business+ 배지 |
| TogetherCard | 전체폭 × 120dp | 디자인테마·제목·날짜·참여현황 | Neon/Paper/Dark 테마 |
| PomCard | 그리드: 160×240dp | 미디어·크리에이터·좋아요 | 비디오 썸네일 |
| AuctionCard | 전체폭 × 100dp | 물품·현재가격·남은시간·입찰수 | 실시간 타이머 |
| MapMarker | 40×40dp | Feature 아이콘·색상 구분 | Feature별 컬러 |

### **인도네시아 전용 컴포넌트**

| PriceWidget (IDR 금액 표시) 구현 규칙 전체표시: Rp 1.500.000 단축형: 1,5Jt (1,500,000 이상) 단축형: 500Rb (천 단위) 색상: \#CC0001 (할인가), \#212529 (정가) 크기: 18sp SemiBold 위치: 카드 하단 좌측 고정 AddressChip (위치 표시) 표시 형식 기본: Coblong, Bandung 전체: Lebak Siliwangi, Coblong, Bandung 아이콘: location\_on (빨강) 크기: 12sp, 배경 \#FFF5F5 탭 시: SharedMapBrowser 이동  |  | TrustScoreBadge (신뢰 배지) Trust Level 4단계 0.0\~0.39 → Anggota Baru (회색) 0.4\~0.59 → Terpercaya (파랑) 0.6\~0.79 → Terverifikasi (초록) 0.8\~1.0  → Hero Lokal (금색 별) 표시: 사용자 프로필·카드 작성자 옆 IndonesiaPhoneField 전화번호 입력 규칙 \+62 prefix 고정 표시 0 입력 시 자동 62 변환 포맷: 0812-3456-7890 유효성: 10\~13자리 키보드: numericKeyboard  |
| :---- | :---- | :---- |

### **네비게이션 컴포넌트**

| 컴포넌트 | 구성 | 상태 | 인도네시아 특화 |
| :---: | ----- | ----- | ----- |
| BottomNavigationBar | 5탭 (Beranda·Jual·Berita·Toko·Pesan) | 선택=빨강·미선택=회색 | 탭명 Bahasa Indonesia |
| AppBar | 타이틀+위치칩+알림+검색 | 스크롤 시 축소 | 동네명 표시 (Coblong) |
| FloatingActionButton | \+ 빠른 게시 (빨강) | 탭별 컨텍스트 변경 | Feature별 다른 액션 |
| SearchBar | 통합 검색 (전 Feature) | 자동완성 인도네시아어 | GeoScope 필터 연동 |
| FilterChipRow | 가로 스크롤 필터칩 | 선택=빨강 배경·미선택=테두리 | Feature별 필터 항목 |
| DraggableScrollableSheet | 지도 하단 슬라이딩 패널 | 0.3/0.6/0.95 스냅 | 마커 선택 시 자동 확장 |

## **▌ 3.6 상태 관리 UI 패턴**

| 상태 | UI 표현 | 트리거 | 인도네시아어 메시지 |
| :---: | ----- | ----- | ----- |
| Loading | Shimmer 플레이스홀더 (회색 그라데이션) | API 요청 중 | Memuat... (로딩 중...) |
| Empty | 일러스트 \+ 설명문 \+ 액션 버튼 | 데이터 없음 | Belum ada konten di sekitarmu |
| Error | 아이콘 \+ 에러 설명 \+ '다시 시도' | 네트워크·서버 오류 | Koneksi bermasalah. Coba lagi. |
| Offline | 상단 오렌지 배너 | 네트워크 없음 | Mode offline \- data mungkin tidak terbaru |
| Success | 초록 SnackBar (3초) | 저장·전송 완료 | Berhasil disimpan\! |
| Permission | 모달 설명 \+ 허용/거부 | 앱 권한 요청 | Izinkan akses lokasi untuk... |
| AI Processing | 원형 인디케이터 \+ 텍스트 | Gemini 분석 중 | AI sedang menganalisis... |
| Trust Warning | 노란 배너 (낮은 신뢰) | Trust Score \< 0.4 | Penjual baru \- bertransaksi dengan hati-hati |

## **▌ 3.7 애니메이션 & 마이크로 인터랙션**

| 허용 애니메이션 화면 전환: 300ms SlideTransition 카드 등장: 200ms FadeIn \+ SlideUp 버튼 탭: ScaleDown 95% (100ms) BottomSheet: 350ms slide-up Trust Badge: 500ms shimmer glow Auction 타이머: 실시간 업데이트 Like 버튼: HeartBeat (200ms) 저사양 기기 (RAM \< 2GB) 모든 애니메이션 duration 50% 단축 비디오 자동재생 OFF Shimmer 대신 단색 플레이스홀더 이미지 품질: low (480px) RepaintBoundary 강제 적용  |  | 금지 애니메이션 Lottie 애니메이션 (용량 과다) Parallax 스크롤 (저사양 취약) 500ms 초과 트랜지션 연속 GIF (데이터 절약) 배경 블러 (성능 비용) 인도네시아 특화 UX 당겨서 새로고침 필수 (오프라인→온라인) 긴 목록: itemExtent 고정값 필수 이미지 에러: 기본 회색 플레이스홀더 느린 네트워크: 스켈레톤 UI 우선 배터리 절약 모드 지원  |
| :---- | :---- | :---- |

## **▌ 3.8 아이콘 시스템**

Material Symbols (Filled variant) 기본 사용. Feature별 고유 아이콘 규칙을 준수합니다.

| Feature | 아이콘 | 크기 | 컬러 규칙 | Flutter 코드 |
| :---: | ----- | ----- | ----- | ----- |
| Local News | article | 24dp | Feature 컬러 | Icons.article |
| Marketplace | storefront | 24dp | Feature 컬러 | Icons.storefront |
| Jobs | work | 24dp | Feature 컬러 | Icons.work |
| Auction | gavel | 24dp | Feature 컬러 | Icons.gavel |
| Clubs | groups | 24dp | Feature 컬러 | Icons.groups |
| Lost & Found | search | 24dp | Feature 컬러 | Icons.manage\_search |
| POM | videocam | 24dp | Feature 컬러 | Icons.videocam |
| Real Estate | home | 24dp | Feature 컬러 | Icons.home |
| Local Stores | store | 24dp | Feature 컬러 | Icons.store |
| Together | event | 24dp | Feature 컬러 | Icons.event |
| Chat | chat\_bubble | 24dp | Feature 컬러 | Icons.chat\_bubble |
| Trust Badge | verified | 16dp | Gold·Green·Blue | Icons.verified |
| Location | location\_on | 16dp | \#CC0001 | Icons.location\_on |
| AI Verified | auto\_awesome | 16dp | \#CC0001 | Icons.auto\_awesome |

## **▌ 3.9 화면별 레이아웃 가이드**

### **공통 화면 구조**

| 모든 화면 공통 레이아웃 최상단: SafeArea (노치·펀치홀 대응) AppBar: 동네명 \+ 검색 \+ 알림 아이콘 Body: 스크롤 가능 콘텐츠 영역 하단: BottomNavigationBar (SafeArea 포함) FAB: 우하단 빠른 게시 (Feature별 컨텍스트) 오프라인 배너: 상단 고정 (오렌지) |
| :---- |

### **주요 화면 레이아웃 명세**

| 화면 | 레이아웃 구조 | 특이 사항 | 성능 고려 |
| :---: | ----- | ----- | ----- |
| Smart Feed (홈) | AppBar → FilterChipRow → ListView.builder(signalScore) | CrossLinkSection 하단 삽입 | itemExtent=120 고정 |
| Marketplace 리스트 | AppBar → SearchBar → FilterBar → GridView.builder 2열 | 그리드/리스트 전환 토글 | crossAxisCount=2 |
| Product 상세 | SliverAppBar(사진) → 본문 → 가격+버튼 → CrossLink | BottomBar: 찜하기+채팅+구매 | 이미지 Hero 애니메이션 |
| 지도 화면 | GoogleMap 전체 → 상단필터칩 → DraggableScrollableSheet | 마커 선택 시 카드 표시 | 마커 클러스터링 |
| POM 뷰어 | PageView 풀스크린 세로 스크롤 | 자동재생 토글 | 비디오 메모리 해제 |
| 채팅방 | AppBar(상대방) → ListView(메시지) → 입력창 | 읽음 확인 더블체크 | 메시지 배치 기준 80% |
| Together 상세 | 디지털 전단지 UI (테마 선택) → 참여 버튼 → QR티켓 | 3테마 실시간 프리뷰 | 렌더 캐시 |
| 동네 정체성 | 동네명 배너 → 통계 그리드 → 인기태그 → Feature Top3 | 공유 버튼 필수 | 차트 경량화 |

## **▌ 3.10 접근성 & 다국어 표준**

| 접근성 (A11y) 텍스트 대비: WCAG AA 기준 (4.5:1 이상) Semantics 위젯: 주요 대화형 요소 화면 키보드: 적절한 keyboardType 스크린 리더: MergeSemantics 사용 폰트 크기: 최소 11sp (Caption) 컬러만으로 정보 전달 금지 애니메이션: prefers-reduced-motion 대응 이미지 접근성 semanticLabel 필수 decorativeImage: excludeFromSemantics 아이콘: Semantics label 추가 |  | 다국어 규칙 (i18n) 모든 텍스트: easy\_localization 키 사용 하드코딩 텍스트 절대 금지 날짜: 인도네시아식 (12 April 2026\) 통화: IDR 기본 (CurrencyService 경유) RTL 고려: 아랍어 확장 대비 구조 Bahasa Indonesia 텍스트 원칙 격식체(Bahasa Formal) 사용 자바어 슬랭 사용 금지 CTA: 동사형 (Beli·Jual·Daftar) 오류 메시지: 공감+해결책 형식 Native Speaker 검수 필수 |
| :---- | :---- | :---- |

## **▌ 3.11 Together 디자인 테마 상세**

Together(Bareng Yuk\!) 기능의 디지털 전단지는 3가지 테마를 지원합니다.

| 테마 | 배경 | 제목 폰트 | 강조색 | 타겟 사용자 | 적합 이벤트 |
| :---: | ----- | ----- | ----- | ----- | ----- |
| Neon | \#0D0D0D (다크) | Nunito Sans Bold 형광 | \#00FF88·\#FF00AA | Z세대·나이트라이프 | 클럽·파티·야간 모임 |
| Paper | \#FFFBEB (크림) | 손글씨 느낌 Cursive | \#8B4513·\#CC0001 | 밀레니얼·패밀리 | 소풍·바자르·마켓 |
| Dark | \#1A1A2E (네이비) | Arial Bold 미니멀 | \#CC0001·\#FFFFFF | 비즈니스·성인 | 세미나·스터디·미팅 |

## **▌ 3.12 Placeholder 광고 디자인 규격**

| 코드 | 위치 | 크기 | 형식 | 최소 여백 | 비고 |
| :---: | ----- | ----- | ----- | ----- | ----- |
| A | 뉴스 피드 인라인 | 전체폭 × 80dp | 네이티브 카드 | 8dp | 7번째 아이템마다 |
| B | 리스트 상단 배너 | 전체폭 × 56dp | 배너 | 0dp | Feature 리스트 최상단 |
| C | 상세화면 추천 | 전체폭 × 100dp | 카드형 | 16dp | 상세화면 중간 |
| D | POM 전환 광고 | 전체폭 × 전체높이 | 풀스크린 | 0dp | 5번째 POM마다 |
| E | 동네 히어로 배너 | 전체폭 × 120dp | 이미지 배너 | 0dp | 홈 상단 고정 |
| F | 지도 오버레이 | 커스텀 마커 48dp | 지도 핀 | N/A | 지도 뷰 전용 |
| G | Chat 추천 카드 | 전체폭 × 72dp | 추천 카드 | 8dp | 메시지 10개마다 |
| H | 지도 핀 프리미엄 | 커스텀 핀 56dp | 강조 마커 | N/A | 가게 핀 강조 |

# **PART 4  |  단계별 완료 기준 & 최종 체크리스트**

각 Phase 완료 전 반드시 아래 항목을 전수 확인합니다. 미완료 항목은 다음 Phase로 이동 불가합니다.

## **▌ 전 Phase 공통 완료 기준 (MANDATORY)**

| 항목 | 검증 방법 | 담당 | 기준 |
| :---: | ----- | ----- | ----- |
| GetX·Provider import 없음 | grep \-r 'package:get\\|package:provider' lib/ | review | 0건 |
| 하드코딩 문자열 없음 | grep \-r '\[가-힣\]' lib/ (주석 제외) | i18n | 0건 |
| 하드코딩 통화 없음 | grep \-r '₩\\|KRW\\|USD' lib/ | i18n | 0건 |
| MozzyPostContract 구현 | dart analyze (abstract method 오류) | architect | 0 오류 |
| IDR 포맷 CurrencyService 경유 | grep \-r 'NumberFormat.\*IDR' lib/ | i18n | 0건 직접사용 |
| Firestore 인덱스 132개 이하 | jq '.indexes | length' firestore.indexes.json | firestore | ≤132 |
| 테스트 커버리지 | flutter test \--coverage | test | 30%+ (전체) |
| API 키 하드코딩 없음 | grep \-r 'AIza\\|sk-\\|MIDTRANS' lib/ | security | 0건 |
| PDPB NIK 평문 없음 | grep \-ri 'nik\\|ktp.\*plain' lib/ | security | 0건 |
| APK 크기 | flutter build apk \--release && du \-sh | perf | \< 30MB |

## **▌ UI/UX 디자인 준수 체크리스트 (화면 완성 시)**

| 항목 | 검증 방법 | 담당 |
| :---: | ----- | ----- |
| 모든 터치 영역 ≥ 48×48dp | Flutter DevTools → Widget Inspector | dart·perf |
| Primary 컬러 \#CC0001 일관 적용 | ColorScheme 검토 | dart |
| IDR 금액 Rp+점단위 포맷 | UI 화면 수동 확인 | i18n |
| 인도네시아어 텍스트 전수 표시 | 앱 언어=id 설정 후 확인 | i18n |
| Shimmer 로딩 상태 존재 | 네트워크 지연 시뮬레이션 | dart |
| 오프라인 상태 배너 표시 | 기내 모드 ON 후 확인 | dart·perf |
| CrossLinkSection 상세화면 존재 | Feature 상세화면 하단 확인 | dart |
| Trust Score Badge 표시 | 사용자 프로필·카드 확인 | dart |
| 에러 상태 UI 인도네시아어 | 에러 강제 발생 후 확인 | dart·i18n |
| TrustScoreBadge 4레벨 렌더링 | 0.2·0.5·0.7·0.9 테스트 | dart |
| 저사양 기기 확인 (2GB 에뮬레이터) | Android Emulator RAM 2GB | perf |
| 다크모드 가독성 | 시스템 다크모드 전환 | dart |

## **▌ 런칭 전 최종 게이트 체크리스트 (Phase 6\)**

| 🚨 CRITICAL — 미완료 시 런칭 불가 □ PDPB 법률 자문 검토 완료 (인도네시아 현지 법무법인) □ OJK 전자금융 관련 법규 검토 (Wallet 기능) □ Midtrans 운영 계정 승인 완료 (심사 2\~3주 소요) □ Google Play Developer 계정 인도네시아 지역 설정 □ 개인정보처리방침 PDPB 준수 URL 공개 □ 앱 설명 Bahasa Indonesia Native Speaker 검수 □ 스크린샷 8장 (반둥·자카르타 실제 사용 화면) □ 크래시율 \< 2% (Firebase Crashlytics 7일 기준) □ 결제 성공률 \> 93% (Midtrans 운영 환경 테스트) □ 인도네시아어 번역 100% 완성 (누락 키 0건) □ Firestore Security Rules 침투 테스트 완료 □ APK 크기 30MB 이하 최종 확인 □ 테스트 커버리지 30%+ (Shared Contract 95%+) □ CS 채널 (WhatsApp Business \+62) 운영 준비 |
| :---- |

## **▌ 월간 KPI 추적 체크리스트 (런칭 후)**

| 지표 | 측정 방법 | 기준 (6개월) | 주기 |
| :---: | ----- | ----- | ----- |
| DAU | Firebase Analytics | 25,000+ | 매일 |
| D7 리텐션 | Cohort 분석 | 30%+ | 매주 |
| D30 리텐션 | Cohort 분석 | 18%+ | 매월 |
| Feature 이용/세션 | Firebase Events | 2.5개+ | 매주 |
| MRR (IDR) | Midtrans \+ Play Billing | Rp 150M+ | 매월 |
| 결제 성공률 | Midtrans 대시보드 | 95%+ | 매일 |
| 크래시율 | Firebase Crashlytics | \< 0.5% | 매일 |
| App Rating | PlayStore/AppStore | 4.2+ | 매주 |
| Trust Score 평균 | Firestore 집계 | 0.6+ | 매월 |
| AI 검수 건수 | Cloud Function 로그 | 5,000+/월 | 매월 |
| Boost 전환율 | Analytics Events | 15%+ | 매주 |
| CS 응답 시간 | WhatsApp Business | \< 2시간 | 매일 |

 

| 🇮🇩  MOZZY (모지) INDONESIA 단위별 개발 진행표 · 체크리스트 · UI/UX 디자인 가이드 Ver 1.0  |  2026.04.26  |  Confidential *© 2026 Mozzy (모지). All Rights Reserved. Internal Use Only.* |
| :---: |

