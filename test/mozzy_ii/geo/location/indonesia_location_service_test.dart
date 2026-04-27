import 'package:flutter_test/flutter_test.dart';
import 'package:mozzy/mozzy_ii/geo/location/indonesia_location_service.dart';
import 'package:mozzy/mozzy_ii/geo/models/location_parts.dart';

void main() {
  group('IndonesiaLocationService - Address Formatting', () {
    final service = IndonesiaLocationService();
    const address = IndonesiaGeoAddress(
      provinsi: 'Jawa Barat',
      kabupaten: 'Bandung',
      kecamatan: 'Coblong',
      kelurahan: 'Dago',
    );

    test('formatAddress returns minimal format (kecamatan)', () {
      expect(service.formatAddress(address, AddressDetail.minimal), 'Coblong');
    });

    test('formatAddress returns standard format', () {
      expect(service.formatAddress(address, AddressDetail.standard), 'Coblong, Bandung');
    });

    test('formatAddress returns full format', () {
      expect(
        service.formatAddress(address, AddressDetail.full), 
        'Dago, Coblong, Bandung, Jawa Barat'
      );
    });
  });

  group('IndonesiaLocationService - Timezone Detection', () {
    final service = IndonesiaLocationService();

    test('detectTimezone detects WIB correctly', () {
      expect(service.detectTimezone('JK'), IndonesiaTimezone.wib);
      expect(service.detectTimezone('JB'), IndonesiaTimezone.wib);
    });

    test('detectTimezone detects WITA correctly', () {
      expect(service.detectTimezone('BA'), IndonesiaTimezone.wita);
      expect(service.detectTimezone('NTB'), IndonesiaTimezone.wita);
    });

    test('detectTimezone detects WIT correctly', () {
      expect(service.detectTimezone('MA'), IndonesiaTimezone.wit);
      expect(service.detectTimezone('PA'), IndonesiaTimezone.wit);
    });
  });
}
