# Gemini Semantic Ranking Staging Setup Guide

이 문서는 Mozzy Smart Feed의 AI Semantic Ranking 기능을 Staging 환경에서 안전하게 배포하고 검증하기 위한 가이드를 제공합니다.

## 1. 목적
- 클라이언트-서버 간의 Gemini 프록시 통신 검증
- AI_MOCK_MODE를 통한 비용 통제 상태에서의 로직 확인
- 실제 Gemini API Key 적용 후 Live Mode 동작 확인 및 Fallback 안정성 검증

## 2. 필요한 환경 변수 / Secret (Server-side)

Firebase Cloud Functions (functions-v2) 배포 시 아래 설정을 적용해야 합니다.

| 변수명 | 설명 | 권장 값 (Staging) |
| :--- | :--- | :--- |
| `GEMINI_API_KEY` | Google AI Studio에서 발급받은 API Key | (Secret Manager 사용 권장) |
| `AI_MOCK_MODE` | true인 경우 실제 API 호출 대신 내부 Mock 로직 사용 | `true` (초기 검증) |

> [!CAUTION]
> API Key 값을 코드나 일반 문서에 평문으로 기록하지 마십시오. Firebase Secret Manager(`firebase functions:secrets:set`)를 사용하십시오.

## 3. Flutter Build Flag (Client-side)

피드 랭킹 어댑터 활성화를 위해 빌드 시 아래 플래그를 주입해야 합니다.

```bash
flutter run --dart-define=ENABLE_GEMINI_RANKING=true
# 또는 빌드 시
flutter build apk --dart-define=ENABLE_GEMINI_RANKING=true
```

## 4. 권장 Staging 검증 순서

### Step 1: Mock Mode 검증
1. Cloud Functions에 `AI_MOCK_MODE=true` 설정.
2. 앱을 `ENABLE_GEMINI_RANKING=true`로 실행.
3. Smart Feed 검색창에 'loker' 또는 'jual' 입력.
4. 로그(`rankSmartFeedWithGemini` 호출) 확인 및 `provider: gemini, mode: mock` 응답 확인.
5. 관련 도메인 아이템이 상단으로 이동하는지 확인.

### Step 2: Live Mode 검증 (API Key 설정)
1. `GEMINI_API_KEY`를 Secret으로 설정.
   ```bash
   firebase functions:secrets:set GEMINI_API_KEY --project mozzy-v2
   ```
2. `GEMINI_MODEL` 설정 (선택 사항).
   - 기본값: `gemini-3-flash-preview`
   - 모델 변경이 필요한 경우, Cloud Functions의 런타임 환경 변수로 `GEMINI_MODEL`을 주입하거나 `.env` 파일에 정의하십시오.
   - 예: `GEMINI_MODEL=gemini-1.5-pro`
3. Cloud Functions에 `AI_MOCK_MODE=false` 설정 후 재배포.
4. 앱에서 검색 의도 입력.
5. `mode: live` 응답 및 Gemini가 생성한 `reason`이 로그에 찍히는지 확인.

### Step 3: Fallback 검증
1. API Key를 일시적으로 무효화하거나 네트워크 연결을 끊음.
2. 앱에서 검색 시 Crash 없이 Rule-based 랭킹으로 결과가 나오는지 확인.

## 5. 로그 확인 및 모니터링
- **Firebase Functions Logs**: Payload 크기, Gemini 응답 시간, 파싱 에러 여부 모니터링.
- **Privacy Check**: 전송되는 `items` 배열에 PII(이메일, 전화번호 등)가 포함되어 있지 않은지 샘플링 검사.

## 7. E2E 검증 결과 (P5-S04C)
- **Mock Mode**: 'loker', 'jual' 등 키워드에 따른 도메인 부스팅 정상 작동 확인.
- **Live Mode**: `gemini-3-flash-preview` 실호출 및 응답 파싱(JSON) 확인 완료.
- **Fallback**: 네트워크 장애나 API 에러 시 Rule-based로 자동 전환됨을 확인.

## 8. Production Rollout 전 체크리스트
- [ ] `GEMINI_API_KEY`가 운영용 Firebase 프로젝트 Secret에 등록되었는가?
- [ ] 운영 환경의 `AI_MOCK_MODE`가 `false`로 설정되었는가?
- [ ] 운영 빌드 스크립트에 `--dart-define=ENABLE_GEMINI_RANKING=true`가 포함되었는가?
- [ ] Google AI Studio 또는 Google Cloud Console에서 할당량(Quota) 및 비용 한도를 설정했는가?
- [ ] 사용할 모델명이 `gemini-3-flash-preview`로 정확히 설정되었는가?
