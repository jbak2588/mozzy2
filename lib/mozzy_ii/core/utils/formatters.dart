import 'package:intl/intl.dart';

class MozzyFormatters {
  /// 인도네시아 루피아(IDR) 포맷팅 (예: Rp 1.500.000)
  static String formatIDR(dynamic amount) {
    if (amount == null) {
      return 'Rp 0';
    }
    final formatter = NumberFormat.currency(
      locale: 'id_ID',
      symbol: 'Rp ',
      decimalDigits: 0,
    );
    return formatter.format(amount);
  }

  /// 인도네시아 루피아 요약 포맷팅 (예: 1,5Jt, 500Rb)
  /// Jt = Juta (Million), Rb = Ribu (Thousand)
  static String formatIDRCompact(dynamic amount) {
    if (amount == null) {
      return '0';
    }
    final double value = amount is num
        ? amount.toDouble()
        : double.tryParse(amount.toString()) ?? 0;

    if (value >= 1000000) {
      return '${(value / 1000000).toStringAsFixed(value % 1000000 == 0 ? 0 : 1).replaceAll('.', ',')}Jt';
    } else if (value >= 1000) {
      return '${(value / 1000).toStringAsFixed(value % 1000 == 0 ? 0 : 1).replaceAll('.', ',')}Rb';
    } else {
      return value.toStringAsFixed(0);
    }
  }

  /// 인도네시아식 날짜 포맷팅 (예: 12 April 2026)
  static String formatDateID(DateTime date) {
    final formatter = DateFormat('d MMMM yyyy', 'id_ID');
    return formatter.format(date);
  }

  /// 상대적 시간 표시 (예: 2 jam yang lalu, Baru saja)
  static String formatRelativeTime(DateTime date, {String locale = 'id'}) {
    final now = DateTime.now();
    final difference = now.difference(date);

    if (locale == 'id') {
      if (difference.inMinutes < 1) {
        return 'Baru saja';
      }
      if (difference.inMinutes < 60) {
        return '${difference.inMinutes} menit yang lalu';
      }
      if (difference.inHours < 24) return '${difference.inHours} jam yang lalu';
      if (difference.inDays < 7) return '${difference.inDays} hari yang lalu';
      return formatDateID(date);
    } else {
      if (difference.inMinutes < 1) {
        return 'Just now';
      }
      if (difference.inMinutes < 60) return '${difference.inMinutes} mins ago';
      if (difference.inHours < 24) return '${difference.inHours} hours ago';
      if (difference.inDays < 7) return '${difference.inDays} days ago';
      return DateFormat('d MMMM yyyy').format(date);
    }
  }
}
