import 'package:flutter_test/flutter_test.dart';
import 'package:mozzy/mozzy_ii/geo/models/location_parts.dart';
import 'package:mozzy/mozzy_ii/geo/utils/geo_path_builder.dart';

void main() {
  test('buildIndonesiaGeoPath - full address', () {
    final loc = LocationParts(
      countryCode: 'ID',
      idAddress: IndonesiaGeoAddress(
        provinsi: 'DKI Jakarta',
        kabupaten: 'Jakarta Selatan',
        kecamatan: 'Kebayoran Baru',
        kelurahan: 'Senayan',
      ),
      latitude: 0.0,
      longitude: 0.0,
      geoHash: 'abcd',
    );

    final path = buildIndonesiaGeoPath(loc);
    expect(path, 'ID#DKI Jakarta#Jakarta Selatan#Kebayoran Baru#Senayan');
  });

  test(
    'buildIndonesiaGeoPath - missing fields do not produce empty segments',
    () {
      final loc = LocationParts(
        countryCode: 'ID',
        idAddress: IndonesiaGeoAddress(
          provinsi: 'DKI Jakarta',
          kabupaten: '',
          kecamatan: 'Kebayoran Baru',
          kelurahan: '',
        ),
        latitude: 0.0,
        longitude: 0.0,
        geoHash: 'abcd',
      );

      final path = buildIndonesiaGeoPath(loc);
      expect(path, 'ID#DKI Jakarta#Kebayoran Baru');
    },
  );
}
