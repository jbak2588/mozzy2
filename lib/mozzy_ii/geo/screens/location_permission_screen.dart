import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:geolocator/geolocator.dart';
import '../providers/location_provider.dart';

class LocationPermissionScreen extends ConsumerWidget {
  const LocationPermissionScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.location_on, size: 80, color: Color(0xFFCC0001)),
              const SizedBox(height: 24),
              const Text(
                'Izinkan akses lokasi', // 위치 액세스 허용
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 16),
              const Text(
                'Mozzy membutuhkan lokasi Anda untuk menemukan konten dan layanan terbaik di sekitar Anda.',
                // Mozzy는 주변의 최고의 콘텐츠와 서비스를 찾기 위해 위치 정보가 필요합니다.
                style: TextStyle(fontSize: 16, color: Colors.grey),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 32),
              ElevatedButton(
                onPressed: () async {
                  final permission = await Geolocator.requestPermission();
                  if (permission == LocationPermission.whileInUse || 
                      permission == LocationPermission.always) {
                    // 권한 획득 시 provider 갱신
                    ref.invalidate(locationProvider);
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFCC0001),
                  foregroundColor: Colors.white,
                  minimumSize: const Size(double.infinity, 50),
                ),
                child: const Text('Aktifkan Lokasi', style: TextStyle(fontWeight: FontWeight.bold)),
              ),
              const SizedBox(height: 16),
              TextButton(
                onPressed: () {
                  // TODO: 수동 도시 검색 화면으로 이동 (Fallback)
                },
                child: const Text(
                  'Pilih kota secara manual', // 수동으로 도시 선택
                  style: TextStyle(color: Color(0xFFCC0001)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
