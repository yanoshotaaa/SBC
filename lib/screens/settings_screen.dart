import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/app_settings_provider.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF6F8FF),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text(
          '設定',
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Consumer<AppSettingsProvider>(
        builder: (context, provider, child) {
          return ListView(
            padding: const EdgeInsets.all(16),
            children: [
              _buildSection(
                'アカウント',
                [
                  _buildSettingsTile(
                    'プロフィール編集',
                    Icons.person,
                    onTap: () {
                      _showProfileEditDialog(context);
                    },
                  ),
                  _buildSettingsTile(
                    'プライバシー設定',
                    Icons.privacy_tip,
                    onTap: () {
                      _showPrivacySettingsDialog(context);
                    },
                  ),
                ],
              ),
              const SizedBox(height: 24),
              _buildSection(
                '通知設定',
                [
                  _buildSettingsTile(
                    'プッシュ通知',
                    Icons.notifications,
                    trailing: Switch(
                      value: provider.pushNotificationsEnabled,
                      onChanged: (value) {
                        provider.setPushNotificationsEnabled(value);
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(
                              value ? 'プッシュ通知を有効にしました' : 'プッシュ通知を無効にしました',
                            ),
                            duration: const Duration(seconds: 2),
                          ),
                        );
                      },
                      activeColor: const Color(0xFF7C4DFF),
                    ),
                  ),
                  _buildSettingsTile(
                    'メール通知',
                    Icons.email,
                    trailing: Switch(
                      value: provider.emailNotificationsEnabled,
                      onChanged: (value) {
                        provider.setEmailNotificationsEnabled(value);
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(
                              value ? 'メール通知を有効にしました' : 'メール通知を無効にしました',
                            ),
                            duration: const Duration(seconds: 2),
                          ),
                        );
                      },
                      activeColor: const Color(0xFF7C4DFF),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 24),
              _buildSection(
                'アプリ設定',
                [
                  _buildSettingsTile(
                    '言語設定',
                    Icons.language,
                    trailing: Text(
                      provider.language,
                      style: const TextStyle(
                        color: Colors.grey,
                      ),
                    ),
                    onTap: () {
                      _showLanguageSelectionDialog(context, provider);
                    },
                  ),
                  _buildSettingsTile(
                    'テーマ設定',
                    Icons.palette,
                    trailing: Text(
                      provider.theme,
                      style: const TextStyle(
                        color: Colors.grey,
                      ),
                    ),
                    onTap: () {
                      _showThemeSelectionDialog(context, provider);
                    },
                  ),
                ],
              ),
              const SizedBox(height: 24),
              _buildSection(
                'その他',
                [
                  _buildSettingsTile(
                    'ヘルプ・サポート',
                    Icons.help,
                    onTap: () {
                      _showHelpSupportDialog(context);
                    },
                  ),
                  _buildSettingsTile(
                    '利用規約',
                    Icons.description,
                    onTap: () {
                      _showTermsOfServiceDialog(context);
                    },
                  ),
                  _buildSettingsTile(
                    'プライバシーポリシー',
                    Icons.policy,
                    onTap: () {
                      _showPrivacyPolicyDialog(context);
                    },
                  ),
                  _buildSettingsTile(
                    'ログアウト',
                    Icons.logout,
                    textColor: Colors.red,
                    onTap: () {
                      _showLogoutConfirmationDialog(context);
                    },
                  ),
                ],
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _buildSection(String title, List<Widget> children) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 16, bottom: 8),
          child: Text(
            title,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Color(0xFF7C4DFF),
            ),
          ),
        ),
        Container(
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
          child: Column(
            children: children,
          ),
        ),
      ],
    );
  }

  Widget _buildSettingsTile(
    String title,
    IconData icon, {
    Widget? trailing,
    VoidCallback? onTap,
    Color? textColor,
  }) {
    return ListTile(
      leading: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: const Color(0xFF7C4DFF).withOpacity(0.1),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Icon(
          icon,
          color: textColor ?? const Color(0xFF7C4DFF),
        ),
      ),
      title: Text(
        title,
        style: TextStyle(
          color: textColor ?? Colors.black,
          fontWeight: FontWeight.w500,
        ),
      ),
      trailing: trailing,
      onTap: onTap,
    );
  }

  void _showProfileEditDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('プロフィール編集'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const CircleAvatar(
              radius: 40,
              backgroundColor: Color(0xFFE3E6F0),
              child: Icon(Icons.person, size: 40, color: Color(0xFF7C4DFF)),
            ),
            const SizedBox(height: 16),
            TextField(
              decoration: const InputDecoration(
                labelText: 'ユーザー名',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 8),
            TextField(
              decoration: const InputDecoration(
                labelText: 'メールアドレス',
                border: OutlineInputBorder(),
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('キャンセル'),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('プロフィールを更新しました'),
                  duration: Duration(seconds: 2),
                ),
              );
            },
            child: const Text('保存'),
          ),
        ],
      ),
    );
  }

  void _showPrivacySettingsDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('プライバシー設定'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SwitchListTile(
              title: const Text('プロフィールを公開'),
              value: true,
              onChanged: (value) {},
            ),
            SwitchListTile(
              title: const Text('ランキングに表示'),
              value: true,
              onChanged: (value) {},
            ),
            SwitchListTile(
              title: const Text('統計情報を共有'),
              value: false,
              onChanged: (value) {},
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

  void _showLanguageSelectionDialog(
      BuildContext context, AppSettingsProvider provider) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('言語設定'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            RadioListTile(
              title: const Text('日本語'),
              value: '日本語',
              groupValue: provider.language,
              onChanged: (value) {
                provider.setLanguage(value as String);
                Navigator.pop(context);
              },
            ),
            RadioListTile(
              title: const Text('English'),
              value: 'English',
              groupValue: provider.language,
              onChanged: (value) {
                provider.setLanguage(value as String);
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
    );
  }

  void _showThemeSelectionDialog(
      BuildContext context, AppSettingsProvider provider) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('テーマ設定'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            RadioListTile(
              title: const Text('ライト'),
              value: 'ライト',
              groupValue: provider.theme,
              onChanged: (value) {
                provider.setTheme(value as String);
                Navigator.pop(context);
              },
            ),
            RadioListTile(
              title: const Text('ダーク'),
              value: 'ダーク',
              groupValue: provider.theme,
              onChanged: (value) {
                provider.setTheme(value as String);
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
    );
  }

  void _showHelpSupportDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('ヘルプ・サポート'),
        content: const Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('よくある質問'),
            SizedBox(height: 8),
            Text('• アプリの使い方'),
            Text('• ポーカーの基本ルール'),
            Text('• 統計の見方'),
            Text('• 称号の獲得方法'),
            SizedBox(height: 16),
            Text('お問い合わせ'),
            SizedBox(height: 8),
            Text('support@poker-analyzer.com'),
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

  void _showTermsOfServiceDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('利用規約'),
        content: const SingleChildScrollView(
          child: Text(
            '利用規約の内容がここに表示されます。\n\n'
            '1. サービス利用条件\n'
            '2. 禁止事項\n'
            '3. 免責事項\n'
            '4. 知的財産権\n'
            '5. その他\n\n'
            '詳細は公式ウェブサイトをご覧ください。',
          ),
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

  void _showPrivacyPolicyDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('プライバシーポリシー'),
        content: const SingleChildScrollView(
          child: Text(
            'プライバシーポリシーの内容がここに表示されます。\n\n'
            '1. 収集する情報\n'
            '2. 情報の利用目的\n'
            '3. 情報の管理\n'
            '4. 情報の共有\n'
            '5. ユーザーの権利\n\n'
            '詳細は公式ウェブサイトをご覧ください。',
          ),
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

  void _showLogoutConfirmationDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('ログアウト'),
        content: const Text('ログアウトしてもよろしいですか？'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('キャンセル'),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              // ログアウト処理
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('ログアウトしました'),
                  duration: Duration(seconds: 2),
                ),
              );
            },
            child: const Text(
              'ログアウト',
              style: TextStyle(color: Colors.red),
            ),
          ),
        ],
      ),
    );
  }
}
