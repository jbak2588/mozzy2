# 🇮🇩 MOZZY INDONESIA - GEMINI CLI MASTER GUIDE

이 문서는 Mozzy Indonesia 프로젝트의 최상위 지침서입니다. Gemini CLI는 모든 작업 수행 시 이 가이드를 엄격히 준수해야 합니다.

## 🎯 프로젝트 컨텍스트 (Context)
Mozzy(모지)는 인도네시아를 Phase 1 핵심 시장으로 하는 하이퍼로컬 슈퍼앱입니다.
- **아키텍처**: 5-Layer Hyperlocal Super App (Local-first, Global-ready)
- **핵심 특징**: Track 1+2 듀얼 지오 체계, Gemini AI 검수, 11개 통합 피처
- **기술 스택**: Flutter 3.27+, Riverpod 3, Firebase, Gemini 3.0, Midtrans

## 🏗️ 아키텍처 원칙 (MANDATORY)

### 1. 5-Layer 모델
- **[1] App Shell**: Navigation, Auth, i18n, Deep Link
- **[2] Discovery Layer**: Smart Feed, Search, Cross-Link, Relay
- **[3] Geo Layer**: GeoScope, SharedMap, LocationService, CountryRegistry
- **[4] Trust Layer**: TrustScore, AI Screening, Moderation
- **[5] Feature Domains**: 11개 독립 도메인 (Shared Contract 준수)

### 2. Shared Contract (필수 구현)
모든 Feature 도메인은 'MozzyPostContract'를 반드시 구현해야 합니다.
`dart
abstract class MozzyPostContract {
  String get id;
  GeoScope get geoScope;       // neighborhood | city | country | global
  ReachMode get reachMode;     // local_only | progressive | global_relay
  Map<String, String> get translationState;
  double get trustScore;       // 0.0 ~ 1.0
  double get signalScore;      // Smart Feed 가중치
}
`

## ⚠️ 절대 금지 및 필수 준수 사항

### 절대 금지 (CRITICAL)
- **NO GetX, NO Provider**: 오직 **Riverpod 3**만 사용합니다.
- **NO Hardcoded Currency**: 모든 통화는 'CurrencyService'를 통해 **IDR (Rp)**로 표시합니다.
- **NO Hardcoded Strings**: 모든 텍스트는 'easy_localization' 키를 사용합니다.
- **NO PII in Plaintext**: NIK 등 개인정보를 Firestore에 평문 저장하지 않습니다 (PDPB 준수).
- **Index Limit**: Firestore 인덱스는 132개 한도를 초과할 수 없습니다.

### 필수 준수 (MUST)
- 인도네시아 주소는 **Track 1 (Provinsi → Kelurahan)**을 우선합니다.
- 모든 기능 개발 시 관련 테스트(Unit/Widget/Integration)를 동시 작성합니다.
- 저사양 기기(RAM 2GB) 최적화를 고려하여 WebP 압축 및 리스트 최적화를 적용합니다.

## 🤖 에이전트 시스템 (Sub-Agents)
특정 도메인 작업 시 'invoke_agent'를 통해 다음 전문 에이전트를 호출하십시오.

- **architect-agent**: 아키텍처 설계 및 레이어 검증
- **dart-agent**: Flutter/Dart UI 및 비즈니스 로직
- **firestore-agent**: DB 스키마 및 인덱스 최적화
- **geo-agent**: 인도네시아 위치/주소 체계 전문
- **ai-agent**: Gemini 3.0 및 ML Kit 연동 전문
- **monetization-agent**: Midtrans 결제 및 수익화 로직 전문
- **test-agent**: 테스트 코드 작성 및 커버리지 관리

## 🚀 개발 로드맵 (8 Phases)
- **Phase 0**: 프로젝트 셋업 & 아키텍처 확립 (현재 단계)
- **Phase 1**: App Shell + Geo Layer 구현
- **Phase 2**: Core 3 Features MVP (News, Market, Chat)
- **Phase 3**: 11개 전 기능 완성
- **Phase 4**: 수익화 시스템 (Payment, Ads)
- **Phase 5**: Smart Feed & AI 연결 전략
- **Phase 6**: 베타 런칭 (자카르타, 반둥)
- **Phase 7**: 성장 및 글로벌 확장 준비
