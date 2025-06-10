import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/app_settings_provider.dart';

class NotificationScreen extends StatelessWidget {
  const NotificationScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF6F8FF),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text(
          '通知',
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          Consumer<AppSettingsProvider>(
            builder: (context, provider, child) {
              if (provider.notifications.any((n) => !n['isRead'])) {
                return TextButton(
                  onPressed: () {
                    provider.markAllNotificationsAsRead();
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('すべての通知を既読にしました'),
                        duration: Duration(seconds: 2),
                      ),
                    );
                  },
                  child: const Text(
                    'すべて既読',
                    style: TextStyle(
                      color: Color(0xFF7C4DFF),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                );
              }
              return const SizedBox.shrink();
            },
          ),
        ],
      ),
      body: Consumer<AppSettingsProvider>(
        builder: (context, provider, child) {
          final notifications = provider.notifications;

          if (notifications.isEmpty) {
            return const Center(
              child: Text(
                '通知はありません',
                style: TextStyle(
                  color: Colors.grey,
                  fontSize: 16,
                ),
              ),
            );
          }

          return ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: notifications.length,
            itemBuilder: (context, index) {
              final notification = notifications[index];
              final time = notification['time'] as DateTime;
              final timeAgo = _getTimeAgo(time);

              return Dismissible(
                key: Key(notification['id'] as String),
                direction: DismissDirection.endToStart,
                background: Container(
                  alignment: Alignment.centerRight,
                  padding: const EdgeInsets.only(right: 20),
                  color: Colors.red,
                  child: const Icon(
                    Icons.delete,
                    color: Colors.white,
                  ),
                ),
                onDismissed: (direction) {
                  provider.deleteNotification(notification['id'] as String);
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: const Text('通知を削除しました'),
                      action: SnackBarAction(
                        label: '元に戻す',
                        onPressed: () {
                          provider.addNotification({
                            'title': notification['title'],
                            'message': notification['message'],
                            'type': notification['type'],
                          });
                        },
                      ),
                    ),
                  );
                },
                child: Container(
                  margin: const EdgeInsets.only(bottom: 12),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.06),
                        blurRadius: 8,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: ListTile(
                    contentPadding: const EdgeInsets.all(16),
                    leading: Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: _getNotificationColor(
                                notification['type'] as String)
                            .withOpacity(0.1),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Icon(
                        _getNotificationIcon(notification['type'] as String),
                        color: _getNotificationColor(
                            notification['type'] as String),
                      ),
                    ),
                    title: Row(
                      children: [
                        Expanded(
                          child: Text(
                            notification['title'] as String,
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                        ),
                        if (!(notification['isRead'] as bool))
                          Container(
                            width: 8,
                            height: 8,
                            decoration: const BoxDecoration(
                              color: Color(0xFF7C4DFF),
                              shape: BoxShape.circle,
                            ),
                          ),
                      ],
                    ),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 4),
                        Text(
                          notification['message'] as String,
                          style: TextStyle(
                            color: Colors.black.withOpacity(0.6),
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          timeAgo,
                          style: TextStyle(
                            color: Colors.black.withOpacity(0.4),
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                    onTap: () {
                      if (!(notification['isRead'] as bool)) {
                        provider.markNotificationAsRead(
                            notification['id'] as String);
                      }
                      // 通知の詳細を表示する機能
                      _showNotificationDetails(context, notification);
                    },
                  ),
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          context.read<AppSettingsProvider>().addTestNotification();
        },
        backgroundColor: const Color(0xFF7C4DFF),
        child: const Icon(Icons.add),
      ),
    );
  }

  void _showNotificationDetails(
      BuildContext context, Map<String, dynamic> notification) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(notification['title'] as String),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(notification['message'] as String),
            const SizedBox(height: 16),
            Row(
              children: [
                Icon(
                  _getNotificationIcon(notification['type'] as String),
                  color: _getNotificationColor(notification['type'] as String),
                  size: 16,
                ),
                const SizedBox(width: 8),
                Text(
                  _getNotificationTypeText(notification['type'] as String),
                  style: TextStyle(
                    color:
                        _getNotificationColor(notification['type'] as String),
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('閉じる'),
          ),
        ],
      ),
    );
  }

  String _getTimeAgo(DateTime time) {
    final now = DateTime.now();
    final difference = now.difference(time);

    if (difference.inDays > 0) {
      return '${difference.inDays}日前';
    } else if (difference.inHours > 0) {
      return '${difference.inHours}時間前';
    } else if (difference.inMinutes > 0) {
      return '${difference.inMinutes}分前';
    } else {
      return 'たった今';
    }
  }

  Color _getNotificationColor(String type) {
    switch (type) {
      case 'achievement':
        return const Color(0xFF7C4DFF);
      case 'ranking':
        return Colors.orange;
      case 'mission':
        return Colors.green;
      case 'system':
        return Colors.blue;
      default:
        return Colors.grey;
    }
  }

  IconData _getNotificationIcon(String type) {
    switch (type) {
      case 'achievement':
        return Icons.emoji_events;
      case 'ranking':
        return Icons.leaderboard;
      case 'mission':
        return Icons.flag;
      case 'system':
        return Icons.info;
      default:
        return Icons.notifications;
    }
  }

  String _getNotificationTypeText(String type) {
    switch (type) {
      case 'achievement':
        return '称号獲得';
      case 'ranking':
        return 'ランキング';
      case 'mission':
        return 'ミッション';
      case 'system':
        return 'システム';
      default:
        return 'その他';
    }
  }
}
