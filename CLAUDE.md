# CLAUDE.md — Mozzy Indonesia (모지 인도네시아) 프로젝트 마스터 지시서

> **Project Codename**: `mozzy-id`
> **Target Market**: 🇮🇩 인도네시아 (Phase 1 핵심 시장)
> **Stack**: Flutter (Dart) · Firebase · Riverpod 3 · Gemini 3.0 · ML Kit
> **Architecture**: 5-Layer Hyperlocal Super App (Local-first, Global-ready)
> **Last Updated**: 2026-04-26

---

## 🎯 프로젝트 컨텍스트

Mozzy(모지)는 인도네시아를 **Phase 1 핵심 시장**으로 하는 하이퍼로컬 슈퍼앱이다.
인도네시아는 유일하게 **Track 1+2 듀얼 트랙** — 자국 행정 주소 체계
(Provinsi → Kabupaten → Kecamatan → Kelurahan)와 글로벌 표준(L1-L2-L3)을 동시 지원한다.

이 프로젝트는 창업자(기획자+개발자)의 관점에서 **MVP → 수익화 → 글로벌 확장**의
전 사이클을 Claude Code 멀티 에이전트 팀으로 구현한다.

### 인도네시아 시장 특수 요건
- **인구**: 2억 7천만 명, 17,000개 섬, 514개 행정구역 (Kabupaten/Kota)
- **주요 도시**: 자카르타(수도권 3천만), 수라바야, 반둥, 메단, 세마랑
- **언어**: Bahasa Indonesia (id) 필수, Javanese, Sundanese 지역 지원
- **결제**: GoPay, OVO, DANA, Bank Transfer (VA), Alfamart/Indomaret 지불
- **법규**: OJK(금융), Kominfo(데이터), PDPB(개인정보보호법), Halal 거래 고려
- **경쟁사**: Tokopedia, Shopee (커머스), Gojek (슈퍼앱), Kaskus (커뮤니티), OLX (중고거래)
- **인프라**: 평균 LTE 속도 20Mbps, 오프라인 지역 대비 경량 모드 필요

---

## 🏗️ 아키텍처 원칙 (MANDATORY — 절대 위반 금지)

### 5-Layer 모델
```
[1] App Shell        → Navigation · Theme · Auth · i18n · Deep Link
[2] Discovery Layer  → Smart Feed · Search · Cross-Link · Relay
[3] Geo Layer        → GeoScope · SharedMap · LocationService · CountryRegistry
[4] Trust Layer      → TrustScore · AI Screening · Community Moderation
[5] Feature Domains  → 11개 독립 도메인 (각 도메인은 shared contract 준수)
```

### Shared Contract (모든 Feature가 반드시 구현)
```dart
// lib/shared/contracts/post_contract.dart
abstract class MozzyPostContract {
  String get id;
  GeoScope get geoScope;       // neighborhood | city | country | global
  ReachMode get reachMode;     // local_only | progressive | global_relay
  Map<String, String> get translationState;
  double get trustScore;       // 0.0 ~ 1.0
  double get signalScore;      // Smart Feed 가중치
  List<String> get relayTargets;
  bool get mapVisibility;
  List<String> get discoveryChannels; // feed | map | search | relay
}
```

### 인도네시아 전용 Geo 계층
```dart
// Track 1: 인도네시아 레거시 주소
class IndonesiaGeoAddress {
  String provinsi;     // 예: "Jawa Barat"
  String kabupaten;    // 예: "Kota Bandung"
  String kecamatan;    // 예: "Coblong"
  String kelurahan;    // 예: "Lebak Siliwangi"
}

// Track 2: 글로벌 표준 (병행 유지)
class GlobalGeoAddress {
  String l1; // Province
  String l2; // City/Regency
  String l3; // District
}
```

---

## 🤖 에이전트 팀 구성 (Claude Code Sub-Agents)

이 프로젝트는 **13개 전문 에이전트**가 역할 분담하여 병렬 작업한다.
각 에이전트는 `agents/` 폴더의 해당 `.md` 파일을 읽고 역할을 수행한다.

### 코드 에이전트 (5명)
| Agent | 파일 | 핵심 책임 |
|-------|------|----------|
| `architect` | `agents/architect-agent.md` | 레이어 경계 · Shared Contract 수호자 |
| `dart` | `agents/dart-agent.md` | Flutter/Dart · Riverpod 3 코드 생성 |
| `firestore` | `agents/firestore-agent.md` | 스키마 · 132 인덱스 · 쿼리 최적화 |
| `test` | `agents/test-agent.md` | 1,033+ 테스트 · 30% 커버리지 달성 |
| `i18n` | `agents/i18n-agent.md` | Bahasa Indonesia + 25개 언어 동기화 |

