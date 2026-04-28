import '../models/location_parts.dart';

String buildIndonesiaGeoPath(LocationParts location) {
  final id = location.idAddress;
  return [
    location.countryCode,
    id?.provinsi ?? '',
    id?.kabupaten ?? '',
    id?.kecamatan ?? '',
    id?.kelurahan ?? '',
  ].where((e) => e.trim().isNotEmpty).join('#');
}
