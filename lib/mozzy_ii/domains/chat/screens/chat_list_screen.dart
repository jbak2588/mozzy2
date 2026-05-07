import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:go_router/go_router.dart';
import '../providers/chat_provider.dart';

class ChatListScreen extends ConsumerWidget {
  const ChatListScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentUserId = ref.watch(currentChatUserIdProvider);
    if (currentUserId == null) {
      return Scaffold(
        appBar: AppBar(title: Text('chat.title'.tr())),
        body: Center(child: Text('marketplace.loginRequired'.tr())),
      );
    }

    final roomsAsync = ref.watch(userChatRoomsProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text('chat.title'.tr()),
        centerTitle: false,
      ),
      body: roomsAsync.when(
        data: (rooms) {
          if (rooms.isEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.chat_bubble_outline, size: 80, color: Colors.grey.shade200),
                  const SizedBox(height: 24),
                  Text(
                    'chat.empty'.tr(),
                    style: TextStyle(color: Colors.grey.shade500, fontSize: 16),
                  ),
                ],
              ),
            );
          }

          return ListView.separated(
            padding: const EdgeInsets.symmetric(vertical: 8),
            itemCount: rooms.length,
            separatorBuilder: (context, index) => const Divider(height: 1, indent: 80),
            itemBuilder: (context, index) {
              final room = rooms[index];
              final unreadCount = room.unreadCountByUser[currentUserId] ?? 0;
              final isBuyer = currentUserId == room.buyerId;

              return ListTile(
                onTap: () => context.push('/chat/${room.id}'),
                contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                leading: Stack(
                  clipBehavior: Clip.none,
                  children: [
                    if (room.productImageUrl != null)
                      ClipRRect(
                        borderRadius: BorderRadius.circular(12),
                        child: Image.network(
                          room.productImageUrl!,
                          width: 60,
                          height: 60,
                          fit: BoxFit.cover,
                        ),
                      )
                    else
                      Container(
                        width: 60,
                        height: 60,
                        decoration: BoxDecoration(
                          color: Colors.grey.shade200,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: const Icon(Icons.shopping_bag_outlined, color: Colors.grey),
                      ),
                    if (unreadCount > 0)
                      Positioned(
                        right: -4,
                        top: -4,
                        child: Container(
                          padding: const EdgeInsets.all(6),
                          decoration: BoxDecoration(
                            color: Theme.of(context).primaryColor,
                            shape: BoxShape.circle,
                            border: Border.all(color: Colors.white, width: 2),
                          ),
                          constraints: const BoxConstraints(minWidth: 20, minHeight: 20),
                          child: Text(
                            unreadCount > 99 ? '99+' : '$unreadCount',
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 10,
                              fontWeight: FontWeight.bold,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                  ],
                ),
                title: Row(
                  children: [
                    Expanded(
                      child: Text(
                        isBuyer ? 'chat.chatSeller'.tr() : 'chat.chatBuyer'.tr(),
                        style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    const SizedBox(width: 8),
                    Text(
                      _formatTime(room.lastMessageAt ?? room.updatedAt),
                      style: TextStyle(
                        fontSize: 12,
                        color: unreadCount > 0 ? Theme.of(context).primaryColor : Colors.grey,
                        fontWeight: unreadCount > 0 ? FontWeight.bold : FontWeight.normal,
                      ),
                    ),
                  ],
                ),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 4),
                    Text(
                      room.type == 'job_inquiry' ? (room.jobTitle ?? '') : (room.productTitle ?? ''),
                      style: TextStyle(fontSize: 12, color: Colors.grey.shade600),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 2),
                    Text(
                      room.lastMessage ?? 'chat.startConversation'.tr(),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: unreadCount > 0 ? FontWeight.bold : FontWeight.normal,
                        color: unreadCount > 0 ? Colors.black87 : Colors.grey.shade500,
                      ),
                    ),
                  ],
                ),
              );
            },
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, __) => Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('chat.error'.tr()),
              const SizedBox(height: 8),
              ElevatedButton(
                onPressed: () => ref.refresh(userChatRoomsProvider),
                child: Text('chat.retry'.tr()),
              ),
            ],
          ),
        ),
      ),
    );
  }

  String _formatTime(DateTime date) {
    final now = DateTime.now();
    if (DateUtils.isSameDay(date, now)) {
      return DateFormat('HH:mm').format(date);
    }
    if (DateUtils.isSameDay(date, now.subtract(const Duration(days: 1)))) {
      return 'chat.yesterday'.tr();
    }
    return DateFormat('dd/MM').format(date);
  }
}
