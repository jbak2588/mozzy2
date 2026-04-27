import 'package:flutter_test/flutter_test.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:mozzy/mozzy_ii/core/utils/formatters.dart';

void main() {
  setUpAll(() async {
    await initializeDateFormatting('id_ID', null);
  });

  group('MozzyFormatters - IDR Formatting', () {
    test('formatIDR handles null and zero', () {
      expect(MozzyFormatters.formatIDR(null), 'Rp 0');
      expect(MozzyFormatters.formatIDR(0), 'Rp 0');
    });

    test('formatIDR formats numbers correctly with id_ID locale', () {
      // Note: NumberFormat for id_ID uses dot as thousand separator
      expect(MozzyFormatters.formatIDR(1000), 'Rp 1.000');
      expect(MozzyFormatters.formatIDR(1500000), 'Rp 1.500.000');
    });

    test('formatIDRCompact handles various ranges', () {
      expect(MozzyFormatters.formatIDRCompact(null), '0');
      expect(MozzyFormatters.formatIDRCompact(500), '500');
      expect(MozzyFormatters.formatIDRCompact(1000), '1Rb');
      expect(MozzyFormatters.formatIDRCompact(1500), '1,5Rb');
      expect(MozzyFormatters.formatIDRCompact(1000000), '1Jt');
      expect(MozzyFormatters.formatIDRCompact(1500000), '1,5Jt');
      expect(MozzyFormatters.formatIDRCompact(2500000), '2,5Jt');
    });
  });

  group('MozzyFormatters - Date & Time', () {
    test('formatDateID formats date correctly', () {
      final date = DateTime(2026, 4, 27);
      expect(MozzyFormatters.formatDateID(date), '27 April 2026');
    });

    test('formatRelativeTime returns correct strings in id', () {
      final now = DateTime.now();
      
      final justNow = now.subtract(const Duration(seconds: 30));
      expect(MozzyFormatters.formatRelativeTime(justNow), 'Baru saja');

      final minsAgo = now.subtract(const Duration(minutes: 5));
      expect(MozzyFormatters.formatRelativeTime(minsAgo), '5 menit yang lalu');

      final hoursAgo = now.subtract(const Duration(hours: 2));
      expect(MozzyFormatters.formatRelativeTime(hoursAgo), '2 jam yang lalu');

      final daysAgo = now.subtract(const Duration(days: 3));
      expect(MozzyFormatters.formatRelativeTime(daysAgo), '3 hari yang lalu');
    });

    test('formatRelativeTime returns correct strings in en', () {
      final now = DateTime.now();
      
      final justNow = now.subtract(const Duration(seconds: 30));
      expect(MozzyFormatters.formatRelativeTime(justNow, locale: 'en'), 'Just now');

      final minsAgo = now.subtract(const Duration(minutes: 5));
      expect(MozzyFormatters.formatRelativeTime(minsAgo, locale: 'en'), '5 mins ago');
    });
  });
}
