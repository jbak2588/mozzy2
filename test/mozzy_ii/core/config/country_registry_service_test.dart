import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mozzy/mozzy_ii/core/config/country_registry_service.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  group('CountryRegistryService', () {
    late CountryRegistryService service;

    const mockIdJson = {
      "countryCode": "ID",
      "currencySymbol": "Rp",
      "phonePrefix": "+62",
      "paymentMethods": ["gopay", "ovo"]
    };

    setUp(() {
      service = CountryRegistryService();
      
      // Mock rootBundle for assets/config/countries/ID.json
      TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger.setMockMessageHandler(
        'flutter/assets',
        (ByteData? message) async {
          final String key = utf8.decode(message!.buffer.asUint8List());
          if (key == 'assets/config/countries/ID.json') {
            return ByteData.view(utf8.encode(jsonEncode(mockIdJson)).buffer);
          }
          return null;
        },
      );
    });

    test('loadCountry loads data correctly', () async {
      await service.loadCountry('ID');
      
      expect(service.currencySymbol, 'Rp');
      expect(service.phonePrefix, '+62');
      expect(service.availablePaymentMethods, contains('gopay'));
      expect(service.availablePaymentMethods, contains('ovo'));
    });

    test('currentConfig returns full map after load', () async {
      await service.loadCountry('ID');
      expect(service.currentConfig?['countryCode'], 'ID');
    });
  });
}
