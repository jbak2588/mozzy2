import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import '../providers/location_provider.dart';

enum MapFilter { all, news, marketplace, jobs, realEstate }

class SharedMapBrowserScreen extends ConsumerStatefulWidget {
  const SharedMapBrowserScreen({super.key});

  @override
  ConsumerState<SharedMapBrowserScreen> createState() =>
      _SharedMapBrowserScreenState();
}

class _SharedMapBrowserScreenState
    extends ConsumerState<SharedMapBrowserScreen> {
  MapFilter _currentFilter = MapFilter.all;
  GoogleMapController? _mapController;

  @override
  Widget build(BuildContext context) {
    // 현재 사용자 위치
    final locationAsync = ref.watch(locationProvider);

    // 기본 자카르타 좌표 (fallback)
    final initialPosition = const LatLng(-6.200000, 106.816666);

    // 사용자의 실제 위치가 로드되었으면 그 좌표를 사용
    final targetPosition = locationAsync.when(
      data: (location) => location != null
          ? LatLng(location.latitude, location.longitude)
          : initialPosition,
      loading: () => initialPosition,
      error: (error, stack) => initialPosition,
    );

    return Scaffold(
      body: Stack(
        children: [
          // 1. Google Map
          GoogleMap(
            initialCameraPosition: CameraPosition(
              target: targetPosition,
              zoom: 14,
            ),
            onMapCreated: (controller) => _mapController = controller,
            myLocationEnabled: true,
            myLocationButtonEnabled: false,
            zoomControlsEnabled: false,
            // TODO: markers: _buildMarkers(items)
          ),

          // 2. Feature 카테고리 필터 칩 (상단)
          Positioned(
            top: MediaQuery.of(context).padding.top + 8,
            left: 0,
            right: 0,
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                children: MapFilter.values.map((filter) {
                  final isSelected = _currentFilter == filter;
                  return Padding(
                    padding: const EdgeInsets.only(right: 8.0),
                    child: FilterChip(
                      selected: isSelected,
                      label: Text(
                        filter.name.toUpperCase(),
                        style: TextStyle(
                          color: isSelected ? Colors.white : Colors.black87,
                          fontWeight: isSelected
                              ? FontWeight.bold
                              : FontWeight.normal,
                        ),
                      ),
                      selectedColor: const Color(
                        0xFFCC0001,
                      ), // Mozzy Primary Red
                      checkmarkColor: Colors.white,
                      onSelected: (bool selected) {
                        setState(() {
                          _currentFilter = filter;
                        });
                      },
                    ),
                  );
                }).toList(),
              ),
            ),
          ),

          // 3. 지도 조작 버튼 (내 위치로 이동)
          Positioned(
            right: 16,
            top: MediaQuery.of(context).padding.top + 70,
            child: FloatingActionButton(
              mini: true,
              backgroundColor: Colors.white,
              onPressed: () {
                if (_mapController != null) {
                  _mapController!.animateCamera(
                    CameraUpdate.newLatLng(targetPosition),
                  );
                }
              },
              child: const Icon(Icons.my_location, color: Color(0xFFCC0001)),
            ),
          ),

          // 4. 하단 슬라이딩 패널 (DraggableScrollableSheet)
          DraggableScrollableSheet(
            initialChildSize: 0.3,
            minChildSize: 0.1,
            maxChildSize: 0.9,
            builder: (BuildContext context, ScrollController scrollController) {
              return Container(
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black12,
                      blurRadius: 10,
                      spreadRadius: 0,
                    ),
                  ],
                ),
                child: ListView.builder(
                  controller: scrollController,
                  itemCount: 10, // 임시 데이터 수
                  itemBuilder: (context, index) {
                    if (index == 0) {
                      return Column(
                        children: [
                          const SizedBox(height: 12),
                          Container(
                            width: 40,
                            height: 4,
                            decoration: BoxDecoration(
                              color: Colors.grey[300],
                              borderRadius: BorderRadius.circular(2),
                            ),
                          ),
                          const SizedBox(height: 16),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 16),
                            child: Row(
                              children: [
                                Text(
                                  'Hasil di sekitar Anda', // 주변 검색 결과
                                  style: const TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const Divider(),
                        ],
                      );
                    }
                    return ListTile(
                      leading: const CircleAvatar(
                        backgroundColor: Color(0xFFFFF5F5),
                        child: Icon(Icons.place, color: Color(0xFFCC0001)),
                      ),
                      title: Text('Item $_currentFilter $index'),
                      subtitle: const Text('Kecamatan Coblong • 500m'),
                      trailing: const Text(
                        'Rp 50.000',
                        style: TextStyle(
                          color: Color(0xFFCC0001),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    );
                  },
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