### 분석 에이전트 (3명)
| Agent | 파일 | 핵심 책임 |
|-------|------|----------|
| `review` | `agents/review-agent.md` | PR 리뷰 · 코드 품질 |
| `perf` | `agents/perf-agent.md` | 성능 · 인도네시아 저사양 기기 최적화 |
| `security` | `agents/security-agent.md` | 보안 · Firestore Rules · PDPB 준수 |

### 도메인 에이전트 (3명)
| Agent | 파일 | 핵심 책임 |
|-------|------|----------|
| `geo` | `agents/geo-agent.md` | 인도네시아 Track 1+2 · CountryRegistry |
| `ai` | `agents/ai-agent.md` | Gemini 3.0 · ML Kit · AI 서비스 |
| `monetization` | `agents/monetization-agent.md` | GoPay/OVO/DANA · 구독 · 광고 |

### 운영 에이전트 (2명)
| Agent | 파일 | 핵심 책임 |
|-------|------|----------|
| `deploy` | `agents/deploy-agent.md` | CI/CD · PlayStore/AppStore · Firebase |
| `market` | `agents/market-agent.md` | 인도네시아 현지화 · 경쟁사 분석 · KPI |

---

## 📁 프로젝트 폴더 구조 (목표)

```
mozzy_indonesia/
├── CLAUDE.md                    ← 이 파일 (마스터 지시서)
├── CHECKLIST.md                 ← 단계별 체크리스트
├── agents/                      ← 에이전트별 지시서
│   ├── architect-agent.md
│   ├── dart-agent.md
│   ├── firestore-agent.md
│   ├── test-agent.md
│   ├── i18n-agent.md
│   ├── review-agent.md
│   ├── perf-agent.md
│   ├── security-agent.md
│   ├── geo-agent.md
│   ├── ai-agent.md
│   ├── monetization-agent.md
│   ├── deploy-agent.md
│   └── market-agent.md
├── docs/
│   ├── indonesia-market.md      ← 인도네시아 시장 분석
│   ├── geo-address-id.md        ← 행정구역 데이터 가이드
│   ├── payment-id.md            ← 인도네시아 결제 시스템
│   ├── legal-id.md              ← 현지 법규 요건
│   └── competitor-analysis.md  ← 경쟁사 분석
├── scripts/
│   ├── setup.sh                 ← 개발환경 셋업
│   ├── gen-l10n.sh              ← i18n 생성
│   └── deploy-id.sh             ← 인도네시아 배포
└── lib/                         ← Flutter 앱 소스 (목표 구조)
    └── mozzy_ii/
        ├── app/
        ├── core/
        ├── design_system/
        ├── shared/contracts/
        ├── domains/             ← 11개 Feature
        ├── discovery/
        ├── geo/
        ├── trust/
        ├── monetization/
        └── growth/
```

---

## 🚀 개발 Phase 계획 (인도네시아 MVP → 런칭)

| Phase | 기간 | 목표 | 담당 에이전트 |
|-------|------|------|-------------|
| **Phase 0** | Week 1-2 | 프로젝트 셋업 · 아키텍처 확립 | architect, dart, firestore |
| **Phase 1** | Week 3-6 | App Shell + Geo Layer (Track 1+2) | geo, dart, i18n |
| **Phase 2** | Week 7-10 | Core Features MVP (News + Marketplace + Chat) | dart, firestore, test |
| **Phase 3** | Week 11-14 | Full 11 Features + Trust Layer | dart, ai, security |
| **Phase 4** | Week 15-18 | Monetization (GoPay/OVO + Ads) | monetization, deploy |
| **Phase 5** | Week 19-22 | Smart Feed + Cross-Feature 전략 | ai, dart, perf |
| **Phase 6** | Week 23-26 | 베타 런칭 (자카르타/반둥) | deploy, market |
| **Phase 7** | Week 27+ | Growth + Global Relay 준비 | market, ai, deploy |

---

## 🛠️ 기술 스택 (LOCKED — 임의 변경 금지)

