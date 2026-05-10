# ADR: Smart Feed Ranking Foundation (P5-S01)

## 1. 개요 (Context)
Mozzy는 구인구직, 중고거래, 동네 소식 등 다양한 하이퍼로컬 콘텐츠를 제공합니다. 사용자에게 가장 가치 있는 정보를 우선적으로 노출하기 위해, 도메인별 리스트를 통합하고 점수 기반으로 정렬하는 'Smart Feed' 엔진의 기초를 구축합니다.

## 2. 도입 이유
- **사용자 경험**: 여러 탭을 오가지 않고도 현재 위치에서 가장 중요한 업데이트를 한눈에 확인 가능.
- **수익화 연동**: Phase 4에서 구현된 Job Boost 상품이 실제 피드 상단에 효과적으로 노출될 수 있는 기반 마련.
- **확장성**: 향후 Gemini AI 기반의 개인화 추천으로 진화하기 위한 데이터 구조(FeedItemModel) 및 랭킹 인터페이스 정의.

## 3. 설계 원칙

### A. Rule-based Ranking (Phase 1)
초기 단계에서는 복잡한 머신러닝 모델 대신 예측 가능하고 검증이 쉬운 규칙 기반(Rule-based) 점수 산정 방식을 채택합니다.
- **Boost (100점)**: 유료 결제된 활성 부스트 아이템 우선순위.
- **Freshness (최대 30점)**: 최신 콘텐츠 가산점 (24시간 이내 > 3일 이내 > 7일 이내).
- **Trust (최대 20점)**: AI 검증 완료 또는 신뢰 등급 높은 사용자 콘텐츠 가산점.
- **Distance (최대 20점)**: 동일 Kecamatan(구) > 동일 Kabupaten(시) 순으로 거리 가산점.
- **Engagement**: 조회수, 좋아요, 지원수 등을 가중치로 반영.

### B. Read-side Model (FeedItemModel)
기존 `JobPostModel`, `ProductModel`을 직접 피드에서 사용하지 않고, 공통 인터페이스인 `FeedItemModel`로 매핑하여 사용합니다. 이는 도메인 간 결합도를 낮추고 피드 전용 로직을 분리하기 위함입니다.

### C. Client-side Ranking
데이터량이 초기 단계임을 고려하여, Firestore에서는 최신순으로 일정량(Limit 60)을 가져오고 실제 최종 점수 계산 및 정렬은 클라이언트(RankingService)에서 수행합니다. 이는 서버 비용 절감 및 빠른 로직 수정이 가능하게 합니다.

## 4. 데이터 흐름
1. `SmartFeedRepository`가 Jobs 및 Products 컬렉션에서 데이터를 스트림으로 가져옴.
2. 각 도메인 Mapper를 통해 `FeedItemModel`로 변환.
3. `FeedRankingService`가 현재 사용자 위치 및 시간을 기준으로 점수를 계산.
4. `SmartFeedProvider`가 정렬된 리스트를 UI에 전달.

## 5. 향후 확장 계획
- **AI Ranking**: Gemini API를 사용하여 사용자의 과거 행동 패턴과 피드 콘텐츠 간의 유사도를 점수화(Semantic Ranking).
- **Ads Integration**: 단순 부스트 외에 정교한 타겟팅 광고 슬롯 도입.
- **Geo-fencing**: 사용자가 이동할 때마다 실시간으로 거리 점수를 재계산하는 하이퍼로컬 최적화.

## 6. P5-S02 업데이트 (Home Integration)
- **Home/Beranda 연결**: 기존 `HomeScreen`을 대신하여 `SmartFeedScreen`이 서비스의 기본 홈 화면으로 설정됨. 기존 홈은 `/legacy-home`으로 보존.
- **Widget Test 보강**: `EasyLocalization` 및 `ProviderScope`를 포함한 테스트 헬퍼(`TestLocalizationApp`)를 도입하여 UI 테스트 안정화.
- **안정성 강화**: 피드 구성 요소 중 하나가 실패하더라도 나머지 콘텐츠는 노출되도록 `SmartFeedRepository` 스트림 처리 개선.
- **정렬 안정화**: 점수가 동일할 경우 최신순, ID순으로 정렬되도록 Tie-breaker 로직 강화.

## 7. P5-S03 업데이트 (AI Semantic Ranking Preparation)
- **Semantic Score 도입**: `FeedItemModel`에 `semanticScore`, `semanticReason` 필드를 추가하여 AI 기반의 세만틱 랭킹을 수용할 수 있는 구조 마련.
- **Privacy-Safe Payload**: AI 서버로 전송 전 이메일, 전화번호 등 민감정보를 제거하는 `FeedSemanticSanitizer` 구현.
- **Mock & Skeleton**: 실제 API 호출 전 로컬 검증을 위한 `MockSemanticRankingAdapter` 및 서버 프록시 설계를 위한 `GeminiSemanticRankingAdapter` 스켈레톤 구축.
- **Hybrid Ranking**: 기존 Rule-based 점수(Boost, Distance 등)를 유지하면서 AI 점수를 보조 신호(최대 30점)로 결합하는 하이브리드 체계 수립.

