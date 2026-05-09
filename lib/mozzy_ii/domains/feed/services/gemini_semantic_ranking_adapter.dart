import 'semantic_ranking_adapter.dart';
import '../models/semantic_ranking_payload.dart';

/// Adapter for Gemini AI Semantic Ranking.
/// 
/// IMPORTANT: This is a skeleton. Actual implementation should NOT call Gemini
/// directly with a secret key from the client. P5-S04 will implement a 
/// Cloud Functions proxy for secure and cost-controlled access.
class GeminiSemanticRankingAdapter implements SemanticRankingAdapter {
  @override
  Future<List<SemanticRankingResult>> rank({
    required List<SemanticRankingPayload> payloads,
    required String userIntent,
    String languageCode = 'id',
  }) async {
    // TODO: Implement Cloud Functions proxy call in P5-S04
    // Never call Gemini directly from the Flutter client with a secret key.
    
    throw UnimplementedError(
      'GeminiSemanticRankingAdapter is not implemented yet. '
      'Use MockSemanticRankingAdapter for local testing.'
    );
  }
}