```yaml
Framework:     Flutter 3.27+ (Dart 3.6+)
State:         Riverpod 3 (NO GetX, NO Provider)
Backend:       Firebase (Firestore + Auth + Storage + Functions + FCM)
AI:            Google Gemini 3.0 (gemini-2.0-flash-exp)
Translation:   Google ML Kit Translation (on-device)
Map:           Google Maps Flutter + Geolocator
Payment_ID:    Midtrans (GoPay·OVO·DANA·VA·Alfamart)
Analytics:     Firebase Analytics + Crashlytics
i18n:          easy_localization 3.x
HTTP:          Dio + Retrofit
Testing:       flutter_test · mockito · integration_test
CI/CD:         GitHub Actions → Firebase App Distribution → PlayStore/AppStore
```

---

## ⚠️ CRITICAL RULES (Claude Code 전 에이전트 준수)

### 절대 금지 (DO NOT)
1. ❌ `GetX` 또는 `Provider` import 절대 금지 → **Riverpod 3만 사용**
2. ❌ Firestore 인덱스 132개 초과 금지 → 인덱스 추가 시 `firestore-agent` 승인 필수
3. ❌ Shared Contract 없이 Feature 도메인 직접 참조 금지 (레이어 위반)
4. ❌ 인도네시아 결제 시스템에 Stripe 직접 사용 금지 → **Midtrans 필수**
5. ❌ 하드코딩된 통화(IDR/₩) 금지 → **CurrencyService 경유 필수**
6. ❌ 한국어 하드코딩 금지 → **easy_localization 키만 사용**
7. ❌ 개인 식별 정보(NIK 등) Firestore 평문 저장 금지 → PDPB 준수

### 필수 준수 (MUST DO)
1. ✅ 모든 Feature는 `MozzyPostContract` 구현
2. ✅ 인도네시아 주소는 Track 1 (Provinsi→Kelurahan) 우선 표시
3. ✅ 모든 금액은 IDR (Indonesian Rupiah, Rp) 기본 표시
4. ✅ AI 요청마다 rate limiting 적용 (`RateLimiter` 클래스 사용)
5. ✅ Firestore 쿼리는 커서 페이지네이션 사용 (`startAfterDocument`)
6. ✅ 이미지 업로드 전 압축 (max 1MB, WebP 변환 권장)
7. ✅ 오프라인 모드 대비 Hive 로컬 캐시 구현
8. ✅ 모든 사용자 입력 검증은 `ValidationService` 경유

---

## 📊 인도네시아 KPI 목표

| 지표 | 3개월 (베타) | 6개월 | 12개월 |
|------|------------|-------|-------|
| DAU | 5,000 | 25,000 | 100,000 |
| 등록 도시 | 자카르타·반둥 | +수라바야·메단 | 10대 도시 |
| D7 리텐션 | 25% | 30% | 35% |
| MRR (IDR) | Rp 25M | Rp 150M | Rp 750M |
| Mozzy+ 구독자 | 500 | 3,000 | 15,000 |
| App Rating | 4.0+ | 4.2+ | 4.5+ |

---

## 🔄 에이전트 협업 워크플로우

```
1. 기능 요청 → architect-agent가 레이어 경계 검토
2. architect 승인 → dart-agent가 코드 생성
3. dart 완료 → test-agent가 테스트 작성
4. test 통과 → review-agent가 PR 리뷰
5. review 승인 → deploy-agent가 스테이징 배포
6. 인도네시아 특화 작업:
   - 주소/위치 → geo-agent 개입
   - AI 기능 → ai-agent 개입
   - 결제 → monetization-agent 개입
   - 번역/현지화 → i18n-agent 개입
   - 성능이슈 → perf-agent 개입
   - 보안 → security-agent 개입
```

---

## 📝 에이전트 호출 방법

Claude Code에서 서브 에이전트를 호출할 때:

```bash
# 특정 에이전트에게 작업 위임
claude --agent agents/dart-agent.md "Marketplace 상품 등록 화면 구현"

# 병렬 작업 (여러 에이전트 동시)
claude --parallel \
  --agent agents/dart-agent.md "ProductListScreen 구현" \
  --agent agents/firestore-agent.md "used_items 인덱스 최적화" \
  --agent agents/test-agent.md "ProductRepository 테스트 작성"

# 에이전트 체인 (순차 실행)
claude --chain \
  --agent agents/architect-agent.md "Jobs 도메인 설계 검토" \
  --agent agents/dart-agent.md "Jobs 도메인 구현" \
  --agent agents/test-agent.md "Jobs 테스트 작성"
```

---

*이 파일은 Mozzy Indonesia 프로젝트의 헌법이다. 모든 에이전트는 작업 시작 전 반드시 이 파일을 읽어야 한다.*
