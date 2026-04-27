

| 🇮🇩  MOZZY INDONESIA |
| :---: |

| 하이퍼로컬 슈퍼앱 개발 기획서 |
| :---: |

*Hyperlocal Super App — Indonesia Market Entry Plan*

Ver 1.0  |  2026년 4월 26일  |  Confidential

| 🎯 타겟 시장 인도네시아 Phase 1 자카르타 · 반둥 · 수라바야 | ⏱ 개발 기간 27주+ (8 Phase) MVP → 런칭 → 글로벌 릴레이 | 💰 수익 목표 MRR Rp 750M (12개월) GoPay · OVO · DANA · VA |
| :---: | :---: | :---: |

# **1\. Executive Summary**

Mozzy(모지)는 Flutter 단일 코드베이스로 인도네시아를 Phase 1 핵심 시장으로 공략하는 하이퍼로컬 슈퍼앱입니다. 동네 소식·중고거래·구인구직·경매·동호회·분실물·뽐·부동산·주변 가게·함께 해요·채팅 등 11개 핵심 생활 기능을 하나의 앱에 통합하여, 인도네시아 2억 7천만 인구가 어떤 동네에서든 일상의 모든 필요를 해결할 수 있도록 설계됩니다.

| 🌟 Why Indonesia First?   인구 2억 7천만 명 (세계 4위) — 스마트폰 보급률 78%, 모바일 결제 사용자 1억 명+   Gojek·OLX·Kaskus 등 경쟁사가 하이퍼로컬 커뮤니티 영역을 공략하지 않음   인도네시아 전용 주소 체계(Provinsi→Kelurahan)와 결제(GoPay·OVO·DANA) 지원으로 Lock-in 확보   Track 1+2 듀얼 트랙 설계 → 인도네시아 이후 29개국 확장의 레퍼런스 모델 |
| :---- |

## **▌ 핵심 차별화 포인트**

| 구분 | Mozzy Indonesia | 기존 경쟁사 |
| ----- | ----- | ----- |
| 하이퍼로컬 | Kelurahan(마을) 단위 AI 피드 | 시/군 단위 리스트 |
| AI 검수 | Gemini 3.0 물품 신뢰도 검증 | 미제공 (OLX 등) |
| Trust Score | 0.0\~1.0 신뢰 점수 시스템 | 단순 신고 기반 |
| 결제 | GoPay·OVO·DANA·VA·Alfamart | 일부 수단만 |
| 크로스 피처 | 11개 Feature 7대 연결 전략 | 독립 기능 분리 |
| 번역 | ML Kit 온디바이스 다국어 | 미제공 |

# **2\. 인도네시아 시장 분석**

## **▌ 2.1 시장 규모 & 기회**

| 지표 | 수치 | 의미 |
| ----- | ----- | ----- |
| 인구 | 2억 7천만 명 (세계 4위) | 거대 내수 시장 |
| 스마트폰 보급률 | 78% (약 2.1억 대) | 디지털 접근성 확보 |
| 인터넷 사용자 | 2억 명+ | 플랫폼 기반 충분 |
| 모바일 결제 사용자 | 1억 명+ | Fintech 생태계 성숙 |
| e-Commerce GMV | $62B (2025) | 온라인 거래 문화 |
| 도시화율 | 58% (급성장) | 하이퍼로컬 수요↑ |
| 중산층 비율 | 52% | 구매력 상승 중 |
| 대학교 수 | 4,000+개 | 영 어덜트 타겟 풍부 |

## **▌ 2.2 타겟 도시 우선순위**

| 순위 | 도시 | 인구 | 특징 | Mozzy 전략 |
| ----- | ----- | ----- | ----- | ----- |
| 1위 | Bandung (반둥) | 260만 | 대학도시, 디지털 친화 | Marketplace \+ Community |
| 2위 | Jakarta Selatan | 220만 | 구매력 최상위, 트렌드 세터 | Business \+ Premium |
| 3위 | Surabaya (수라바야) | 290만 | 중고거래 활성, 가격 민감 | Marketplace \+ Jobs |
| 4위 | Medan (메단) | 260만 | 수마트라 최대, 상업 도시 | Stores \+ Marketplace |
| 5위 | Yogyakarta | 42만 | 대학도시, 문화/예술 중심 | POM \+ Clubs |

## **▌ 2.3 경쟁사 분석**

