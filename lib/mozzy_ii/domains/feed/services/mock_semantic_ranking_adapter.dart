import 'semantic_ranking_adapter.dart';
import '../models/semantic_ranking_payload.dart';

class MockSemanticRankingAdapter implements SemanticRankingAdapter {
  @override
  Future<List<SemanticRankingResult>> rank({
    required List<SemanticRankingPayload> payloads,
    required String userIntent,
    String languageCode = 'id',
  }) async {
    // Artificial delay to simulate network
    await Future.delayed(const Duration(milliseconds: 300));

    final results = payloads.map((payload) {
      double score = 0.0;
      String? reason;

      final intent = userIntent.toLowerCase();
      final title = payload.title.toLowerCase();
      final summary = (payload.publicSummary ?? '').toLowerCase();
      final keywords = intent.split(' ').where((k) => k.length > 2).toList();

      // Simple keyword matching for semantic mock
      if (intent.isNotEmpty) {
        bool keywordMatched = false;
        for (final kw in keywords) {
          if (title.contains(kw) || summary.contains(kw)) {
            keywordMatched = true;
            break;
          }
        }
        
        if (keywordMatched) {
          score += 15.0;
          reason = 'Intent match in title/summary';
        }

        // Domain matching
        if ((intent.contains('job') || 
             intent.contains('kerja') || 
             intent.contains('lowongan') || 
             intent.contains('loker')) &&
            payload.type == 'job') {
          score += 10.0;
          reason = (reason == null) ? 'Job domain match' : '$reason + Job domain match';
        } else if ((intent.contains('market') || 
                    intent.contains('jual') || 
                    intent.contains('beli') || 
                    intent.contains('barang') || 
                    intent.contains('bekas') || 
                    intent.contains('murah')) &&
            payload.type == 'marketplaceProduct') {
          score += 10.0;
          reason = (reason == null) ? 'Marketplace domain match' : '$reason + Marketplace domain match';
        }
      }

      // Limit score to 30.0 as per policy
      if (score > 30.0) score = 30.0;

      return SemanticRankingResult(
        feedItemId: payload.feedItemId,
        score: score,
        reason: reason,
      );
    }).toList();

    return results;
  }
}
