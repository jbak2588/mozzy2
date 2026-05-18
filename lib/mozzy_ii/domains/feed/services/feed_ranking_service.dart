import '../models/feed_item_model.dart';
import '../models/user_feed_context.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'feed_ranking_service.g.dart';

@riverpod
class FeedRankingService extends _$FeedRankingService {
  // Official Weights from ADR-004
  static const double recencyWeight = 0.30;
  static const double relevanceWeight = 0.25;
  static const double engagementWeight = 0.20;
  static const double diversityWeight = 0.15;
  static const double trustWeight = 0.10;

  @override
  void build() {}

  /// Calculate the final signalScore (0.0 ~ 1.0) using the official formula.
  double calculateSignalScore({
    required FeedItemModel item,
    UserFeedContext? context,
    DateTime? now,
  }) {
    final currentNow = now ?? DateTime.now();

    final recency = calculateRecencyScore(item.createdAt, currentNow);
    final relevance = calculateRelevanceScore(item: item, context: context);
    final engagement = calculateEngagementScore(item);
    final diversity = calculateDiversityScore(
      sourceType: item.type.name,
      recentlyShownTypes: context?.recentlyShownTypes ?? [],
    );
    final trust = calculateTrustScore(item.trustScore);

    final totalScore = (recency * recencyWeight) +
        (relevance * relevanceWeight) +
        (engagement * engagementWeight) +
        (diversity * diversityWeight) +
        (trust * trustWeight);

    return _clamp01(totalScore);
  }

  /// Recency Score (0.0 ~ 1.0)
  /// 0~1h: 1.0, 1~6h: 0.9, 6~24h: 0.75, 1~3d: 0.55, 3~7d: 0.35, 7d+: 0.15
  double calculateRecencyScore(DateTime createdAt, DateTime now) {
    final difference = now.difference(createdAt);
    if (difference.isNegative) return 1.0; // Future safety

    if (difference.inHours < 1) return 1.0;
    if (difference.inHours < 6) return 0.9;
    if (difference.inHours < 24) return 0.75;
    if (difference.inDays < 3) return 0.55;
    if (difference.inDays < 7) return 0.35;
    return 0.15;
  }

  /// Relevance Score (0.0 ~ 1.0) - Location based
  /// Same Kelurahan: 1.0, Kecamatan: 0.85, Kabupaten: 0.6, Provinsi: 0.35, Other: 0.15
  double calculateRelevanceScore({
    required FeedItemModel item,
    UserFeedContext? context,
  }) {
    if (context == null || context.locationParts == null || item.locationParts == null) {
      return 0.15; // Default fallback
    }

    final userAddr = context.locationParts!.idAddress;
    final itemAddr = item.locationParts!.idAddress;

    if (userAddr == null || itemAddr == null) return 0.15;

    // Kelurahan check
    if (userAddr.provinsi == itemAddr.provinsi &&
        userAddr.kabupaten == itemAddr.kabupaten &&
        userAddr.kecamatan == itemAddr.kecamatan &&
        userAddr.kelurahan == itemAddr.kelurahan) {
      return 1.0;
    }

    // Kecamatan check
    if (userAddr.provinsi == itemAddr.provinsi &&
        userAddr.kabupaten == itemAddr.kabupaten &&
        userAddr.kecamatan == itemAddr.kecamatan) {
      return 0.85;
    }

    // Kabupaten/City check
    if (userAddr.provinsi == itemAddr.provinsi &&
        userAddr.kabupaten == itemAddr.kabupaten) {
      return 0.6;
    }

    // Provinsi check
    if (userAddr.provinsi == itemAddr.provinsi) {
      return 0.35;
    }

    return 0.15;
  }

  /// Engagement Score (0.0 ~ 1.0)
  /// engagementRaw = (likes*3) + (comments*5) + (views*1) + (chats*4) + (applicants*4)
  /// Normalized: 0: 0.0, 1~5: 0.25, 6~20: 0.5, 21~50: 0.75, 51+: 1.0
  double calculateEngagementScore(FeedItemModel item) {
    final raw = (item.likesCount * 3) +
        (item.commentsCount * 5) +
        (item.viewsCount * 1) +
        (item.chatsCount * 4) +
        (item.applicantsCount * 4);

    if (raw == 0) return 0.0;
    if (raw <= 5) return 0.25;
    if (raw <= 20) return 0.5;
    if (raw <= 50) return 0.75;
    return 1.0;
  }

  /// Diversity Score (0.0 ~ 1.0)
  /// repeated types reduce score.
  double calculateDiversityScore({
    required String sourceType,
    required List<String> recentlyShownTypes,
  }) {
    if (recentlyShownTypes.isEmpty) return 1.0;

    final count = recentlyShownTypes.take(5).where((t) => t == sourceType).length;

    switch (count) {
      case 0:
        return 1.0;
      case 1:
        return 0.8;
      case 2:
        return 0.6;
      case 3:
        return 0.4;
      default:
        return 0.2;
    }
  }

  /// Trust Score Component (0.0 ~ 1.0)
  double calculateTrustScore(double? itemTrustScore) {
    return _clamp01(itemTrustScore ?? 0.5);
  }

  /// Boost Score Component (High priority override)
  double calculateBoostScore(FeedItemModel item) {
    return item.isPromoted ? 100.0 : 0.0;
  }

  /// Compatibility method for existing callers.
  double calculateFinalScore(
    FeedItemModel item, {
    UserFeedContext? context,
    DateTime? now,
  }) {
    final boost = calculateBoostScore(item);
    final signal = calculateSignalScore(item: item, context: context, now: now);
    return boost + signal;
  }

  /// Clamp value between 0.0 and 1.0
  double _clamp01(double value) => value.clamp(0.0, 1.0).toDouble();

  /// Rank items using the official formula.
  List<FeedItemModel> rankItems(
    List<FeedItemModel> items, {
    UserFeedContext? context,
    DateTime? now,
  }) {
    final currentNow = now ?? DateTime.now();

    final scoredItems = items.map((item) {
      final signal = calculateSignalScore(
        item: item,
        context: context,
        now: currentNow,
      );
      final boost = calculateBoostScore(item);
      final total = boost + signal;
      
      return item.copyWith(signalScore: signal, finalScore: total);
    }).toList();

    scoredItems.sort((a, b) {
      // 1. Final Score DESC (Boost + Signal)
      final scoreComparison = b.finalScore.compareTo(a.finalScore);
      if (scoreComparison != 0) return scoreComparison;

      // 2. Created At DESC (Tie-breaker)
      return b.createdAt.compareTo(a.createdAt);
    });

    return scoredItems;
  }
}
