import 'package:flutter_test/flutter_test.dart';
import 'package:mozzy/mozzy_ii/domains/feed/services/feed_time_weight_service.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void main() {
  late FeedTimeWeightService service;

  setUp(() {
    final container = ProviderContainer();
    service = container.read(feedTimeWeightServiceProvider.notifier);
  });

  group('FeedTimeWeightService', () {
    test('resolveIndonesiaLocalTime handles WIB (UTC+7)', () {
      final utc = DateTime.utc(2026, 5, 10, 10, 0); // 10:00 UTC
      final local = service.resolveIndonesiaLocalTime(utc, 'WIB');
      expect(local.hour, 17); // 17:00 WIB
    });

    test('resolveIndonesiaLocalTime handles WITA (UTC+8)', () {
      final utc = DateTime.utc(2026, 5, 10, 10, 0);
      final local = service.resolveIndonesiaLocalTime(utc, 'WITA');
      expect(local.hour, 18);
    });

    test('resolveIndonesiaLocalTime handles WIT (UTC+9)', () {
      final utc = DateTime.utc(2026, 5, 10, 10, 0);
      final local = service.resolveIndonesiaLocalTime(utc, 'WIT');
      expect(local.hour, 19);
    });

    test('getTimeWeight returns 1.15 for jobs at 08:00 WIB', () {
      final now = DateTime.utc(2026, 5, 12, 1, 0); // Tuesday 01:00 UTC -> 08:00 WIB
      final weight = service.getTimeWeight(sourceType: 'jobs', now: now, timezoneCode: 'WIB');
      expect(weight, 1.15);
    });

    test('getTimeWeight returns 1.12 for localNews at 08:00 WIB', () {
      final now = DateTime.utc(2026, 5, 12, 1, 0);
      final weight = service.getTimeWeight(sourceType: 'localNews', now: now, timezoneCode: 'WIB');
      expect(weight, 1.12);
    });

    test('getTimeWeight returns 1.15 for marketplaceProduct at 18:00 WIB', () {
      final now = DateTime.utc(2026, 5, 12, 11, 0); // Tuesday 11:00 UTC -> 18:00 WIB
      final weight = service.getTimeWeight(sourceType: 'marketplaceProduct', now: now, timezoneCode: 'WIB');
      expect(weight, 1.15);
    });

    test('getTimeWeight returns weekend weight for Sunday', () {
      final now = DateTime.utc(2026, 5, 10, 10, 0); // Sunday 17:00 WIB
      final weight = service.getTimeWeight(sourceType: 'together', now: now, timezoneCode: 'WIB');
      expect(weight, 1.15);
    });
  });
}
