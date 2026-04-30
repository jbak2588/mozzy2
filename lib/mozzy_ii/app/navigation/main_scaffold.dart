import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class MainScaffold extends StatelessWidget {
  final StatefulNavigationShell navigationShell;

  const MainScaffold({super.key, required this.navigationShell});

  void _onTap(int index) {
    navigationShell.goBranch(
      index,
      // 현재 보고 있는 탭을 다시 탭하면 해당 탭의 첫 화면으로 이동(초기화)
      initialLocation: index == navigationShell.currentIndex,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: navigationShell,
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: navigationShell.currentIndex,
        onTap: _onTap,
        type: BottomNavigationBarType.fixed,
        selectedItemColor: const Color(0xFFCC0001),
        unselectedItemColor: Colors.grey,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.explore),
            label: 'Beranda', // 홈 (Smart Feed)
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.storefront),
            label: 'Jual', // 마켓
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.article),
            label: 'Berita', // 뉴스
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.store),
            label: 'Toko', // 로컬 스토어
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.chat_bubble),
            label: 'Pesan', // 채팅
          ),
        ],
      ),
    );
  }
}
