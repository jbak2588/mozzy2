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
    if (payloads.isEmpty) return [];

    try {
      final response = await _functions
          .httpsCallable('rankSmartFeedWithGemini')
          .call({
        'intent': userIntent,
        'languageCode': languageCode,
        'items': payloads.map((p) => p.toSafeJson()).toList(),
      });

      final data = response.data as Map<String, dynamic>;
      final results = data['results'] as List<dynamic>;

      return results.map((r) {
        final map = Map<String, dynamic>.from(r as Map);
        return SemanticRankingResult(
          feedItemId: map['feedItemId'] as String,
          score: (map['score'] as num).toDouble(),
          reason: map['reason'] as String?,
        );
      }).toList();
    } on FirebaseFunctionsException catch (e) {
      // Return empty list on failure to allow rule-based ranking fallback
      print('GeminiSemanticRankingAdapter Firebase Error: ${e.code} - ${e.message}');
      return [];
    } catch (e) {
      print('GeminiSemanticRankingAdapter Error: $e');
      return [];
    }
  }
}
