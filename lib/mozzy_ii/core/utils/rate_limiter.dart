import 'dart:collection';

class RateLimiter {
  final int maxRequests;
  final Duration interval;
  final Queue<DateTime> _requestTimestamps = Queue<DateTime>();

  RateLimiter({
    required this.maxRequests,
    required this.interval,
  });

  /// 요청이 허용되는지 확인합니다. 허용되면 타임스탬프를 기록하고 true를 반환합니다.
  bool request() {
    final now = DateTime.now();
    
    // 지정된 간격(interval)을 벗어난 오래된 타임스탬프 제거
    while (_requestTimestamps.isNotEmpty && 
           now.difference(_requestTimestamps.first) > interval) {
      _requestTimestamps.removeFirst();
    }

    if (_requestTimestamps.length < maxRequests) {
      _requestTimestamps.addLast(now);
      return true;
    }

    return false; // 제한 초과
  }
}