| 경쟁사 | 강점 | 약점 | Mozzy 기회 |
| ----- | ----- | ----- | ----- |
| Gojek | 슈퍼앱 1위, GoTo 생태계 | 하이퍼로컬 커뮤니티 없음 | 커뮤니티·중고·부동산 |
| OLX Indonesia | 중고거래 인지도 1위 | AI 없음, 신뢰도 낮음 | AI 검수 \+ Trust Score |
| Kaskus | 커뮤니티 문화 강함 | 노후 UX, Z세대 이탈 | 현대적 UX \+ 로컬 |
| Tokopedia | 커머스 최강 | 지역 중고 약함 | 동네 기반 중고 생태계 |
| Facebook Groups | 소셜 강함 | 거래 안전성 없음 | 검증된 로컬 거래 |

## **▌ 2.4 인도네시아 법규 준수**

| 규제 | 내용 | Mozzy 대응 |
| ----- | ----- | ----- |
| PDPB | 개인정보보호법 | NIK 미수집, 동의 관리, 삭제권 보장 |
| OJK | 금융서비스청 | Wallet 최대 잔액 Rp 20M, KYC 필수 |
| Kominfo | 데이터 현지화 | Firebase asia-southeast2 (자카르타) |
| UU ITE | 사이버법 | 유해 콘텐츠 AI 필터링 |
| Halal | 이슬람 거래 규범 | 주류·도박 카테고리 전면 제외 |

# **3\. 제품 정의 — Hyperlocal Super App**

## **▌ 3.1 제품 비전**

| 비전 (Vision)   "어느 동네에서 올린 생활 포스트든, 필요한 사람에게는 국경을 넘어 발견되고 연결된다."      인도네시아 Kelurahan(마을) 단위에서 시작하여, 동네 → 시 → 국가 → 글로벌로   점진적으로 도달 범위를 확장하는 Local-first, Global-ready 네이버후드 네트워크 |
| :---- |

## **▌ 3.2 5-Layer 아키텍처**

**모든 기능은 아래 5개 레이어로 엄격히 분리되어 설계됩니다.**

| 레이어 | 구성 요소 | 역할 |
| ----- | ----- | ----- |
| ① App Shell | Navigation · Auth · i18n · Deep Link | 앱 진입점 및 공통 인프라 |
| ② Discovery Layer | Smart Feed · Search · Cross-Link · Relay | 콘텐츠 발견 및 배포 |
| ③ Geo Layer | GeoScope · SharedMap · CountryRegistry | 인도네시아 Track 1+2 주소 |
| ④ Trust Layer | Trust Score · AI Screening · Moderation | 신뢰 및 AI 검증 |
| ⑤ Feature Domains | 11개 독립 기능 도메인 | 핵심 생활 서비스 |

## **▌ 3.3 인도네시아 전용 Geo 체계 (Track 1+2)**

인도네시아는 유일하게 Track 1+2 듀얼 트랙을 운영합니다.

| 트랙 | 체계 | 레벨 | 예시 |
| ----- | ----- | ----- | ----- |
| Track 1 | 인도네시아 레거시 | Provinsi → Kabupaten → Kecamatan → Kelurahan | Jawa Barat → Kota Bandung → Coblong → Lebak Siliwangi |
| Track 2 | 글로벌 표준 | L1 → L2 → L3 | Jawa Barat → Bandung → Coblong |

## **▌ 3.4 Shared Contract — 11개 Feature 공통 데이터 모델**

모든 Feature의 데이터 모델은 아래 공통 필드를 반드시 구현합니다.

| 필드 | 타입 | 설명 |
| ----- | ----- | ----- |
| geoScope | enum | neighborhood | city | country | global |
| reachMode | enum | local\_only | progressive | global\_relay |
| trustScore | double | 0.0 \~ 1.0 신뢰 점수 (AI 기반) |
| signalScore | double | Smart Feed 노출 우선순위 가중치 |
| translationState | Map\<lang, text\> | 언어별 번역 캐시 (ML Kit) |
| discoveryChannels | List\<String\> | feed | map | search | relay |
| mapVisibility | bool | 공유 지도(SharedMap) 노출 여부 |

# **4\. 11개 핵심 기능 (Feature Domains)**

## **▌ 4.1 기능 개요 및 성숙도**

| \# | 기능 | 인도네시아명 | 성숙도 | 주요 수익 |
| ----- | ----- | ----- | ----- | ----- |
| 01 | Local News (동네 소식) | Berita Lokal | ★★★★☆ | Boost · 광고 |
| 02 | Marketplace (중고거래) | Jual Beli | ★★★★★ | AI 검수 · 수수료 |
| 03 | Jobs (구인구직) | Lowongan Kerja | ★★★★☆ | Boost · 프리미엄 |
| 04 | Auction (경매) | Lelang | ★★★☆☆ | 낙찰 5% 수수료 |
| 05 | Clubs (동호회) | Komunitas | ★★★★☆ | 그룹 배너 |
| 06 | Lost & Found (분실물) | Barang Hilang | ★★★☆☆ | 긴급 Boost |
| 07 | POM / 뽐 | Pamer\! | ★★★☆☆ | 크리에이터 분배 |
| 08 | Real Estate (부동산) | Properti | ★★★☆☆ | 프리미엄 리스팅 |
| 09 | Local Stores (주변 가게) | Toko Sekitar | ★★★☆☆ | Business+ 구독 |
| 10 | Together (함께 해요) | Bareng Yuk\! | ★★★☆☆ | 이벤트 Boost |
| 11 | Chat & Find Friends | Pesan | ★★★☆☆ | Chat 추천 광고 |

