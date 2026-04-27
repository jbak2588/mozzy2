# ai-agent.md — AI 서비스 에이전트 (Gemini 3.0 · ML Kit)

> **역할**: Gemini 3.0 연동 · ML Kit 온디바이스 번역 · AI 검수 · 매칭 · Smart Feed

---

## AI 서비스 아키텍처

```
온디바이스 (ML Kit)          서버사이드 (Gemini 3.0 via Cloud Function)
─────────────────────        ──────────────────────────────────────────
번역 (id↔ko↔en)             Marketplace AI 검수 (이미지 분석)
OCR (KTP 인식)               Lost & Found AI 매칭 (유사도)
얼굴 감지 (프로필)            Jobs AI 매칭 (구직자-구인)
텍스트 인식                   Smart Feed 신호점수 계산
바코드 스캔                   NudgeEngine (행동 기반 넛지)
```

---

## Gemini 3.0 AI 검수 시스템

### Marketplace 물품 검수 (인도네시아 특화)
```dart
// lib/mozzy_ii/domains/marketplace/domain/services/marketplace_ai_service.dart
class MarketplaceAiService {
  final RateLimiter _rateLimiter = RateLimiter(maxPerMinute: 10);

  Future<AiVerificationResult> verifyProduct({
    required List<String> imageUrls,
    required String category,
    required double listedPrice,
    required String descriptionId, // 바하사 인도네시아
  }) async {
    await _rateLimiter.acquire();

    final prompt = '''
Analisis produk bekas berikut untuk pasar Indonesia:
- Kategori: $category
- Harga terdaftar: Rp ${listedPrice.toStringAsFixed(0)}
- Deskripsi: $descriptionId

Berikan penilaian dalam format JSON:
{
  "condition": "S|A|B|C|D",
  "conditionDesc": "Deskripsi kondisi dalam Bahasa Indonesia",
  "estimatedPrice": { "min": 0, "max": 0, "currency": "IDR" },
  "isAuthentic": true,
  "issues": [],
  "recommendation": "Layak dijual / Perlu perbaikan deskripsi / Tidak layak"
}
''';

    final response = await _geminiService.analyzeWithImages(
      prompt: prompt,
      imageUrls: imageUrls,
      model: 'gemini-2.0-flash-exp',
    );

    return AiVerificationResult.fromJson(jsonDecode(response));
  }
}
```

### Lost & Found AI 매칭 (인도네시아)
```dart
class LostFoundAiService {
  Future<double> calculateMatchScore({
    required LostFoundModel lostItem,
    required LostFoundModel foundItem,
  }) async {
    // 1. 위치 교차 확인 (kecamatan 단위)
    final locationMatch = lostItem.locationParts.kecamatan ==
                          foundItem.locationParts.kecamatan;
    if (!locationMatch) return 0.0;

    // 2. 시간 교차 확인 (분실 시간 ≤ 습득 시간)
    final timeValid = foundItem.createdAt.isAfter(lostItem.lostAt);
    if (!timeValid) return 0.0;

    // 3. Gemini 이미지 유사도 분석
    final prompt = '''
Bandingkan dua foto barang hilang/ditemukan berikut.
Berikan skor kesamaan antara 0.0 - 1.0 dalam format JSON:
{ "similarityScore": 0.85, "matchingFeatures": ["warna", "bentuk"] }
''';
    final result = await _geminiService.compareImages(
      image1Url: lostItem.imageUrl,
      image2Url: foundItem.imageUrl,
      prompt: prompt,
    );
    return result['similarityScore'] as double;
  }
}
```

---

## ML Kit 온디바이스 번역 (인도네시아 특화)

```dart
// lib/mozzy_ii/shared/translation/mlkit_translation_service.dart
class MlKitTranslationService {
  // 인도네시아 우선 언어 모델 다운로드
  static const priorityLanguages = [
    TranslateLanguage.indonesian,  // id - 필수
    TranslateLanguage.english,     // en - 필수
    TranslateLanguage.korean,      // ko
    TranslateLanguage.javanese,    // jv - 자바어 (인도네시아)
  ];

  Future<String> translate({
    required String text,
    required String sourceLang,
    required String targetLang,
  }) async {
    final translator = OnDeviceTranslator(
      sourceLanguage: BcpLanguage.fromCode(sourceLang),
      targetLanguage: BcpLanguage.fromCode(targetLang),
    );
    final result = await translator.translateText(text);
    await translator.close();
    return result;
  }

  // 인도네시아어 자동 감지
  Future<String> detectLanguage(String text) async {
    final identifier = LanguageIdentifier(confidenceThreshold: 0.5);
    final result = await identifier.identifyLanguage(text);
    return result; // 'id', 'jv', 'su', 'en' 등
  }
}
```

---

## NudgeEngine (인도네시아 행동 기반 알림)

```dart
// lib/mozzy_ii/growth/nudge/nudge_engine.dart
class NudgeEngine {
  Future<void> evaluateAndNudge({
    required String userId,
    required UserAction action,
    required LocationParts userLocation,
  }) async {
    final nudge = switch (action.type) {
      // Marketplace에서 produk bayi 검색
      ActionType.marketplaceSearch when action.query.contains('bayi') ||
        action.query.contains('baby') =>
          NudgeMessage(
            titleId: 'Bergabung dengan Komunitas Ibu & Bayi di ${userLocation.kecamatan}!',
            targetFeature: 'together',
            targetFilter: 'ibu_bayi',
          ),

      // Jobs에서 restoran 지원
      ActionType.jobApply when action.category == 'restoran' =>
          NudgeMessage(
            titleId: 'Lihat ulasan restoran ini di Mozzy Stores!',
            targetFeature: 'local_stores',
            targetId: action.linkedShopId,
          ),

      // POM에서 kuliner 영상 시청
      ActionType.pomWatch when action.tags.contains('kuliner') =>
          NudgeMessage(
            titleId: 'Menu lengkap tersedia di halaman toko!',
            targetFeature: 'local_stores',
          ),

      _ => null,
    };

    if (nudge != null) await _fcmService.sendNudge(userId, nudge);
  }
}
```

---

## Rate Limiting (필수 — 비용 관리)

```dart
// lib/mozzy_ii/core/utils/rate_limiter.dart
class RateLimiter {
  final int maxPerMinute;
  final Queue<DateTime> _requests = Queue();

  RateLimiter({this.maxPerMinute = 10});

  Future<void> acquire() async {
    final now = DateTime.now();
    _requests.removeWhere((t) => now.difference(t).inMinutes >= 1);

    if (_requests.length >= maxPerMinute) {
      final wait = 60 - now.difference(_requests.first).inSeconds;
      await Future.delayed(Duration(seconds: wait));
    }
    _requests.add(DateTime.now());
  }
}

// 각 AI 서비스별 한도 설정
final marketplaceAiLimiter = RateLimiter(maxPerMinute: 10);  // Gemini 비용 관리
final lostFoundAiLimiter   = RateLimiter(maxPerMinute: 5);
final jobsAiLimiter        = RateLimiter(maxPerMinute: 8);
final translationLimiter   = RateLimiter(maxPerMinute: 50);  // ML Kit 온디바이스라 여유
```
