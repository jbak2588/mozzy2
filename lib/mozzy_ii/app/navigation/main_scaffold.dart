import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../domains/notifications/providers/notification_provider.dart';

class MainScaffold extends ConsumerWidget {
  final StatefulNavigationShell navigationShell;

  const MainScaffold({super.key, required this.navigationShell});

  void _onTap(int index) {
    navigationShell.goBranch(
      index,
      initialLocation: index == navigationShell.currentIndex,
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final unreadCount = ref.watch(unreadNotificationsCountProvider);

    return Scaffold(
      body: navigationShell,
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: navigationShell.currentIndex,
        onTap: _onTap,
        type: BottomNavigationBarType.fixed,
        selectedItemColor: const Color(0xFFCC0001),
        unselectedItemColor: Colors.grey,
        items: [
          const BottomNavigationBarItem(
            icon: Icon(Icons.explore),
            label: 'Beranda',
          ),
          const BottomNavigationBarItem(
            icon: Icon(Icons.storefront),
            label: 'Jual',
          ),
          const BottomNavigationBarItem(
            icon: Icon(Icons.article),
            label: 'Berita',
          ),
          const BottomNavigationBarItem(
            icon: Icon(Icons.store),
            label: 'Toko',
          ),
          BottomNavigationBarItem(
            icon: Badge(
              label: unreadCount > 0 ? Text(unreadCount.toString()) : null,
              isLabelVisible: unreadCount > 0,
              child: const Icon(Icons.chat_bubble),
            ),
            label: 'Pesan',
          ),
        ],
      ),
    );
  }
}