## **▌ 4.2 인도네시아 특화 기능 상세**

### **Marketplace — AI 검수 시스템 (핵심 차별화)**

Google Gemini 3.0 기반 이미지 분석으로 물품의 상태·시세를 사전 검증합니다.

* AI 검수 결과: 품목 분류, 상태 등급 (S/A/B/C/D), 시세 추정 (IDR)

* 프롬프트 언어: Bahasa Indonesia — "Analisis produk bekas untuk pasar Indonesia"

* Rate Limiting: 최대 10건/분 (Gemini API 비용 관리)

* 결과 UI: 'Terverifikasi AI' 배지 \+ 검수 리포트 팝업

### **Local Stores — Store-Centric Ecosystem**

가게를 중심으로 4개 Feature(Marketplace·Jobs·News·Reviews)를 통합합니다.

| 탭 | 연동 Feature | 내용 |
| ----- | ----- | ----- |
| 📋 Info | 기본 정보 | 영업시간 · 위치 지도 · 전화 |
| 🛍️ Produk | Marketplace | 가게 판매 물품 목록 |
| 👥 Lowongan | Jobs | 현재 모집 중인 포지션 |
| 📰 Berita | Local News | 가게 이벤트/공지 |
| ⭐ Ulasan | Review | 방문자 리뷰 \+ 별점 |

### **Together (Bareng Yuk\!) — 디지털 전단지 UI**

* 슬로건: "Sekarang, mau bareng?" (지금, 같이 할래요?)

* 테마 3종: Neon / Paper / Dark — 인도네시아 젊은 층 감성

* QR 티켓 (Together Pass): 참여 시 QR 발급 → 현장 스캐너 인증

* 최대 참여 인원: 2\~10명 (소규모 모임 중심)

# **5\. 7대 Cross-Feature 연결 전략**

11개 Feature를 유기적으로 연결하여 세션 체류 시간 \+140%, ARPU \+300%를 목표합니다.

| 전략 | 이름 | 메커니즘 | 기대 효과 |
| ----- | ----- | ----- | ----- |
| 전략 1 | Context-Aware Cross-Linking | 모든 상세화면 하단 '이 동네에서 더 보기' | Feature 이용/세션 \+108% |
| 전략 2 | Pom as Universal Promotion | 모든 Feature 콘텐츠 → Pom 숏폼 홍보 | 체류 시간 \+30%, 전환율 \+15% |
| 전략 3 | Store-Centric Ecosystem | 가게 5탭 \= Marketplace+Jobs+News+Review | B2B 수익 허브 |
| 전략 4 | Together × All Features | 모든 Feature와 이벤트 연결 | 오프라인 전환 리텐션↑ |
| 전략 5 | AI Smart Feed | 시간대별 Gemini 가중치 개인화 | D30 리텐션 \+50% |
| 전략 6 | Neighborhood Identity | 동네 프로필 집계 통계 시각화 | 동네 커뮤니티 충성도↑ |
| 전략 7 | Smart Notification (Nudge) | 행동 기반 Feature 간 넛지 알림 | 재방문 전환율↑ |

## **▌ Smart Feed 신호점수 공식**

| signalScore \= (recency × 0.3) \+ (relevance × 0.25) \+ (engagement × 0.2) \+ (diversity × 0.15) \+ (trust × 0.1)   Recency 0.3    — 게시 시간 기반 감쇄 (최신 콘텐츠 우선)   Relevance 0.25 — 사용자 관심사/위치 매칭 (Kecamatan 기준)   Engagement 0.2 — 좋아요/댓글/조회 수 정규화   Diversity 0.15 — 11개 Feature 유형 다양성 보장   Trust 0.1      — 작성자 trustScore 반영 |
| :---- |

## **▌ 인도네시아 시간대별 Smart Feed 가중치 (WIB 기준)**

| 시간대 | 높은 가중치 Feature | 근거 |
| ----- | ----- | ----- |
| 오전 7\~9시 | Jobs, Local News | 출근길 정보 탐색 |
| 점심 12\~14시 | Local Stores, POM | 맛집 탐색 · 여유 시간 |
| 퇴근 17\~20시 | Marketplace, Together | 거래 · 저녁 약속 |
| 야간 21\~23시 | POM, Clubs, News | 감성 콘텐츠 · 커뮤니티 |
| 주말 | Together, Marketplace, POM | 여가 · 거래 · 창작 |

