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
    bool serviceEnabled;
    LocationPermission permission;

    // 1. 위치 서비스 활성화 여부 확인
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return null; // 위치 서비스 비활성화
    }

    // 2. 권한 확인 및 요청
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return null; // 권한 거부됨
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return null; // 영구 거부됨
    }

    // 3. 현재 위치 가져오기
    final position = await Geolocator.getCurrentPosition(
      locationSettings: const LocationSettings(
        accuracy: LocationAccuracy.high,
        timeLimit: Duration(seconds: 5),
      ),
    ).timeout(const Duration(seconds: 5));

    // 4. 역지오코딩을 통해 주소 정보 획득
    final locationService = ref.read(indonesiaLocationServiceProvider);
    try {
      final idAddress = await locationService
          .reverseGeocode(position)
          .timeout(const Duration(seconds: 5));
      final geoFirePoint = GeoFirePoint(
        GeoPoint(position.latitude, position.longitude),
      );

      return LocationParts(
        countryCode: 'ID',
        idAddress: idAddress,
        latitude: position.latitude,
        longitude: position.longitude,
        geoHash: geoFirePoint.geohash,
      );
    } catch (e) {
      // 역지오코딩 실패 시 좌표만 반환하거나 처리
      debugPrint('Location processing or reverse geocoding failed: $e');
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
