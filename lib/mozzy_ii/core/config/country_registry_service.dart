import 'dart:convert';
import 'package:flutter/services.dart';

class CountryRegistryService {
  static final CountryRegistryService _instance = CountryRegistryService._internal();
  factory CountryRegistryService() => _instance;
  CountryRegistryService._internal();

  Map<String, dynamic>? _countryData;

  /// 지정된 국가 코드의 JSON 설정을 로드합니다. (Phase 0: 기본값 'ID')
  Future<void> loadCountry(String countryCode) async {
    try {
      final jsonString = await rootBundle.loadString('assets/config/countries/$countryCode.json');
      _countryData = jsonDecode(jsonString) as Map<String, dynamic>;
    } catch (e) {
      // Fallback 로직이나 에러 처리 (운영 환경에서는 더 세밀하게 처리 필요)
      print('Failed to load country config for $countryCode: $e');
    }
  }

  Map<String, dynamic>? get currentConfig => _countryData;

  String get currencySymbol => _countryData?['currency']?['symbol'] ?? 'Rp';
  String get phonePrefix => _countryData?['phonePrefix'] ?? '+62';
  List<String> get availablePaymentMethods => 
      List<String>.from(_countryData?['paymentMethods'] ?? []);
}
