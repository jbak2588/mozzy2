import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'feed_time_weight_service.g.dart';

@riverpod
class FeedTimeWeightService extends _$FeedTimeWeightService {
  @override
  void build() {}

  /// Returns the time-based weight for a given sourceType and time.
  /// Standard weight is 1.0.
  double getTimeWeight({
    required String sourceType,
    required DateTime now,
    String timezoneCode = 'WIB',
  }) {
    final localTime = resolveIndonesiaLocalTime(now, timezoneCode);
    final hour = localTime.hour;
    final isWeekend = localTime.weekday == DateTime.saturday || localTime.weekday == DateTime.sunday;

    if (isWeekend) {
      return _getWeekendWeight(sourceType);
    }

    // 07:00-09:00: Jobs, News
    if (hour >= 7 && hour < 9) {
      if (sourceType == 'jobs') return 1.15;
      if (sourceType == 'localNews') return 1.12;
    }

    // 12:00-14:00: Stores, POM, Marketplace
    if (hour >= 12 && hour < 14) {
      if (sourceType == 'stores') return 1.15;
      if (sourceType == 'pom') return 1.12;
      if (sourceType == 'marketplaceProduct') return 1.05;
    }

    // 17:00-20:00: Marketplace, Together
    if (hour >= 17 && hour < 20) {
      if (sourceType == 'marketplaceProduct') return 1.15;
      if (sourceType == 'together') return 1.12;
    }

    // 21:00-23:00: POM, Clubs, News
    if (hour >= 21 && hour < 23) {
      if (sourceType == 'pom') return 1.15;
      if (sourceType == 'clubs') return 1.12;
      if (sourceType == 'localNews') return 1.07;
    }

    return 1.0;
  }

  double _getWeekendWeight(String sourceType) {
    if (sourceType == 'together') return 1.15;
    if (sourceType == 'marketplaceProduct') return 1.10;
    if (sourceType == 'pom') return 1.08;
    return 1.0;
  }

  /// Resolves UTC time to Indonesian local time based on timezone code.
  DateTime resolveIndonesiaLocalTime(DateTime utcNow, String timezoneCode) {
    final offsetHours = switch (timezoneCode) {
      'WITA' => 8,
      'WIT' => 9,
      _ => 7, // WIB
    };

    return utcNow.toUtc().add(Duration(hours: offsetHours));
  }
}