# **6\. 기술 스택 & 아키텍처**

## **▌ 6.1 확정 기술 스택**

| 영역 | 기술 | 선택 이유 |
| ----- | ----- | ----- |
| Framework | Flutter 3.27+ (Dart 3.6+) | Android/iOS 단일 코드베이스 |
| State 관리 | Riverpod 3 (GetX·Provider 금지) | 타입 안전, 테스트 용이 |
| Backend | Firebase (Firestore·Auth·Storage·Functions·FCM) | 실시간 \+ 서버리스 |
| AI | Google Gemini 3.0 (gemini-2.0-flash-exp) | 멀티모달 이미지 분석 |
| 번역 | Google ML Kit (온디바이스) | 오프라인 지원, 비용 절감 |
| 지도 | Google Maps Flutter \+ Geolocator | 인도네시아 커버리지 최고 |
| 결제 | Midtrans (GoPay·OVO·DANA·VA·Alfamart) | 인도네시아 공인 PG사 |
| i18n | easy\_localization 3.x | 25개 언어 런타임 지원 |
| 로컬 캐시 | Hive Flutter | 오프라인 모드 대비 |
| CI/CD | GitHub Actions → Firebase App Distribution | 자동화 배포 |
| Analytics | Firebase Analytics \+ Crashlytics | 인도네시아 사용자 행동 추적 |

## **▌ 6.2 인도네시아 특화 기술 요건**

* Firestore Region: asia-southeast2 (자카르타) — Kominfo 데이터 현지화

* 오프라인 퍼스트: Hive 캐시 — 인도네시아 외딴 지역 저속 인터넷 대비

* 저사양 기기 최적화: RAM 2GB 기기 타겟 40% (이미지 WebP 압축, 고정 ListView)

* APK 크기: 30MB 이하 (저장공간 부족 기기 고려)

* 멀티 타임존: WIB(UTC+7)·WITA(UTC+8)·WIT(UTC+9) 자동 감지

## **▌ 6.3 Firestore 인덱스 관리 (132개 한도)**

| Feature | 인덱스 수 | 핵심 쿼리 |
| ----- | ----- | ----- |
| Marketplace (used\_items) | 18개 | kabupaten \+ isAiVerified \+ signalScore |
| Local News (posts) | 12개 | kecamatan \+ category \+ createdAt |
| Local Stores (shops) | 12개 | kecamatan \+ category \+ averageRating |
| Jobs (job\_posts) | 12개 | kabupaten \+ jobType \+ salary |
| Discovery/Feed | 10개 | geoScope \+ signalScore \+ discoveryChannels |
| POM (pom) | 10개 | kecamatan \+ mediaType \+ likesCount |
| Real Estate (real\_estate) | 10개 | kabupaten \+ transactionType \+ price |
| Auction (auctions) | 10개 | kabupaten \+ isAiVerified \+ endTime |
| Clubs (groups) | 8개 | kecamatan \+ category \+ memberCount |
| Lost & Found (lost\_found) | 8개 | kecamatan \+ type \+ createdAt |
| Together (together\_posts) | 8개 | kecamatan \+ designTheme \+ eventDate |
| Chat (chat\_rooms) | 6개 | participants \+ updatedAt |
| 공통/App Shell | 8개 | 사용자·알림·메타데이터 |

# **7\. 개발 팀 구성 — Claude Code 멀티 에이전트**

이 프로젝트는 Claude Code의 멀티 에이전트 기능을 활용하여 13개 전문 에이전트가 병렬·체인 방식으로 개발을 수행합니다.

## **▌ 7.1 에이전트 팀 구성**

| 구분 | 에이전트 | 핵심 책임 | 파일 |
| ----- | ----- | ----- | ----- |
| 코드 | architect-agent | 5-Layer 경계 수호 · Shared Contract 게이트키퍼 | agents/architect-agent.md |
| 코드 | dart-agent | Flutter/Dart 코드 생성 · Riverpod 3 패턴 | agents/dart-agent.md |
| 코드 | firestore-agent | 스키마 설계 · 132 인덱스 관리 · 쿼리 최적화 | agents/firestore-agent.md |
| 코드 | test-agent | 1,033+ 테스트 · 30% 커버리지 달성 | agents/test-agent.md |
| 코드 | i18n-agent | Bahasa Indonesia 마스터 · 25개 언어 동기화 | agents/i18n-agent.md |
| 분석 | review-agent | PR 리뷰 · 아키텍처 위반 탐지 | agents/review-agent.md |
| 분석 | perf-agent | 저사양 기기 최적화 · APK 크기 관리 | agents/perf-agent.md |
| 분석 | security-agent | PDPB 준수 · Firestore Rules · 보안 스캔 | agents/security-agent.md |
| 도메인 | geo-agent | 인도네시아 Track 1+2 · CountryRegistry | agents/geo-agent.md |
| 도메인 | ai-agent | Gemini 3.0 · ML Kit · NudgeEngine | agents/ai-agent.md |
| 도메인 | monetization-agent | Midtrans 결제 · OJK 준수 · 광고 8종 | agents/monetization-agent.md |
| 운영 | deploy-agent | GitHub Actions · PlayStore · AppStore | agents/deploy-agent.md |
| 운영 | market-agent | GTM · KPI 추적 · 경쟁사 모니터링 | agents/market-agent.md |

