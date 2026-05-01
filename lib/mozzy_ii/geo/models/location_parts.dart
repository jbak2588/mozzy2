import 'package:json_annotation/json_annotation.dart';

part 'location_parts.g.dart';

/// 인도네시아 고유의 4단계 행정 구역 (Track 1)
@JsonSerializable()
class IndonesiaGeoAddress {
  final String provinsi; // L1: 주 (State)
  final String kabupaten; // L2: 시/군 (City/Regency)
  final String kecamatan; // L3: 구/면 (District) - 동네 기본 단위
  final String kelurahan; // L4: 동/리 (Village) - 최소 하이퍼로컬 단위

  const IndonesiaGeoAddress({
    required this.provinsi,
    required this.kabupaten,
    required this.kecamatan,
    required this.kelurahan,
  });

  factory IndonesiaGeoAddress.fromJson(Map<String, dynamic> json) =>
      _$IndonesiaGeoAddressFromJson(json);
  Map<String, dynamic> toJson() => _$IndonesiaGeoAddressToJson(this);
}

/// 글로벌 확장을 위한 일반화된 주소 체계 (Track 2)
@JsonSerializable()
class GlobalGeoAddress {
  final String l1; // Admin Level 1 (e.g., State/Province)
  final String l2; // Admin Level 2 (e.g., City/County)
  final String l3; // Admin Level 3 (e.g., District)

  const GlobalGeoAddress({
    required this.l1,
    required this.l2,
    required this.l3,
  });

  factory GlobalGeoAddress.fromJson(Map<String, dynamic> json) =>
      _$GlobalGeoAddressFromJson(json);
  Map<String, dynamic> toJson() => _$GlobalGeoAddressToJson(this);
}

/// Firestore에 저장될 통합 위치 모델
@JsonSerializable(explicitToJson: true)
class LocationParts {
  final String countryCode; // ISO 3166-1 alpha-2 (e.g., 'ID')

  /// Track 1: 인도네시아 전용 주소 객체 (인도네시아일 경우 필수)
  final IndonesiaGeoAddress? idAddress;

  /// Track 2: 인도네시아 외 국가용 주소 객체
  final GlobalGeoAddress? globalAddress;

  /// 지도 좌표 (Latitude, Longitude)
  final double latitude;
  final double longitude;

  /// 위치 기반 검색(반경 검색)을 위한 GeoHash
  final String geoHash;

  const LocationParts({
    required this.countryCode,
    this.idAddress,
    this.globalAddress,
    required this.latitude,
    required this.longitude,
    required this.geoHash,
  });

  factory LocationParts.fromJson(Map<String, dynamic> json) =>
      _$LocationPartsFromJson(json);
  Map<String, dynamic> toJson() => _$LocationPartsToJson(this);
}
