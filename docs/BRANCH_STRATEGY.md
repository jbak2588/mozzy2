# 🌿 Mozzy Branch & CI/CD Strategy

Mozzy Indonesia 프로젝트의 형상 관리 및 배포 전략입니다.

## 1. 브랜치 전략 (Git Flow 기반)

| 브랜치명 | 역할 | 배포 환경 | CI/CD 동작 |
| :--- | :--- | :--- | :--- |
| **`main`** | Production (운영) 환경 배포용 안정화 코드 | PlayStore / AppStore | PR 병합 시 릴리스 빌드 & 배포 |
| **`develop`** | Staging (개발) 환경 통합용 브랜치 | Firebase App Distribution | PR 병합 시 테스트 빌드 & 테스터 배포 |
| **`feature/*`** | 신규 기능 개발 (`feature/login`, `feature/market`) | 로컬 | PR 생성 시 Lint & Test 자동 검사 |
| **`bugfix/*`** | 버그 수정 (`bugfix/chat-crash`) | 로컬 | PR 생성 시 Lint & Test 자동 검사 |
| **`hotfix/*`** | 운영 환경(main) 긴급 버그 수정 | 긴급 배포 | - |

## 2. 병합(Merge) 규칙
* 모든 코드는 `main` 또는 `develop`에 직접 푸시(Push)할 수 없습니다.
* 반드시 `feature/xxx` 브랜치에서 작업 후 **Pull Request (PR)**를 생성해야 합니다.
* PR은 GitHub Actions의 CI 파이프라인(Lint/Test)을 통과해야만 병합할 수 있습니다.

## 3. GitHub Secrets 설정 필요 항목
GitHub 저장소의 `Settings > Secrets and variables > Actions`에 다음 키값들을 등록해야 CI/CD가 정상적으로 운영 환경에 배포됩니다.

* `FIREBASE_ANDROID_APP_ID`: Firebase 안드로이드 앱 ID (`1:149673701591:android:8b8bb2701daf0720348092`)
* `FIREBASE_SERVICE_ACCOUNT_JSON`: Firebase 서비스 계정 JSON 키 (App Distribution 배포용)
* `MIDTRANS_SERVER_KEY`: 결제 연동을 위한 서버 키
* `GEMINI_API_KEY`: AI 연동을 위한 제미나이 API 키
