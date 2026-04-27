# monetization-agent.md — 인도네시아 결제 & 수익화 에이전트

> **역할**: GoPay·OVO·DANA·VA·Alfamart 결제 · 구독 · 광고 8종 · IDR 수익화

---

## 인도네시아 결제 시스템 (Midtrans)

### 지원 결제 수단 우선순위
```
1위: GoPay         (고젝 연동, 인도네시아 최다 사용)
2위: OVO           (그랩 연동)
3위: DANA          (부카라팍 연동)
4위: Virtual Account (BCA, Mandiri, BNI, BRI)
5위: Alfamart/Indomaret (편의점 결제, 농촌 지역)
6위: QRIS          (QR 통합 결제)
7위: 신용카드        (비자/마스터)
```

### Midtrans 연동 구현
```dart
// lib/mozzy_ii/monetization/payment/midtrans_service.dart
class MidtransService {
  static const _serverKey = String.fromEnvironment('MIDTRANS_SERVER_KEY');
  static const _clientKey = String.fromEnvironment('MIDTRANS_CLIENT_KEY');
  static const _isProduction = bool.fromEnvironment('MIDTRANS_PRODUCTION');

  Future<PaymentResult> createTransaction({
    required String orderId,
    required double amountIDR,     // 반드시 IDR
    required PaymentMethod method,
    required UserModel customer,
    required String itemDescription,
  }) async {
    final payload = {
      'transaction_details': {
        'order_id': orderId,
        'gross_amount': amountIDR.toInt(),
      },
      'customer_details': {
        'first_name': customer.displayName,
        'email': customer.email,
        'phone': customer.phoneId, // +62 포맷
      },
      'item_details': [{'name': itemDescription, 'price': amountIDR.toInt(), 'quantity': 1}],
      'payment_type': _paymentTypeCode(method),
      // GoPay 딥링크 (고젝 앱 연동)
      if (method == PaymentMethod.gopay)
        'gopay': {'enable_callback': true, 'callback_url': 'mozzy://payment/callback'},
    };

    final response = await _dio.post('/v2/charge', data: payload);
    return PaymentResult.fromMidtrans(response.data);
  }

  // 인도네시아 결제 수수료 정책
  double calculateFee(double amount, PaymentMethod method) {
    return switch (method) {
      PaymentMethod.gopay        => amount * 0.02,        // 2%
      PaymentMethod.ovo          => amount * 0.02,        // 2%
      PaymentMethod.dana         => amount * 0.02,        // 2%
      PaymentMethod.virtualAccount => 4000,               // Rp 4,000 고정
      PaymentMethod.alfamart      => 2500,                // Rp 2,500 고정
      PaymentMethod.creditCard    => amount * 0.029,      // 2.9%
    };
  }
}
```

---

## IDR 가격 정책 (인도네시아 현지화)

### 한국 원화 → IDR 변환 기준
```
₩1,000  → Rp 10,000~12,000 (환율 기준)
₩2,000  → Rp 20,000
₩5,000  → Rp 50,000
₩10,000 → Rp 100,000
₩50,000 → Rp 500,000~600,000
```

### Feature별 IDR 수익 설계
```
Local News
  - Boost: Rp 10,000 ~ Rp 150,000/게시글
  - 비즈니스 공지 고정: Rp 50,000/주

Marketplace
  - AI 검수: Rp 5,000 ~ Rp 15,000/건
  - 프리미엄 리스팅: Rp 15,000 ~ Rp 75,000/일
  - 거래 수수료: 택배 거래 2~5%

Jobs
  - 구인 Boost: Rp 25,000 ~ Rp 100,000
  - 프리미엄 포지션: Rp 50,000/주

Auction
  - 낙찰 수수료: 낙찰가의 5% (최대 Rp 500,000)

Local Stores
  - Business+ 구독: Rp 99,000/월
  - 지도 핀 프리미엄: Rp 50,000/월
  - 동네 히어로 배너: Rp 2,000,000/월/동네

Mozzy+ 구독
  - 개인: Rp 29,000/월 (연간: Rp 290,000)
  - Business+: Rp 99,000/월 (연간: Rp 990,000)
```

---

## 광고 Placeholder 8종 구현

```dart
// lib/mozzy_ii/monetization/ad_campaign/ad_placeholder_service.dart

enum AdPlaceholder {
  A,  // Local News 피드 인라인
  B,  // 리스트 상단 배너 (Jobs·Marketplace)
  C,  // 상세 화면 추천 광고
  D,  // POM 풀스크린 Interstitial
  E,  // 동네 히어로 배너 (Neighborhood Identity)
  F,  // 지도 오버레이 스폰서
  G,  // Chat 맥락 추천
  H,  // 지도 핀 프리미엄
}

class AdPlaceholderWidget extends StatelessWidget {
  final AdPlaceholder type;
  final String locationKey; // 인도네시아 kecamatan 단위 타겟팅

  Widget build(BuildContext context) {
    // 광고 없을 때: 투명 (높이 0) — UX 해치지 않음
    // 광고 있을 때: 해당 형식 렌더링
  }
}
```

---

## Mozzy Wallet (인도네시아 e-Wallet)

```dart
// lib/mozzy_ii/monetization/wallet/mozzy_wallet_service.dart
class MozzyWalletService {
  // 인도네시아 e-Money 규제 (OJK 준수)
  static const double maxBalance = 20000000; // Rp 20,000,000 (OJK 상한)
  static const double maxMonthlyTransaction = 40000000; // Rp 40,000,000

  Future<WalletModel> topUp({
    required double amountIDR,
    required PaymentMethod method,
  }) async { ... }

  Future<void> withdraw({
    required double amountIDR,
    required BankAccount destination,
  }) async {
    // OJK 규제: KYC 완료 사용자만 출금 가능
    await _verifyKyc(userId);
    ...
  }
}
```