## **▌ 7.2 에이전트 협업 워크플로우**

**모든 기능 개발은 아래 순서로 에이전트 체인을 통해 수행됩니다.**

| 단계 | 에이전트 | 역할 |
| ----- | ----- | ----- |
| 1\. 설계 검토 | architect-agent | 레이어 경계·Shared Contract 검토 및 승인 (Gate Keeper) |
| 2\. 코드 생성 | dart-agent | Flutter 화면·Provider·모델 구현 |
| 3\. DB 설계 | firestore-agent | 컬렉션 스키마·인덱스·Security Rules |
| 4\. 테스트 작성 | test-agent | 단위·위젯·통합 테스트 작성 |
| 5\. 코드 리뷰 | review-agent | 품질 검증·위반 탐지·승인 |
| 6\. 배포 | deploy-agent | 스테이징 → 프로덕션 자동 배포 |

인도네시아 특화 작업 시 추가 에이전트 개입:

* 위치/주소 관련 → geo-agent

* AI 기능 (검수·매칭·피드) → ai-agent

* 결제·구독·광고 → monetization-agent

* 번역·현지화 → i18n-agent

* 성능 이슈 → perf-agent

* 보안·PDPB → security-agent

# **8\. 개발 로드맵 (8 Phase · 27주+)**

## **▌ 8.1 Phase 전체 일정**

| Phase | 기간 | 목표 | 주요 산출물 | 담당 에이전트 |
| ----- | ----- | ----- | ----- | ----- |
| Phase 0 | Week 1\~2 | 프로젝트 셋업 | 폴더구조·Firebase·CI/CD | architect, dart, deploy |
| Phase 1 | Week 3\~6 | App Shell \+ Geo Layer | 인증·위치·i18n·Track 1+2 | geo, dart, i18n |
| Phase 2 | Week 7\~10 | Core 3 Features MVP | 뉴스·마켓·채팅 동작 | dart, firestore, test |
| Phase 3 | Week 11\~14 | 나머지 8개 Feature | 11개 Feature 완성 | dart, ai, security |
| Phase 4 | Week 15\~18 | 수익화 시스템 | GoPay·OVO·구독·광고 | monetization, deploy |
| Phase 5 | Week 19\~22 | Smart Feed \+ 연결 전략 | AI 피드·7대 크로스 | ai, dart, perf |
| Phase 6 | Week 23\~26 | 베타 런칭 (반둥·자카르타) | PlayStore·AppStore 출시 | deploy, market |
| Phase 7 | Week 27+ | Growth \+ 글로벌 준비 | DAU 성장·29개국 준비 | market, ai, deploy |

## **▌ 8.2 Phase별 완료 기준 (Definition of Done)**

| Phase | 완료 기준 |
| ----- | ----- |
| Phase 0 | flutter test 통과 \+ Firebase 연결 확인 \+ CI 첫 빌드 성공 |
| Phase 1 | 반둥 Coblong 기준 위치 감지 → Kecamatan 주소 표시 → 로그인 완료 |
| Phase 2 | 뉴스 피드 표시 \+ 물품 등록·AI 검수 \+ 채팅 완료 |
| Phase 3 | 11개 Feature 모두 CRUD 동작 \+ CrossLink 연결 확인 |
| Phase 4 | GoPay 실결제 성공 \+ 구독 결제 완료 \+ 광고 8종 노출 |
| Phase 5 | Smart Feed signalScore 정렬 확인 \+ NudgeEngine 알림 발송 |
| Phase 6 | PlayStore 공개 출시 \+ 반둥 DAU 500+ \+ 크래시율 \< 2% |
| Phase 7 | DAU 25,000+ (3개 도시) \+ MRR Rp 150M+ 달성 |

# **9\. 인도네시아 수익화 전략**

## **▌ 9.1 5대 수익원 포트폴리오**

