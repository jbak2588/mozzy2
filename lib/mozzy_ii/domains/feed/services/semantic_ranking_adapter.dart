import '../models/semantic_ranking_payload.dart';

class SemanticRankingResult {
  final String feedItemId;
  final double score;
  final String? reason;

  SemanticRankingResult({
    required this.feedItemId,
    required this.score,
    this.reason,
  });
}

abstract class SemanticRankingAdapter {
  Future<List<SemanticRankingResult>> rank({
    required List<SemanticRankingPayload> payloads,
    required String userIntent,
    String languageCode = 'id',
  });
}
