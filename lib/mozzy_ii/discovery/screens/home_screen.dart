import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:easy_localization/easy_localization.dart';

import '../../app/auth/auth_service.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: Text('app_name'.tr()),
        actions: [
          // 언어 변경 드롭다운
          DropdownButton<Locale>(
            value: context.locale,
            icon: const Icon(Icons.language, color: Colors.black87),
            underline: const SizedBox(),
            onChanged: (Locale? newLocale) {
              if (newLocale != null) {
                context.setLocale(newLocale);
              }
            },
            items: const [
              DropdownMenuItem(
                value: Locale('id'),
                child: Text('🇮🇩 ID'),
              ),
              DropdownMenuItem(
                value: Locale('en'),
                child: Text('🇺🇸 EN'),
              ),
              DropdownMenuItem(
                value: Locale('ko'),
                child: Text('🇰🇷 KO'),
              ),
            ],
          ),
          const SizedBox(width: 8),
          // 임시 로그아웃 버튼 (개발 편의를 위함)
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () async {
              await ref.read(authServiceProvider).signOut();
            },
          ),
          const SizedBox(width: 8),
        ],
      ),
      body: CustomScrollView(
        slivers: [
          // 1. 상단 위치 표시 바 (Geo Layer 영역)
          SliverToBoxAdapter(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              color: Colors.grey[100],
              child: Row(
                children: [
                  const Icon(Icons.location_on, color: Color(0xFFCC0001), size: 20),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      'geo.detecting'.tr(), // 임시 텍스트, 추후 LocationProvider 연동
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      // TODO: 위치 변경 기능
                    },
                    child: Text('geo.change_location'.tr()),
                  ),
                ],
              ),
            ),
          ),
          
          // 2. Smart Feed 콘텐츠 영역 (Placeholder)
          SliverPadding(
            padding: const EdgeInsets.all(16),
            sliver: SliverList(
              delegate: SliverChildBuilderDelegate(
                (context, index) {
                  return Card(
                    margin: const EdgeInsets.only(bottom: 16),
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              CircleAvatar(
                                backgroundColor: Colors.grey[300],
                                child: const Icon(Icons.person, color: Colors.white),
                              ),
                              const SizedBox(width: 12),
                              const Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text('Warga Lokal', style: TextStyle(fontWeight: FontWeight.bold)),
                                  Text('2 jam yang lalu', style: TextStyle(fontSize: 12, color: Colors.grey)),
                                ],
                              ),
                            ],
                          ),
                          const SizedBox(height: 16),
                          Container(
                            height: 150,
                            color: Colors.grey[200],
                            width: double.infinity,
                            child: const Center(child: Text('Image / Content Placeholder')),
                          ),
                          const SizedBox(height: 16),
                          const Text(
                            'Ini adalah contoh postingan di Smart Feed Mozzy. Berisi informasi lokal yang relevan.',
                            style: TextStyle(fontSize: 14),
                          ),
                        ],
                      ),
                    ),
                  );
                },
                childCount: 5, // 더미 아이템 개수
              ),
            ),
          ),
        ],
      ),
    );
  }
}
