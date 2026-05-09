import '../models/feed_item_model.dart';
import '../models/feed_ranking_signal.dart';
import '../models/user_location_context.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'feed_ranking_service.g.dart';

@riverpod
class FeedRankingService extends _$FeedRankingService {
  @override
  void build() {}

  double calculateBoostScore(FeedItemModel item) {
    return item.isPromoted ? FeedRankingSignal.activeBoostBonus : 0.0;
  }

  double calculateFreshnessScore(DateTime createdAt, DateTime now) {
    final difference = now.difference(createdAt);
    if (difference.inHours < 24) return FeedRankingSignal.freshnessWithin24h;
    if (difference.inDays < 3) return FeedRankingSignal.freshnessWithin3Days;
    if (difference.inDays < 7) return FeedRankingSignal.freshnessWithin7Days;
    return 0.0;
  }

  double calculateTrustScore(FeedItemModel item) {
    // Basic mapping: 0.0 ~ 1.0 trust score to bonus
    if (item.trustScore > 0.8) return FeedRankingSignal.highTrustBonus;
    if (item.trustScore > 0.5) return FeedRankingSignal.midTrustBonus;
    return 0.0;
  }

  double calculateDistanceScore(FeedItemModel item, UserLocationContext? context) {
    if (context == null || item.locationParts == null) return 0.0;
    
    final userAddr = context.locationParts.idAddress;
    final itemAddr = item.locationParts?.idAddress;
    
    if (userAddr == null || itemAddr == null) return 0.0;

    // Check same kecamatan (district)
    if (userAddr.provinsi == itemAddr.provinsi &&
        userAddr.kabupaten == itemAddr.kabupaten &&
        userAddr.kecamatan == itemAddr.kecamatan) {
      return FeedRankingSignal.sameDistrictBonus;
    }
    
    // Check same kabupaten (city/regency)
    if (userAddr.provinsi == itemAddr.provinsi &&
        userAddr.kabupaten == itemAddr.kabupaten) {
      return FeedRankingSignal.sameCityBonus;
    }
    
    return 0.0;
  }

  double calculateEngagementScore(FeedItemModel item) {
    return item.engagementScore * FeedRankingSignal.engagementMultiplier;
  }

  double calculateFinalScore(
    FeedItemModel item, {
    UserLocationContext? context,
    DateTime? now,
  }) {
    final currentNow = now ?? DateTime.now();
    
    final boost = calculateBoostScore(item);
    final freshness = calculateFreshnessScore(item.createdAt, currentNow);
    final trust = calculateTrustScore(item);
    final distance = calculateDistanceScore(item, context);
    final engagement = calculateEngagementScore(item);
    
    return boost + freshness + trust + distance + engagement;
  }

  List<FeedItemModel> rankItems(List<FeedItemModel> items, {UserLocationContext? context, DateTime? now}) {
    final currentNow = now ?? DateTime.now();
    
    final scoredItems = items.map((item) {
      final score = calculateFinalScore(item, context: context, now: currentNow);
      return item.copyWith(finalScore: score);
    }).toList();
    
    scoredItems.sort((a, b) => b.finalScore.compareTo(a.finalScore));
    return scoredItems;
  }
}
