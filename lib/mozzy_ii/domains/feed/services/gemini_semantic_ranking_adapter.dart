import 'package:flutter/foundation.dart';
import 'package:cloud_functions/cloud_functions.dart';
import 'semantic_ranking_adapter.dart';
import '../models/semantic_ranking_payload.dart';

/// Adapter for Gemini AI Semantic Ranking via Cloud Functions Proxy.
/// 
/// This implementation calls a secure Firebase Cloud Function ('rankSmartFeedWithGemini')
/// to process the semantic ranking on the server, keeping the API Key hidden
/// and enforcing privacy-safe payload policies.
class GeminiSemanticRankingAdapter implements SemanticRankingAdapter {
  final FirebaseFunctions _functions;

  GeminiSemanticRankingAdapter({FirebaseFunctions? functions})
      : _functions = functions ?? FirebaseFunctions.instance;

  @override
  Future<List<SemanticRankingResult>> rank({
    required List<SemanticRankingPayload> payloads,
    required String userIntent,
    String languageCode = 'id',
  }) async {
    final trimmedIntent = userIntent.trim();
    if (payloads.isEmpty || trimmedIntent.isEmpty) return [];

    // Client-side safety: Limit to 30 items
    final itemsToRank = payloads.length > 30 ? payloads.take(30).toList() : payloads;

    try {
      final response = await _functions
          .httpsCallable('rankSmartFeedWithGemini')
          .call({
        'intent': trimmedIntent,
        'languageCode': languageCode,
        'items': itemsToRank.map((p) => p.toSafeJson()).toList(),
      });

      final data = response.data;
      if (data is! Map) return [];
      
      final results = data['results'];
      if (results is! List) return [];

      return results.map((r) {
        if (r is! Map) return null;
        final map = Map<String, dynamic>.from(r);
        
        final rawScore = map['score'];
        final double score = rawScore is num ? rawScore.toDouble() : 0.0;
        
        return SemanticRankingResult(
          feedItemId: map['feedItemId']?.toString() ?? '',
          score: score.clamp(0.0, 30.0),
          reason: map['reason']?.toString(),
        );
      }).whereType<SemanticRankingResult>().toList();
    } on FirebaseFunctionsException catch (e) {
      // Log error but allow rule-based ranking fallback
      // Using debugPrint to follow project patterns (seen in MarketplaceAiConfig)
      debugPrint('GeminiSemanticRankingAdapter Firebase Error: ${e.code} - ${e.message}');
      return [];
    } catch (e) {
      debugPrint('GeminiSemanticRankingAdapter Error: $e');
      return [];
    }
  }
}
