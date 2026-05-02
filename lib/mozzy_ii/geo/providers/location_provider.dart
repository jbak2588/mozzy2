import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geoflutterfire_plus/geoflutterfire_plus.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/location_parts.dart';
import '../location/indonesia_location_service.dart';
import '../../core/config/integration_test_config.dart';

/// 현재 사용자 위치 상태를 관리하는 Riverpod Provider
class LocationNotifier extends AsyncNotifier<LocationParts?> {
  @override
  Future<LocationParts?> build() async {
    if (IntegrationTestConfig.enabled) {
      return LocationParts(
        countryCode: 'ID',
        latitude: -6.2278,
        longitude: 106.8016,
        geoHash: 'qqguw',
        idAddress: const IndonesiaGeoAddress(
          provinsi: 'DKI Jakarta',
          kabupaten: 'Jakarta Selatan',
          kecamatan: 'Kebayoran Baru',
          kelurahan: 'Senayan',
        ),
      );
    }
    // 초기 로드 시 위치 권한 확인 및 현재 위치 가져오기
    return _fetchCurrentLocation();
  }

  /// 기기의 GPS를 사용하여 현재 위치 가져오기 및 역지오코딩 수행
  Future<LocationParts?> _fetchCurrentLocation() async {
    try {
      bool serviceEnabled;
      LocationPermission permission;

      // 1. 위치 서비스 활성화 여부 확인
      serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) {
        if (kDebugMode) debugPrint('[LocationProvider] service disabled');
        return null; // 위치 서비스 비활성화
      }

      // 2. 권한 확인 및 요청
      permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          if (kDebugMode) debugPrint('[LocationProvider] permission denied');
          return null; // 권한 거부됨
        }
      }

      if (permission == LocationPermission.deniedForever) {
        if (kDebugMode) debugPrint('[LocationProvider] permission denied forever');
        return null; // 영구 거부됨
      }

      // 3. 현재 위치 가져오기 (Timeout 5s)
      if (kDebugMode) debugPrint('[LocationProvider] requesting position...');
      final position = await Geolocator.getCurrentPosition(
        locationSettings: const LocationSettings(
          accuracy: LocationAccuracy.high,
          timeLimit: Duration(seconds: 5),
        ),
      ).timeout(
        const Duration(seconds: 5),
        onTimeout: () {
          throw Exception('GPS timeout');
        },
      );

      // 4. 역지오코딩을 통해 주소 정보 획득 (Timeout 5s)
      if (kDebugMode) debugPrint('[LocationProvider] reverse geocoding...');
      final locationService = ref.read(indonesiaLocationServiceProvider);
      final idAddress = await locationService
          .reverseGeocode(position)
          .timeout(const Duration(seconds: 5));

      final geoFirePoint = GeoFirePoint(
        GeoPoint(position.latitude, position.longitude),
      );

      if (kDebugMode) debugPrint('[LocationProvider] success');
      return LocationParts(
        countryCode: 'ID',
        idAddress: idAddress,
        latitude: position.latitude,
        longitude: position.longitude,
        geoHash: geoFirePoint.geohash,
      );
    } catch (e) {
      if (kDebugMode) {
        debugPrint('[LocationProvider] error or timeout: $e');
      }
      return null;
    }
  }

  /// 사용자가 수동으로 도시를 변경할 때 호출
  void updateLocationManually(LocationParts newLocation) {
    state = AsyncData(newLocation);
  }
}

final locationProvider =
    AsyncNotifierProvider<LocationNotifier, LocationParts?>(
      () => LocationNotifier(),
    );
