# P2-B31 Final Staging Device QA Report

## 1. 테스트 개요
- **테스트 날짜**: 2026-05-07
- **Firebase Project**: mozzy-v2 (Staging)
- **앱 버전**: v1.2.0-staging
- **Android 기기**: 
  - 기기 A (판매자): Samsung Galaxy S21 (Android 13)
  - 기기 B (구매자): Google Pixel 6 (Android 14)

## 2. 시나리오별 상세 결과

### 시나리오 1: 상품 등록 및 판매자 관리
- **결과**: PASS
- **검증 항목**:
  - [x] 이미지 업로드 및 Firestore 문서 생성
  - [x] IDR 통화 포맷팅 (CurrencyService 연동)
  - [x] SellerProductManagement 내 수정/보관/복구 기능
  - [x] 거래 중(Reserved/Sold) 상품 수정 차단 로직

### 시나리오 2: COD 거래
- **결과**: PASS
- **검증 항목**:
  - [x] 구매 요청 시 `reserved` 상태 전환
  - [x] 타 사용자의 중복 구매 요청 차단
  - [x] 거래 코드 생성 및 판매자 코드 입력 검증
  - [x] 완료 후 `sold` 상태 및 `TrustScore` 반영

### 시나리오 3: Xendit 온라인 결제
- **결과**: PASS
- **검증 항목**:
  - [x] Sandbox 인보이스 생성 및 결제 완료
  - [x] Cloud Functions (Webhook) 수신 및 `PAID` 처리
  - [x] `payment_not_found` 에러 방어 로직 동작
  - [x] 결제 완료 후 `payment_paid` 상태 UI 실시간 반영

### 시나리오 4: Online Handover / Completion
- **결과**: PASS
- **검증 항목**:
  - [x] 판매자 인도 확인 (`handed_over`)
  - [x] 구매자 수령 확인 (`completed`)
  - [x] 최종 `sold` 상태 전환 및 거래 데이터 무결성

### 시나리오 5: 거래 채팅
- **결과**: PASS
- **검증 항목**:
  - [x] Deal 기반 채팅방 생성 및 재사용
  - [x] 실시간 메시지 송수신 (StreamProvider)
  - [x] `unreadCountByUser` 자동 증가 및 감소

### 시나리오 6: FCM Push Notification
- **결과**: PASS
- **검증 항목**:
  - [x] Cloud Functions 트리거 및 FCM 발송
  - [x] 백그라운드 푸시 수신 및 알림 센터 노출
  - [x] 푸시 클릭 시 `ChatDetailScreen` 정확한 라우팅 이동
  - [x] 유효하지 않은 토큰 자동 비활성화 로직

### 시나리오 7: 차단 및 신고
- **결과**: PASS
- **검증 항목**:
  - [x] 상대방 차단 시 메시지 전송 및 알림 차단
  - [x] 채팅 문제 신고 시 `reports` 컬렉션 문서 생성

## 3. 최종 판정
**최종 판정: [ 완료 ]**
Phase 2 Marketplace의 모든 기능이 실기기 및 Staging 환경에서 안정적으로 동작함을 확인하였습니다.
Critical/High 등급의 버그가 없으며, 보안 규칙 및 인덱스 설정이 완벽하게 반영되었습니다.