## 8. P5-S03B 업데이트 (Semantic Intent UI Integration)
- **UI Trigger**: 사용자가 명시적으로 검색 의도(Intent)를 입력할 수 있는 `SmartFeedSearchBar` 구현 및 상단 배치.
- **Intent Provider**: `smartFeedSearchIntentProvider`를 통해 입력된 의도를 관리하며, 100자 제한 및 공백 제거 로직 적용.
- **On-demand Ranking**: 검색 의도가 있을 때만 AI 세만틱 랭킹이 트리거되도록 하여 API 비용 및 리소스 최적화.
- **Mock 보강**: 인도네시아어 키워드(loker, jual, beli 등)를 Mock 어댑터에 추가하여 실제 서비스 흐름 검증.

## 9. P5-S04 업데이트 (Gemini Semantic Ranking Proxy)
- **Functions Proxy**: 클라이언트에서 직접 Gemini API를 호출하지 않고, Firebase Cloud Functions (`rankSmartFeedWithGemini`)를 통해 호출하는 보안 구조 확립.
- **Payload Policy**: 서버 측에서 최대 30개 아이템 제한, 금지 필드 필터링, `request.auth` 검증을 수행하여 비용 및 개인정보 유출 방지.
- **Rollout Flag**: `ENABLE_GEMINI_RANKING` 컴파일 플래그를 통해 점진적 배포가 가능하도록 구현.
- **Mock Fallback**: 서버 환경 변수(`AI_MOCK_MODE`)에 따라 Gemini API 대신 결정론적 Mock 로직을 수행할 수 있도록 하여 테스트 및 비용 통제 유연성 확보.

## 10. P5-S04B 업데이트 (Gemini Proxy Staging Hardening)
- **Modular Helpers**: Cloud Functions 로직을 `normalize`, `sanitize`, `parse` 등으로 모듈화하여 유닛 테스트 커버리지를 강화함.
- **Client Hardening**: Flutter 어댑터에서 빈 입력 처리, 30개 아이템 제한, 비정상 응답 처리 및 점수 Clamp(0~30) 로직을 추가하여 안정성을 높임.
- **Privacy Enforcement**: `ownerId`, `email` 등 금지 필드가 페이로드 및 프롬프트에 포함되지 않도록 서버 측 필터링을 강제함.
- **Staging Policy**: `AI_MOCK_MODE`와 `ENABLE_GEMINI_RANKING` 플래그 조합을 통한 단계별 검증 절차 수립.

## 11. P5-S04C 업데이트 (Gemini Live Staging E2E Validation)
- **E2E Validation**: 실제 `gemini-3-flash-preview` API를 사용하여 Staging 환경에서의 Live Mode 동작을 검증함.
- **Latency & Reliability**: 평균 2초 내외의 응답 속도와 예외 발생 시 안전한 Rule-based Fallback을 확인하여 프로덕션 배포 준비를 마침.

## 12. P5-S04E 업데이트 (Gemini Secret Runtime Smoke Test)
- **Secret Manager Integration**: `GEMINI_API_KEY`를 Firebase Secret Manager를 통해 주입하는 구조를 최종 확정하고 Smoke Test를 완료함.
- **Model Standardization**: `gemini-3-flash-preview` 모델을 기본 런타임 모델로 확정함.

## 13. P5-S05 업데이트 (Smart Feed Interaction Logging Foundation)
- **Interaction Logging**: `logFeedInteraction` Cloud Function 및 Flutter 로깅 레이어를 구축하여 `impression`, `card_tap` 등의 기본 신호를 privacy-safe하게 수집하기 시작함.
- **Engagement Signal**: 수집된 데이터는 향후 `engagementScore` 계산 및 개인화 랭킹의 기초 자료로 활용될 예정임.

## 14. P5-S05B 업데이트 (Interaction Logging Contract Hardening)
- **Contract Standardization**: Flutter와 Cloud Functions 간의 통신 규격을 snake_case(`card_tap`, `detail_open` 등)로 통일하고, `FeedInteractionType`의 `wireValue` 프로퍼티를 통해 명시적인 직렬화 체계를 구축함.
- **Privacy Hardening**: `forbiddenMetadataKeys`를 도입하여 클라이언트 측에서 `query`, `email`, `phone`, `userId` 등 민감 정보가 포함된 키를 상호작용 메타데이터에서 제거함.
- **Validation Refactoring**: Cloud Functions의 검증 로직을 `sanitizeFeedInteractionPayload` 등의 독립된 Helper로 분리하고, 70여 개의 테스트 케이스를 통해 비정상적인 데이터(잘못된 이벤트 타입, 위치 범위 초과 등)에 대한 방어 로직을 검증함.
- **Asynchronous Logging**: `unawaited`를 사용하여 로깅 호출이 UI 스레드나 화면 전환을 방해하지 않도록 처리하고, `FirebaseFunctionsException` 처리를 강화하여 로깅 실패가 사용자 경험에 영향을 주지 않도록 함.