| 수익원 | 유형 | 목표 비율 | 주요 수단 |
| ----- | ----- | ----- | ----- |
| Boost & Sponsored Content | B2C/B2B | 30% | 피드 상단 노출 · 동네 Boost |
| 프리미엄 리스팅 | B2C/B2B | 20% | Marketplace · 부동산 · Jobs 상단 |
| 거래 수수료 | B2C | 15% | Auction 낙찰 5% · Marketplace 택배 2\~5% |
| 구독 (Mozzy+/Business+) | B2C/B2B | 20% | 개인 Rp 29,000/월 · 비즈 Rp 99,000/월 |
| AI 검수/분석 서비스 | B2C | 15% | 물품 검수 Rp 5,000\~15,000/건 |

## **▌ 9.2 인도네시아 결제 시스템 (Midtrans)**

| 결제 수단 | 타겟 | 수수료 | 특이사항 |
| ----- | ----- | ----- | ----- |
| GoPay (Gojek) | 도시 밀레니얼 | 2% | 딥링크 고젝 앱 연동 |
| OVO (Grab) | 도시 Z세대 | 2% | Grab 생태계 연동 |
| DANA (Bukalapak) | 중산층 전반 | 2% | Bukalapak 연동 |
| Virtual Account (VA) | 중장년·기업 | Rp 4,000 고정 | BCA·Mandiri·BNI·BRI |
| Alfamart/Indomaret | 농촌·현금 사용자 | Rp 2,500 고정 | 전국 편의점 결제 |
| QRIS | 전 연령 | 0.7% | QR 통합 표준 |

## **▌ 9.3 광고 Placeholder 8종**

| 코드 | 위치 | 형식 | 타겟팅 |
| ----- | ----- | ----- | ----- |
| Placeholder A | Local News 피드 인라인 | 네이티브 광고 | Kecamatan 단위 |
| Placeholder B | 리스트 상단 배너 | 배너 광고 | Feature 카테고리 |
| Placeholder C | 상세화면 추천 섹션 | 카드형 추천 | 관련 콘텐츠 |
| Placeholder D | POM 전환 광고 | 풀스크린 인터스티셜 | Kelurahan |
| Placeholder E | 동네 히어로 배너 | 월정액 고정 배너 Rp 2M/월 | Kelurahan |
| Placeholder F | 지도 오버레이 | 지도 스폰서 핀 | 반경 500m |
| Placeholder G | Chat 추천 | 맥락 기반 추천 카드 | 대화 키워드 |
| Placeholder H | 지도 핀 프리미엄 | 강조 표시 핀 Rp 50K/월 | 가게 위치 |

## **▌ 9.4 IDR 수익 목표**

| 지표 | 3개월 (베타) | 6개월 | 12개월 |
| ----- | ----- | ----- | ----- |
| DAU | 5,000 | 25,000 | 100,000 |
| 등록 도시 | 반둥·자카르타 | \+수라바야·메단 | 10대 도시 |
| D7 리텐션 | 25% | 30% | 35% |
| MRR (IDR) | Rp 25M | Rp 150M | Rp 750M |
| Mozzy+ 구독자 | 500명 | 3,000명 | 15,000명 |
| Business+ 구독자 | 50개 가게 | 300개 | 1,500개 |
| App Rating | 4.0+ | 4.2+ | 4.5+ |

# **10\. Go-to-Market 전략 (인도네시아)**

## **▌ 10.1 단계별 도시 확장 전략**

| 단계 | 도시 | 기간 | 전략 | 목표 DAU |
| ----- | ----- | ----- | ----- | ----- |
| 1단계 | Bandung (반둥) | Month 1\~3 | 캠퍼스 오프라인 부스 · TikTok KOL | 5,000 |
| 2단계 | Jakarta Selatan | Month 3\~5 | Business+ 무료 체험 · 인플루언서 | 15,000 |
| 3단계 | Surabaya (수라바야) | Month 5\~7 | Marketplace 집중 · 중고거래 캠페인 | 25,000 |
| 4단계 | Medan \+ Semarang | Month 8\~10 | 지역 파트너 · 소상공인 프로그램 | 50,000 |
| 5단계 | 전국 10대 도시 | Month 11\~12 | 앱 스토어 최적화 · TV 광고 | 100,000 |

## **▌ 10.2 반둥(Bandung) 집중 공략 계획 (Month 1\~3)**

반둥을 1호 도시로 선정한 이유: 자카르타 대비 경쟁 낮음 \+ ITB·UNPAD·Telkom University 대학생 밀집 \+ 디지털 수용성 높음.

* 오프라인: 대학 캠퍼스 부스 설치 (ITB, UNPAD, Telkom University, UPI)

* 온라인: 반둥 로컬 TikTok/Instagram 인플루언서 KOL 10명

* 캠페인: 'Jual Beli Aman di Bandung' (반둥의 안전한 중고거래)

