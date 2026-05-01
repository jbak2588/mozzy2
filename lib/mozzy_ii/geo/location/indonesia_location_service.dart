import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';
import '../models/location_parts.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

enum AddressDetail { minimal, standard, full }

enum IndonesiaTimezone { wib, wita, wit }

class IndonesiaLocationService {
  /// GPS -> 인도네시아 행정구역 역지오코딩
  Future<IndonesiaGeoAddress> reverseGeocode(Position position) async {
    List<Placemark> placemarks = await placemarkFromCoordinates(
      position.latitude,
      position.longitude,
    );

    if (placemarks.isEmpty) {
      throw Exception('Failed to get placemark from coordinates.');
    }

    final placemark = placemarks.first;

    return IndonesiaGeoAddress(
      provinsi: placemark.administrativeArea ?? '',
      kabupaten: placemark.subAdministrativeArea ?? '',
      kecamatan: placemark.locality ?? '',
      kelurahan: placemark.subLocality ?? '',
    );
  }

  /// 주소 표시 포맷팅
  String formatAddress(IndonesiaGeoAddress addr, AddressDetail detail) {
    switch (detail) {
      case AddressDetail.minimal:
        return addr.kecamatan;
      case AddressDetail.standard:
        return '${addr.kecamatan}, ${addr.kabupaten}';
      case AddressDetail.full:
        return '${addr.kelurahan}, ${addr.kecamatan}, ${addr.kabupaten}, ${addr.provinsi}';
    }
  }

  /// 타임존 자동 감지 (Provinsi 기반)
  IndonesiaTimezone detectTimezone(String provinsiCode) {
    const witbProvinces = [
      'JK',
      'JB',
      'JT',
      'JI',
      'SS',
      'SB',
      'BB',
      'BT',
      'LA',
      'BE',
      'KU',
    ];
    const witaProvinces = ['BA', 'NTB', 'NTT', 'KT', 'KS', 'SR', 'ST', 'SG'];
    if (witbProvinces.contains(provinsiCode)) return IndonesiaTimezone.wib;
    if (witaProvinces.contains(provinsiCode)) return IndonesiaTimezone.wita;
    return IndonesiaTimezone.wit;
  }
}

final indonesiaLocationServiceProvider = Provider(
  (ref) => IndonesiaLocationService(),
);
