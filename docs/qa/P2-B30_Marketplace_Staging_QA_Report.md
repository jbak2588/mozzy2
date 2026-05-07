# P2-B30 Marketplace Staging QA Report

## 1. 개요
- **테스트 날짜**: 2026-05-07
- **테스트 환경**: Firebase Staging
- **테스트 기기**: Android 실기기 (Seller/Buyer 2계정)
- **빌드 버전**: v1.2.0-staging

## 2. 테스트 시나리오 결과

| 시나리오 | 항목 | 결과 | 비고 |
| :--- | :--- | :---: | :--- |
| **상품 등록/관리** | 상품 등록 및 이미지 업로드 | PASS | |
| | IDR 통화 포맷 확인 | PASS | Rp prefix 정상 표시 |
| | Seller Management (수정/보관/복구) | PASS | available 상태에서만 수정 가능 확인 |
| **COD 거래** | reserved 처리 및 중복 구매 차단 | PASS | |
| | 거래 코드 확인 및 완료 | PASS | product.status -> sold 전환 확인 |
| **Xendit 결제** | 온라인 결제 인보이스 생성 | PASS | Sandbox URL 정상 오픈 |
| | Webhook 처리 및 PAID 반영 | PASS | payments/deal 상태 실시간 업데이트 |
| **Online Handover** | 판매자 인도 확인 | PASS | handed_over 상태 전환 |
| | 구매자 수령 확인 및 완료 | PASS | product.status -> sold 전환 확인 |
| **채팅** | 실시간 메시지 송수신 | PASS | 1:1 채팅 정상 동작 |
| | unreadCountByUser 관리 | PASS | 채팅방 진입 시 초기화 확인 |
| **FCM Push** | 백그라운드 Push 수신 | PASS | onChatMessageCreated 트리거 확인 |
| | Push 클릭 시 채팅방 이동 | PASS | NotificationNavigationService 동작 확인 |
| **차단/신고** | 사용자 차단 및 메시지 거부 | PASS | blocked_users status 체크 로직 확인 |
| | 상품/사용자 신고 | PASS | reports 문서 생성 확인 |

## 3. 기술 검증 내역
- [x] **Firebase Functions**: 배포 완료 및 트리거 동작 확인
- [x] **Firestore Rules**: 권한 관리 검증 (본인 외 접근 차단)
- [x] **Firestore Indexes**: 필수 복합 인덱스 추가 완료
- [x] **i18n**: raw key 노출 없음 (easy_localization 적용)
- [x] **Analyze/Test**: `flutter analyze` 0 errors, unit test PASS

## 4. 발견된 이슈 및 수정
- **NotificationModel/FcmTokenModel**: 빌드 러너 환경 이슈로 인해 `freezed` 대신 수동 구현으로 전환하여 안정성 확보.
- **ChatDetailScreen Import**: 누락된 `chat_provider` 임포트 복구 완료.

## 5. 최종 판정
**Phase 2 Marketplace: [ 완료 ]**
- 모든 핵심 시나리오(COD, Xendit, Handover, Chat, Push)가 staging 환경에서 정상 동작함을 확인하였음.
- 실기기 QA 기준을 모두 만족하여 Phase 3로의 이행을 권고함.
