import 'package:flutter/material.dart';

class AppSettingsProvider extends ChangeNotifier {
  // 通知設定
  bool _pushNotificationsEnabled = true;
  bool _emailNotificationsEnabled = false;
  List<Map<String, dynamic>> _notifications = [];
  bool _hasUnreadNotifications = false;

  // アプリ設定
  String _language = '日本語';
  String _theme = 'ライト';
  bool _isDarkMode = false;

  // 通知関連のゲッター
  bool get pushNotificationsEnabled => _pushNotificationsEnabled;
  bool get emailNotificationsEnabled => _emailNotificationsEnabled;
  List<Map<String, dynamic>> get notifications => _notifications;
  bool get hasUnreadNotifications => _hasUnreadNotifications;

  // アプリ設定のゲッター
  String get language => _language;
  String get theme => _theme;
  bool get isDarkMode => _isDarkMode;

  // 通知の初期データ
  void initializeNotifications() {
    _notifications = [
      {
        'id': '1',
        'title': '新しい称号を獲得！',
        'message': '「GTOマスター」の称号を獲得しました',
        'time': DateTime.now().subtract(const Duration(minutes: 10)),
        'type': 'achievement',
        'isRead': false,
      },
      {
        'id': '2',
        'title': 'ランキング更新',
        'message': 'あなたのランキングが5位から3位に上昇しました',
        'time': DateTime.now().subtract(const Duration(hours: 1)),
        'type': 'ranking',
        'isRead': true,
      },
      {
        'id': '3',
        'title': 'ミッション達成',
        'message': '「初めてのポット獲得」ミッションを達成しました',
        'time': DateTime.now().subtract(const Duration(hours: 2)),
        'type': 'mission',
        'isRead': true,
      },
      {
        'id': '4',
        'title': 'システムメンテナンス',
        'message': 'システムメンテナンスを実施します（3/20 2:00-4:00）',
        'time': DateTime.now().subtract(const Duration(days: 1)),
        'type': 'system',
        'isRead': true,
      },
    ];
    _updateUnreadStatus();
    notifyListeners();
  }

  // 通知を既読にする
  void markNotificationAsRead(String notificationId) {
    final index = _notifications.indexWhere((n) => n['id'] == notificationId);
    if (index != -1) {
      _notifications[index]['isRead'] = true;
      _updateUnreadStatus();
      notifyListeners();
    }
  }

  // すべての通知を既読にする
  void markAllNotificationsAsRead() {
    for (var notification in _notifications) {
      notification['isRead'] = true;
    }
    _updateUnreadStatus();
    notifyListeners();
  }

  // 通知を削除する
  void deleteNotification(String notificationId) {
    _notifications.removeWhere((n) => n['id'] == notificationId);
    _updateUnreadStatus();
    notifyListeners();
  }

  // 新しい通知を追加する
  void addNotification(Map<String, dynamic> notification) {
    _notifications.insert(0, {
      ...notification,
      'id': DateTime.now().millisecondsSinceEpoch.toString(),
      'time': DateTime.now(),
      'isRead': false,
    });
    _updateUnreadStatus();
    notifyListeners();
  }

  // 未読状態を更新
  void _updateUnreadStatus() {
    _hasUnreadNotifications = _notifications.any((n) => !n['isRead']);
  }

  // プッシュ通知の設定を変更
  void setPushNotificationsEnabled(bool value) {
    _pushNotificationsEnabled = value;
    notifyListeners();
  }

  // メール通知の設定を変更
  void setEmailNotificationsEnabled(bool value) {
    _emailNotificationsEnabled = value;
    notifyListeners();
  }

  // 言語設定を変更
  void setLanguage(String value) {
    _language = value;
    notifyListeners();
  }

  // テーマ設定を変更
  void setTheme(String value) {
    _theme = value;
    _isDarkMode = value == 'ダーク';
    notifyListeners();
  }

  // ダミーの通知を追加（テスト用）
  void addTestNotification() {
    final types = ['achievement', 'ranking', 'mission', 'system'];
    final titles = ['新しい称号を獲得！', 'ランキング更新', 'ミッション達成', 'システムメンテナンス'];
    final messages = [
      '「ポーカーマスター」の称号を獲得しました',
      'あなたのランキングが10位から8位に上昇しました',
      '「初めてのブラフ成功」ミッションを達成しました',
      '新機能「ハンドレンジ分析」が追加されました'
    ];

    final random = DateTime.now().millisecondsSinceEpoch % 4;
    addNotification({
      'title': titles[random],
      'message': messages[random],
      'type': types[random],
    });
  }
}
