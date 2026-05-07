# Phase 2 Marketplace Handoff Document

## 1. 개요
Mozzy Indonesia 하이퍼로컬 슈퍼앱의 Marketplace Phase 2 개발이 완료되었습니다. 
이 단계에서는 거래 시스템(COD/Online), 결제 연동(Xendit Sandbox), 실시간 채팅, 푸시 알림 인프라 및 사용자 안전장치가 구현되었습니다.

## 2. 구현 범위 및 기능
- **거래 시스템**:
  - COD(현금결제) MVP: 거래 코드 기반 대면 인도 프로세스
  - Online Payment: Xendit Sandbox 연동 온라인 결제 및 인도 확인 프로세스
- **채팅 인프라**:
  - 거래(Deal) 기반 1:1 채팅방 생성 및 메시지 관리
  - 미확인 메시지 카운트 및 실시간 상태 동기화
- **알림 시스템**:
  - Cloud Functions (v2) 기반 서버측 알림 생성
  - Firebase Cloud Messaging (FCM) 연동 푸시 발송
  - 앱 내 알림 목록 및 딥링크 이동 처리
- **안전 장치**:
  - 사용자 차단 및 신고 기능
  - Firestore Security Rules를 통한 데이터 접근 권한 강화

## 3. 주요 기술 스택
- **Flutter**: Riverpod 3 (상태 관리), GoRouter (내비게이션)
- **Firebase**: Firestore, Cloud Functions (Node.js 20), FCM
- **Payment**: Xendit Sandbox

## 4. 데이터 구조 (Schema)
- `countries/{country}/domains/marketplace/products`: 상품 정보
- `countries/{country}/domains/marketplace/deals`: 거래 이력 및 상태
- `payments`: 결제 트랜잭션 정보 (PAID 여부 등)
- `chat_rooms`: 채팅방 메타데이터 및 참가자 정보
- `notifications`: 앱 내 알림 레코드
- `users/{uid}/fcm_tokens`: 기기별 푸시 토큰 관리
- `users/{uid}/blocked_users`: 사용자별 차단 목록

## 5. 핵심 상태값 (Enums)
- **ProductStatus**: `available`, `reserved`, `sold`, `archived`
- **DealStatus**: `requested`, `payment_pending`, `payment_paid`, `handed_over`, `completed`, `cancelled`
- **PaymentStatus**: `PENDING`, `PAID`, `FAILED`

## 6. 보안 및 운영
- **Security Rules**: 모든 도메인 데이터는 작성자/참가자 외 접근이 원천 차단됩니다.
- **Indexes**: 검색 및 목록 조회를 위한 15개 이상의 복합 인덱스가 적용되었습니다.
- **Error Handling**: Xendit Webhook 유실 및 잘못된 FCM 토큰 처리에 대한 방어 로직이 서버측에 구현되었습니다.

## 7. 남은 이슈 및 제안
- **이미지 메시지**: 현재 텍스트만 가능하며, Phase 3에서 Storage 연동 이미지 메시지 구현 필요.
- **실제 결제**: 현재 Sandbox 환경이며, 운영 배포 시 Secret 설정 및 Webhook 토큰 교체 필요.
- **관리자 도구**: 신고 내역 처리를 위한 백오피스 기능 부재.

## 8. 최종 판정
**상태**: **[ 완료 (Completed) ]**
Phase 2 모든 요구사항이 구현 및 검증되었으며, 안정적인 서비스 제공이 가능한 상태입니다.
