/// ============================================================================
/// Mozzy DocHeader
/// Module        : Shared Contract
/// File          : lib/mozzy_ii/shared/contracts/mozzy_post_contract.dart
/// Purpose       : 11개 Feature 도메인이 공통으로 구현해야 하는 필수 계약 인터페이스입니다.
///                 Firestore Collection Group 쿼리와 Smart Feed 엔진의 기반이 됩니다.
/// ============================================================================

/// 위치 기반 노출 범위를 정의합니다. (Track 1+2 듀얼 지오 체계 지원)
enum GeoScope {
  neighborhood, // 동네 (Kelurahan / Kecamatan)
  city,         // 도시 (Kabupaten / Kota)
  country,      // 국가 (Provinsi / National)
  global        // 글로벌 (전 세계)
}

/// 콘텐츠의 노출 도달 방식을 정의합니다.
enum ReachMode {
  local_only,       // 지정된 지역 내에서만 노출
  progressive,      // 시간이 지남에 따라 점진적으로 인접 지역으로 노출 범위 확장
  global_relay      // 타 국가로 번역되어 글로벌 노출
}

/// 모든 Feature 도메인(뉴스, 마켓, 일자리 등)의 모델이 반드시 구현해야 하는 인터페이스.
/// 이 필드들은 Collection Group Index로 묶여 통합 검색 및 피드 정렬에 사용됩니다.
abstract class MozzyPostContract {
  /// 문서의 고유 ID
  String get id;

  /// 작성자의 UID
  String get userId;

  /// 지리적 노출 범위 (기본값 권장: neighborhood)
  GeoScope get geoScope;

  /// 노출 확장 전략 (기본값 권장: local_only)
  ReachMode get reachMode;

  /// 글로벌 릴레이 확장을 위한 번역 상태 맵 (예: {'en': 'completed', 'ko': 'pending'})
  Map<String, String> get translationState;

  /// 사용자의 신뢰도 점수 (0.0 ~ 1.0) - 높은 점수일수록 피드 상단 노출
  double get trustScore;

  /// Smart Feed 노출 알고리즘 가중치 점수 (최신성, 관련성, 참여도 복합 - 0.0 ~ 1.0)
  double get signalScore;

  /// 위치 정보의 계층적 직렬화 경로 (국가코드 격리 및 Prefix Match 쿼리용)
  /// Format: "COUNTRY#PROVINSI#KABUPATEN#KECAMATAN#KELURAHAN"
  /// Example: "ID#JB#BANDUNG#COBLONG#DAGO"
  String get geoPath;
}
