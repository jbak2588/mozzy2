import '../models/feed_item_model.dart';
import '../models/semantic_ranking_payload.dart';

class FeedSemanticSanitizer {
  /// Sanitizes a FeedItemModel into a privacy-safe SemanticRankingPayload.
  SemanticRankingPayload sanitize(
    FeedItemModel item, {
    String languageCode = 'id',
  }) {
    // 1. Remove sensitive patterns from description/summary
    final rawDescription = item.description ?? '';
    final sanitizedSummary = _sanitizeText(rawDescription);

    // 2. Determine age bucket
    final ageBucket = _getAgeBucket(item.createdAt);

    return SemanticRankingPayload(
      feedItemId: item.id,
      sourceId: item.sourceId,
      type: item.type.name,
      title: item.title,
      publicSummary: sanitizedSummary,
      category: item.subtitle, // Often holds category or company name
      locationHint: item.locationText,
      isPromoted: item.isPromoted,
      isTrusted: item.trustScore > 0.8,
      ageBucket: ageBucket,
      languageCode: languageCode,
    );
  }

  String _sanitizeText(String text) {
    if (text.isEmpty) return '';

    // Remove common PII patterns
    String sanitized = text;

    // Remove emails
    sanitized = sanitized.replaceAll(
      RegExp(r'[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}'),
      '[EMAIL]',
    );

    // Remove phone numbers (simple pattern for common formats)
    sanitized = sanitized.replaceAll(
      RegExp(r'(\+?62|08)[0-9\- ]{8,13}'),
      '[PHONE]',
    );

    // Truncate to avoid excessive token usage and unintentional disclosure
    if (sanitized.length > 300) {
      sanitized = '${sanitized.substring(0, 300)}...';
    }

    return sanitized;
  }

  String _getAgeBucket(DateTime createdAt) {
    final now = DateTime.now();
    final difference = now.difference(createdAt);

    if (difference.inHours < 24) return 'new';
    if (difference.inDays < 3) return 'recent';
    if (difference.inDays < 7) return 'week';
    return 'old';
  }
}