* 프로모션: 첫 AI 검수 5,000건 무료

* 커뮤니티: 대학교 학생회 파트너십 → Clubs 기능 연계

## **▌ 10.3 인도네시아 바이럴 루프 설계**

| 루프 | 트리거 | 행동 | 보상 |
| ----- | ----- | ----- | ----- |
| 거래 루프 | 물건 팔기 → AI 검수 | 빠른 거래 완료 | Trust Score 상승 → 친구 추천 |
| 뉴스 루프 | 동네 소식 보기 | 댓글·공유 | 이웃 알림 → 재방문 |
| 구인 루프 | 구인 등록 | 지원자 채팅 | 거래 → 가게 팔로우 |
| 창작 루프 | POM 숏폼 업로드 | 외부 SNS 공유 | 크리에이터 수익 분배 |
| 모임 루프 | Together 참여 | QR 인증 | 후기 POM → 신규 유입 |

# **11\. 리스크 분석 & 대응 전략**

| 리스크 | 심각도 | 발생 가능성 | 대응 전략 |
| ----- | ----- | ----- | ----- |
| Gemini API 비용 초과 | High | Medium | Rate Limiter 10건/분 · 온디바이스 ML Kit 병행 |
| Midtrans 결제 실패율 | High | Medium | 웹훅 재시도 로직 · 다중 결제수단 fallback |
| PDPB 법규 위반 | Critical | Low | security-agent 상시 감사 · 법무법인 자문 |
| Firestore 인덱스 한도 초과 | High | Medium | firestore-agent Gate Keeper · 쿼리 재설계 |
| 저사양 기기 크래시 | Medium | High | perf-agent 최적화 · RAM 2GB 에뮬레이터 테스트 |
| Gojek 유사 서비스 출시 | Medium | Low | 하이퍼로컬 커뮤니티 Lock-in · Trust Score 차별화 |
| 콘텐츠 신뢰도 문제 | High | Medium | AI 사전 스크리닝 \+ 커뮤니티 신고 시스템 |
| 인도네시아어 번역 품질 | Medium | Medium | Native Speaker 검수 · ML Kit 자동 감지 |

# **12\. 개발 체크리스트 요약**

## **▌ Phase 0 — 프로젝트 셋업 (핵심 항목)**

1. Firebase 프로젝트 생성: mozzy-indonesia-prod / mozzy-indonesia-dev

2. Firestore Region: asia-southeast2 (자카르타) 설정

3. Flutter 프로젝트 초기화 \+ Riverpod 3 패키지 구성

4. lib/shared/contracts/post\_contract.dart — MozzyPostContract 생성

5. assets/config/countries/ID.json — CountryRegistry 완성

6. assets/translations/id.json — Bahasa Indonesia 마스터 파일

7. GitHub Actions CI/CD 파이프라인 설정

## **▌ Phase 1 — Geo Layer & App Shell (핵심 항목)**

8. IndonesiaLocationService — GPS → Track 1 역지오코딩

9. 타임존 자동 감지 (WIB·WITA·WIT) 구현

10. 전화번호 인증 (+62 SMS OTP)

11. formatIDR() — 인도네시아식 금액 포맷 (Rp 1.500.000)

12. GoRouter 11개 Feature 라우트 설정

## **▌ Phase 4 — 수익화 (핵심 항목)**

13. Midtrans GoPay 딥링크 연동 테스트

14. OJK 준수: Wallet 최대 잔액 Rp 20,000,000 제한

15. Mozzy+ 구독 Google Play Billing 연동

16. 광고 Placeholder 8종 위치 확정 및 구현

17. Boost 결제 플로우 (IDR 기준)

## **▌ 런칭 전 필수 체크 (Phase 6\)**

18. PDPB 컴플라이언스 최종 감사 (security-agent)

19. APK 크기 30MB 이하 확인

20. 크래시 프리 비율 99%+ 달성

21. PlayStore 인도네시아 스크린샷 8장 (반둥/자카르타 배경)

22. 앱 설명 Bahasa Indonesia 버전 완성

23. 개인정보처리방침 PDPB 준수 URL 등록

# **13\. 성공 지표 (KPI Dashboard)**

## **▌ 13.1 Product KPI**

| 지표 | Phase 2 (10주) | Phase 4 (18주) | Phase 6 (26주) | Phase 7 목표 |
| ----- | ----- | ----- | ----- | ----- |
| DAU | 500 | 5,000 | 15,000 | 100,000+ |
| Feature 이용/세션 | 1.2개 | 1.8개 | 2.5개 | 3.5개 |
| 세션 체류 시간 | 3분 | 5분 | 8분 | 12분 |
| D7 리텐션 | 20% | 25% | 30% | 35% |
| D30 리텐션 | 10% | 13% | 18% | 25% |