## 15. P5-S05C 업데이트 (Interaction Logging Runtime QA & Handoff)
- **Runtime Validation**: Staging 환경(mozzy-v2) 배포 및 Smoke Test를 통해 `card_tap`, `impression` 등의 이벤트가 스키마에 맞춰 정확히 수집됨을 확인하고 P5-S05 계열 작업을 마무리함.
- **Aggregation Readiness**: 상호작용 데이터 수집 레이어가 안정화됨에 따라, 다음 단계인 P5-S06에서 본격적인 데이터 집계 및 랭킹 피드백 루프 구현이 가능해짐.

## 16. P5-S06 업데이트 (Engagement Signal Aggregation)
- **Aggregation Layer**: `feed_interactions`의 raw 로그를 1시간 단위로 집계하여 `feed_engagement_summaries`에 저장하는 Scheduled Cloud Function을 도입함.
- **Rule-based Scoring**: 클릭(2.0), 상세 보기(3.0), 액션(5.0), 노출(0.1) 등의 가중치를 부여하여 콘텐츠의 인기도를 정량화함.
- **Clamp Strategy**: Engagement Score는 최대 30.0점으로 제한하여, 유료 광고(Boost, 100.0)의 효과를 보존하면서도 자연스러운 양질의 콘텐츠가 상단에 노출되도록 설계함.
- **Privacy-Preserving Summary**: 집계 데이터에는 개인 식별 정보(UserId)나 검색어 원문을 포함하지 않아 개인정보 유출 위험을 원천 차단함.

## 17. P5-S06B 업데이트 (Engagement Aggregation Runtime QA & Hardening)
- **Runtime Validation**: Staging 환경에서 `aggregateFeedEngagement` 실행 및 `feed_engagement_summaries` 생성을 검증하고, Smart Feed ranking에 실시간 반영됨을 확인하여 데이터 피드백 루프를 완성함.
- **Contract Hardening**: 필드명(`ctaTapCount`) 통일 및 잘못된 데이터(Missing required fields)에 대한 서버 측 방어 로직을 강화함.
- **Model Integrity**: Flutter `FeedEngagementSummary` 모델을 `abstract`로 선언하여 타입 안정성을 높이고 컴파일 에러를 해결함.
- **Scalability**: RxDart `switchMap`과 `CombineLatestStream`을 활용한 집계 데이터 Watch 구조를 확립하여, 콘텐츠 인기도가 변할 때 피드 순위가 즉각 반영되는 기반을 마련함.

## 18. P5-S06C 업데이트 (Aggregation Finalization & Scheduler Deploy)
- **Scheduler Deployment**: `aggregateFeedEngagement` 스케줄 함수가 Staging 환경(`mozzy-v2`)에 정상 배포 및 등록됨을 확인함.
- **SHA Alignment**: P5-S06B 보고서의 구현 커밋 SHA(`0e25d79`)를 실제 이력과 일치시키고 문서 정합성을 마감함.
- **Ready for Precision**: 대략적인 노출(Approximate Impression) 기반의 집계 파이프라인이 안정화됨에 따라, 향후 정밀 노출(Viewport-based) 및 어뷰징 방지 로직 도입을 위한 준비를 마침.

## 19. P5-S07 업데이트 (Precision Viewport-based Impression Logging)
- **Precision Tracking**: 단순 리스트 렌더링 기준의 노출 수집을 폐기하고, Viewport 상 50% 이상 면적이 800ms 이상 노출된 경우에만 impression을 기록하는 정밀 추적(ViewportImpressionTracker)을 도입함.
- **Dedup Logging**: 한 세션 내에서 동일 아이템이 여러 번 노출되더라도 중복 기록되지 않도록 로컬 dedup 로직 적용.
- **Server Validation**: 노출 기록 시 `impressionMode`, `visibleRatio`, `dwellMs` 메타데이터를 클라이언트에서 전송하고, 서버에서 임계값(Threshold) 검증을 거쳐 어뷰징 및 허수 노출을 방지함.

## 20. P5-S08 업데이트 (Abuse Detection / Anti-gaming Filters)
- **Abuse Detection**: 반복 클릭, 허위 노출, 비정상 세션 패턴을 탐지하는 서버 측 필터를 도입함.
- **Aggregation Protection**: medium/high suspicious 로그는 engagement aggregation에서 제외함.
- **Privacy Preservation**: summary 데이터에는 여전히 userId/sessionId/searchQuery를 저장하지 않음.
