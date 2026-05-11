import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:go_router/go_router.dart';
import '../providers/chat_provider.dart';
import '../widgets/chat_message_bubble.dart';
import '../../users/providers/user_safety_provider.dart';
import '../../notifications/providers/notification_provider.dart';


class ChatDetailScreen extends ConsumerStatefulWidget {
  final String roomId;

  const ChatDetailScreen({super.key, required this.roomId});

  @override
  ConsumerState<ChatDetailScreen> createState() => _ChatDetailScreenState();
}

class _ChatDetailScreenState extends ConsumerState<ChatDetailScreen> {
  final _textController = TextEditingController();
  final _scrollController = ScrollController();
  bool _isSending = false;

  @override
  void initState() {
    super.initState();
    // Mark room as read when entering
    Future.microtask(() {
      _markAsRead();
    });
  }

  void _markAsRead() {
    final userId = ref.read(currentChatUserIdProvider);
    if (userId != null) {
      ref.read(chatRepositoryProvider).markRoomAsRead(widget.roomId, userId);
      // Also mark in-app notifications as read
      ref.read(notificationRepositoryProvider).markChatNotificationsAsRead(userId, widget.roomId);
    }
  }

  @override
  void dispose() {
    _textController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  Future<void> _sendMessage() async {
    final text = _textController.text.trim();
    if (text.isEmpty) return;

    final userId = ref.read(currentChatUserIdProvider);
    if (userId == null) return;

    setState(() => _isSending = true);
    _textController.clear();

    try {
      await ref.read(chatRepositoryProvider).sendTextMessage(
            roomId: widget.roomId,
            senderId: userId,
            text: text,
          );
      _scrollToBottom();
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('chat.sendFailed'.tr())),
        );
      }
    } finally {
      if (mounted) {
        setState(() => _isSending = false);
      }
    }
  }

  void _scrollToBottom() {
    if (_scrollController.hasClients) {
      _scrollController.animateTo(
        0, // Since it's reversed, 0 is bottom
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOut,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final roomAsync = ref.watch(chatRoomProvider(widget.roomId));
    final messagesAsync = ref.watch(chatMessagesProvider(widget.roomId));
    final currentUserId = ref.watch(currentChatUserIdProvider);

    // Refresh unread state whenever messages change and I'm looking at it
    ref.listen(chatMessagesProvider(widget.roomId), (prev, next) {
      if (next is AsyncData && next.value!.isNotEmpty) {
        final lastMessage = next.value!.first;
        if (lastMessage.senderId != currentUserId) {
          _markAsRead();
        }
      }
    });

    return Scaffold(
      appBar: AppBar(
        title: roomAsync.when(
          data: (room) {
            if (room == null) return Text('chat.title'.tr());
            if (room.type == 'job_inquiry') {
              return Column(
                children: [
                  Text('chat.jobInquiry'.tr(namedArgs: {'title': room.jobTitle ?? ''})),
                  const Text('Job Inquiry', style: TextStyle(fontSize: 11, fontWeight: FontWeight.normal)),
                ],
              );
            }
            final isBuyer = currentUserId == room.buyerId;
            return Column(
              children: [
                Text(isBuyer ? 'chat.chatSeller'.tr() : 'chat.chatBuyer'.tr()),
                Text(
                  room.productTitle ?? '',
                  style: const TextStyle(fontSize: 12, fontWeight: FontWeight.normal),
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            );
          },
          loading: () => Text('chat.loading'.tr()),
          error: (e, stack) => Text('chat.error'.tr()),
        ),
        actions: [
          PopupMenuButton<String>(
            onSelected: (value) {
              if (value == 'block') _showBlockDialog();
              if (value == 'report') _showReportDialog();
            },
            itemBuilder: (context) => [
              PopupMenuItem(
                value: 'report',
                child: Row(
                  children: [
                    const Icon(Icons.report_problem_outlined, color: Colors.orange, size: 20),
                    const SizedBox(width: 8),
                    Text('safety.reportUser'.tr()),
                  ],
                ),
              ),
              PopupMenuItem(
                value: 'block',
                child: Row(
                  children: [
                    const Icon(Icons.block, color: Colors.red, size: 20),
                    const SizedBox(width: 8),
                    Text('safety.blockUser'.tr()),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
      body: Column(
        children: [
          // Product Context Card
          roomAsync.when(
            data: (room) {
              if (room == null) return const SizedBox.shrink();
              if (room.type == 'job_inquiry') {
                return InkWell(
                  onTap: () => context.push('/jobs/${room.jobId}'),
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    color: Colors.blue.shade50,
                    decoration: BoxDecoration(
                      border: Border(bottom: BorderSide(color: Colors.blue.shade200, width: 0.5)),
                    ),
                    child: Row(
                      children: [
                        Container(
                          width: 44,
                          height: 44,
                          decoration: BoxDecoration(
                            color: Colors.blue.shade100,
                            borderRadius: BorderRadius.circular(4),
                          ),
                          child: const Icon(Icons.work_outline, size: 20, color: Colors.blue),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                room.jobTitle ?? '',
                                style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                              const SizedBox(height: 2),
                              Text(
                                'chat.jobConversation'.tr(),
                                style: TextStyle(fontSize: 11, color: Colors.grey.shade600),
                              ),
                            ],
                          ),
                        ),
                        TextButton(
                          onPressed: () => context.push('/jobs/${room.jobId}'),
                          style: TextButton.styleFrom(
                            visualDensity: VisualDensity.compact,
                            padding: const EdgeInsets.symmetric(horizontal: 12),
                          ),
                          child: Text('chat.viewJob'.tr(), style: const TextStyle(fontSize: 12)),
                        ),
                      ],
                    ),
                  ),
                );
              }

              return InkWell(
                onTap: () => context.push('/marketplace/${room.productId}'),
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  color: Colors.grey.shade100,
                  decoration: BoxDecoration(
                    border: Border(bottom: BorderSide(color: Colors.grey.shade300, width: 0.5)),
                  ),
                  child: Row(
                    children: [
                      if (room.productImageUrl != null)
                        ClipRRect(
                          borderRadius: BorderRadius.circular(4),
                          child: Image.network(
                            room.productImageUrl!,
                            width: 44,
                            height: 44,
                            fit: BoxFit.cover,
                          ),
                        )
                      else
                        Container(
                          width: 44,
                          height: 44,
                          decoration: BoxDecoration(
                            color: Colors.grey.shade300,
                            borderRadius: BorderRadius.circular(4),
                          ),
                          child: const Icon(Icons.image, size: 20, color: Colors.grey),
                        ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              room.productTitle ?? '',
                              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                            const SizedBox(height: 2),
                            Text(
                              'chat.dealConversation'.tr(),
                              style: TextStyle(fontSize: 11, color: Colors.grey.shade600),
                            ),
                          ],
                        ),
                      ),
                      TextButton(
                        onPressed: () => context.push('/marketplace/deals/${room.dealId}'),
                        style: TextButton.styleFrom(
                          visualDensity: VisualDensity.compact,
                          padding: const EdgeInsets.symmetric(horizontal: 12),
                        ),
                        child: Text('chat.viewDeal'.tr(), style: const TextStyle(fontSize: 12)),
                      ),
                    ],
                  ),
                ),
              );
            },
            loading: () => const SizedBox.shrink(),
            error: (e, stack) => const SizedBox.shrink(),
          ),
          
          // Message List
          Expanded(
            child: messagesAsync.when(
              data: (messages) {
                if (messages.isEmpty) {
                  return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.chat_bubble_outline, size: 64, color: Colors.grey.shade300),
                        const SizedBox(height: 16),
                        Text(
                          'chat.startConversation'.tr(),
                          style: TextStyle(color: Colors.grey.shade500),
                        ),
                      ],
                    ),
                  );
                }
                return ListView.builder(
                  controller: _scrollController,
                  reverse: true,
                  padding: const EdgeInsets.only(bottom: 16, top: 8),
                  itemCount: messages.length,
                  itemBuilder: (context, index) {
                    final message = messages[index];
                    final isMe = message.senderId == currentUserId;
                    
                    // Show date header if needed
                    bool showDate = true;
                    if (index < messages.length - 1) {
                      final prevDate = messages[index + 1].createdAt;
                      if (DateUtils.isSameDay(message.createdAt, prevDate)) {
                        showDate = false;
                      }
                    }

                    return Column(
                      children: [
                        if (showDate) _buildDateHeader(message.createdAt),
                        ChatMessageBubble(
                          message: message,
                          isMe: isMe,
                        ),
                      ],
                    );
                  },
                );
              },
              loading: () => const Center(child: CircularProgressIndicator()),
              error: (e, stack) => Center(child: Text('chat.error'.tr())),
            ),
          ),
          
          // Input Area
          Container(
            padding: EdgeInsets.only(
              bottom: MediaQuery.of(context).padding.bottom + 8,
              top: 8,
              left: 8,
              right: 8,
            ),
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.05),
                  blurRadius: 4,
                  offset: const Offset(0, -2),
                ),
              ],
            ),
            child: roomAsync.when(
              data: (room) {
                if (room == null) return const SizedBox.shrink();
                final targetUserId = room.type == 'job_inquiry'
                    ? room.participants.firstWhere((id) => id != currentUserId, orElse: () => '')
                    : (currentUserId == room.buyerId ? (room.sellerId ?? '') : (room.buyerId ?? ''));
                if (targetUserId.isEmpty) return const SizedBox.shrink();
                final isBlocked = ref.watch(isUserBlockedProvider(targetUserId)).value ?? false;
                
                if (isBlocked) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    child: Text(
                      'safety.blockedInput'.tr(),
                      textAlign: TextAlign.center,
                      style: const TextStyle(color: Colors.grey, fontSize: 13),
                    ),
                  );
                }

                return Row(
                  children: [
                    IconButton(
                      icon: Icon(Icons.add_circle_outline, color: Colors.grey.shade600),
                      onPressed: () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('marketplace.comingSoon'.tr())),
                        );
                      },
                    ),
                    Expanded(
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        decoration: BoxDecoration(
                          color: Colors.grey.shade100,
                          borderRadius: BorderRadius.circular(24),
                          border: Border.all(color: Colors.grey.shade300),
                        ),
                        child: TextField(
                          controller: _textController,
                          decoration: InputDecoration(
                            hintText: 'chat.messagePlaceholder'.tr(),
                            border: InputBorder.none,
                            contentPadding: const EdgeInsets.symmetric(vertical: 10),
                          ),
                          maxLines: 4,
                          minLines: 1,
                          textInputAction: TextInputAction.send,
                          onSubmitted: (_) => _sendMessage(),
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    IconButton(
                      icon: _isSending 
                          ? const SizedBox(width: 24, height: 24, child: CircularProgressIndicator(strokeWidth: 2))
                          : Icon(Icons.send, color: Theme.of(context).primaryColor),
                      onPressed: _isSending ? null : _sendMessage,
                    ),
                  ],
                );
              },
              loading: () => const SizedBox.shrink(),
              error: (e, stack) => const SizedBox.shrink(),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDateHeader(DateTime date) {
    String dateStr;
    if (DateUtils.isSameDay(date, DateTime.now())) {
      dateStr = 'chat.today'.tr();
    } else if (DateUtils.isSameDay(date, DateTime.now().subtract(const Duration(days: 1)))) {
      dateStr = 'chat.yesterday'.tr();
    } else {
      dateStr = DateFormat('d MMMM yyyy').format(date);
    }

    return Container(
      margin: const EdgeInsets.symmetric(vertical: 16),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
      decoration: BoxDecoration(
        color: Colors.grey.shade300,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Text(
        dateStr,
        style: const TextStyle(fontSize: 10, color: Colors.black54),
      ),
    );
  }

  void _showBlockDialog() {
    final room = ref.read(chatRoomProvider(widget.roomId)).value;
    if (room == null) return;
    final currentUserId = ref.read(currentChatUserIdProvider);
    final targetUserId = room.type == 'job_inquiry'
        ? room.participants.firstWhere((id) => id != currentUserId, orElse: () => '')
        : (currentUserId == room.buyerId ? (room.sellerId ?? '') : (room.buyerId ?? ''));
    if (targetUserId.isEmpty) return;
    final targetName = room.type == 'job_inquiry' ? 'User' : (currentUserId == room.buyerId ? 'seller' : 'buyer');

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('safety.blockUserTitle'.tr(namedArgs: {'name': targetName})),
        content: Text('safety.blockUserMessage'.tr()),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('safety.cancel'.tr()),
          ),
          TextButton(
            onPressed: () async {
              if (currentUserId != null) {
                await ref.read(userSafetyRepositoryProvider).blockUser(
                      currentUserId: currentUserId,
                      targetUserId: targetUserId,
                    );
                if (mounted) {
                  Navigator.of(context).pop();
                  ref.invalidate(isUserBlockedProvider(targetUserId));
                }
              }
            },
            child: Text('safety.confirmBlock'.tr(), style: const TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );
  }

  void _showReportDialog() {
    final room = ref.read(chatRoomProvider(widget.roomId)).value;
    if (room == null) return;
    final currentUserId = ref.read(currentChatUserIdProvider);
    final targetUserId = room.type == 'job_inquiry'
        ? room.participants.firstWhere((id) => id != currentUserId, orElse: () => '')
        : (currentUserId == room.buyerId ? (room.sellerId ?? '') : (room.buyerId ?? ''));

    if (targetUserId.isEmpty) return;

    showModalBottomSheet(
      context: context,
      builder: (context) => SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              title: Text('safety.reportUserTitle'.tr(namedArgs: {'name': ''}), style: const TextStyle(fontWeight: FontWeight.bold)),
            ),
            ListTile(
              title: Text('safety.reportReasonFraud'.tr()),
              onTap: () => _submitReport(targetUserId, 'fraud'),
            ),
            ListTile(
              title: Text('safety.reportReasonInappropriate'.tr()),
              onTap: () => _submitReport(targetUserId, 'inappropriate'),
            ),
            ListTile(
              title: Text('safety.reportReasonSpam'.tr()),
              onTap: () => _submitReport(targetUserId, 'spam'),
            ),
            ListTile(
              title: Text('safety.reportReasonOther'.tr()),
              onTap: () => _submitReport(targetUserId, 'other'),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _submitReport(String targetUserId, String reason) async {
    final currentUserId = ref.read(currentChatUserIdProvider);
    if (currentUserId == null) return;

    final room = ref.read(chatRoomProvider(widget.roomId)).value;

    await ref.read(userSafetyRepositoryProvider).reportUser(
          reporterId: currentUserId,
          reportedUserId: targetUserId,
          reason: reason,
          chatRoomId: widget.roomId,
          productId: room?.productId,
          dealId: room?.dealId,
        );

    if (mounted) {
      Navigator.of(context).pop();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('safety.reportSubmitted'.tr())),
      );
    }
  }
}