## **▌ 13.2 Revenue KPI (IDR)**

| 지표 | 3개월 | 6개월 | 12개월 |
| ----- | ----- | ----- | ----- |
| MRR | Rp 25,000,000 | Rp 150,000,000 | Rp 750,000,000 |
| ARPU (월) | Rp 5,000 | Rp 6,000 | Rp 7,500 |
| Mozzy+ 구독자 | 500명 | 3,000명 | 15,000명 |
| Business+ 가게 | 50개 | 300개 | 1,500개 |
| Midtrans 결제 성공률 | 93%+ | 95%+ | 97%+ |

## **▌ 13.3 Technical KPI**

| 지표 | 현재 기준 | 목표 |
| ----- | ----- | ----- |
| 테스트 커버리지 | 0% (초기) | 30%+ (Shared Contract 95%) |
| Firestore 인덱스 | 0개 | 132개 이하 유지 |
| 앱 크래시 프리 비율 | \- | 99%+ (Crashlytics 기준) |
| APK 크기 | \- | 30MB 이하 |
| 앱 시작 시간 | \- | 2초 이하 (콜드 스타트) |
| 빌드 시간 (CI) | \- | 5분 이하 |
| App Store Rating | \- | 4.0+ (인도네시아 리뷰) |

# **14\. 부록**

## **▌ A. 인도네시아 34개 Provinsi (행정구역)**

인도네시아는 34개 Provinsi, 514개 Kabupaten/Kota, 약 7,200개 Kecamatan, 약 83,000개 Kelurahan으로 구성됩니다. Mozzy는 이 전체 계층을 Track 1로 지원하며, Kecamatan을 하이퍼로컬 기본 단위, Kelurahan을 최소 단위로 설정합니다.

| 주요 Provinsi | 코드 | 타임존 | 주요 도시 |
| ----- | ----- | ----- | ----- |
| DKI Jakarta | JK | WIB | Jakarta Pusat, Selatan, Utara, Barat, Timur |
| Jawa Barat | JB | WIB | Bandung, Bekasi, Bogor, Depok, Cimahi |
| Jawa Tengah | JT | WIB | Semarang, Solo, Magelang, Pekalongan |
| Jawa Timur | JI | WIB | Surabaya, Malang, Sidoarjo, Gresik |
| Sumatera Utara | SU | WIB | Medan, Binjai, Pematangsiantar |
| Bali | BA | WITA | Denpasar, Kuta, Seminyak |
| Sulawesi Selatan | SN | WITA | Makassar, Parepare, Palopo |
| Papua | PA | WIT | Jayapura, Merauke, Timika |

## **▌ B. Claude Code 에이전트 호출 방법**

Claude Code에서 에이전트를 호출하는 세 가지 방법:

| 단일 에이전트 호출   claude \--agent agents/dart-agent.md "Marketplace 상품 등록 화면 구현" |
| :---- |

| 병렬 호출 (동시 작업)   claude \--parallel \\     \--agent agents/dart-agent.md "ProductListScreen 구현" \\     \--agent agents/firestore-agent.md "used\_items 인덱스 최적화" \\     \--agent agents/test-agent.md "ProductRepository 테스트 작성" |
| :---- |

| 체인 호출 (순차 실행)   claude \--chain \\     \--agent agents/architect-agent.md "Jobs 도메인 설계 검토" \\     \--agent agents/dart-agent.md "Jobs 도메인 구현" \\     \--agent agents/test-agent.md "Jobs 테스트 작성" |
| :---- |

## **▌ C. 인도네시아 주요 IDR 가격 참조**

| 서비스 | 가격 (IDR) | 참조 (KRW) |
| ----- | ----- | ----- |
| Mozzy+ 개인 구독 (월) | Rp 29,000 | 약 ₩2,900 |
| Business+ 구독 (월) | Rp 99,000 | 약 ₩9,900 |
| AI 검수 1건 | Rp 5,000 \~ 15,000 | 약 ₩500 \~ 1,500 |
| 뉴스 Boost (기본) | Rp 10,000 | 약 ₩1,000 |
| 구인 프리미엄 (주) | Rp 50,000 | 약 ₩5,000 |
| 동네 히어로 배너 (월/동네) | Rp 2,000,000 | 약 ₩200,000 |
| 부동산 프리미엄 리스팅 (주) | Rp 100,000 \~ 500,000 | 약 ₩10,000 \~ 50,000 |
| Auction 낙찰 수수료 | 낙찰가의 5% | (최대 Rp 500,000) |

| MOZZY (모지) *Hyperlocal Super App — Indonesia* © 2026 Mozzy (모지). All Rights Reserved. *Confidential — Internal Use Only* |
| :---: |

