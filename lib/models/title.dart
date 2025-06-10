import 'package:flutter/material.dart';

class PlayerTitle {
  final String id;
  final String name;
  final String description;
  final IconData icon;
  final Color color;
  final bool isUnlocked;
  final DateTime? unlockedAt;
  final String category;
  final int requiredPoints;

  const PlayerTitle({
    required this.id,
    required this.name,
    required this.description,
    required this.icon,
    required this.color,
    this.isUnlocked = false,
    this.unlockedAt,
    required this.category,
    required this.requiredPoints,
  });

  static List<PlayerTitle> getDefaultTitles() {
    return [
      PlayerTitle(
        id: 'beginner',
        name: '初心者ポーカープレイヤー',
        description: 'ポーカーの世界へようこそ！',
        icon: Icons.emoji_emotions,
        color: Colors.blue,
        category: '基本',
        requiredPoints: 0,
        isUnlocked: true,
      ),
      PlayerTitle(
        id: 'gto_master',
        name: 'GTOマスター',
        description: 'GTO戦略を完璧に理解している',
        icon: Icons.psychology,
        color: Colors.purple,
        category: '戦略',
        requiredPoints: 1000,
      ),
      PlayerTitle(
        id: 'bluff_king',
        name: 'ブラフの王',
        description: '完璧なブラフで相手を翻弄する',
        icon: Icons.auto_awesome,
        color: Colors.orange,
        category: '戦術',
        requiredPoints: 2000,
      ),
      PlayerTitle(
        id: 'range_master',
        name: 'レンジマスター',
        description: '完璧なレンジ管理で勝利を導く',
        icon: Icons.trending_up,
        color: Colors.green,
        category: '戦略',
        requiredPoints: 1500,
      ),
      PlayerTitle(
        id: 'pot_control',
        name: 'ポットコントローラー',
        description: 'ポットサイズを完璧にコントロール',
        icon: Icons.attach_money,
        color: Colors.amber,
        category: '戦術',
        requiredPoints: 1800,
      ),
      PlayerTitle(
        id: 'tournament_king',
        name: 'トーナメントキング',
        description: 'トーナメントで圧倒的な実績を残す',
        icon: Icons.emoji_events,
        color: Colors.red,
        category: '実績',
        requiredPoints: 3000,
      ),
      PlayerTitle(
        id: 'cash_game_master',
        name: 'キャッシュゲームマスター',
        description: 'キャッシュゲームで安定した収益を上げる',
        icon: Icons.monetization_on,
        color: Colors.teal,
        category: '実績',
        requiredPoints: 2500,
      ),
      PlayerTitle(
        id: 'poker_pro',
        name: 'プロポーカープレイヤー',
        description: 'プロとして認められた実力者',
        icon: Icons.star,
        color: Colors.indigo,
        category: '実績',
        requiredPoints: 5000,
      ),
    ];
  }
}
