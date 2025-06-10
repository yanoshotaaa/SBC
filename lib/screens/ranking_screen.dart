import 'package:flutter/material.dart';

class RankingScreen extends StatefulWidget {
  const RankingScreen({Key? key}) : super(key: key);

  @override
  State<RankingScreen> createState() => _RankingScreenState();
}

class _RankingScreenState extends State<RankingScreen> {
  List<Map<String, dynamic>> _getRankingData() {
    return [
      {
        'name': 'SHOOTER',
        'score': 1200,
        'winRate': 65.5,
        'hands': 150,
        'avatar': '🎯',
        'trend': 'up',
      },
      {
        'name': 'POKERKING',
        'score': 1100,
        'winRate': 62.3,
        'hands': 180,
        'avatar': '👑',
        'trend': 'up',
      },
      {
        'name': 'AI-BOT',
        'score': 950,
        'winRate': 58.7,
        'hands': 200,
        'avatar': '🤖',
        'trend': 'down',
      },
      {
        'name': 'PLAYER4',
        'score': 800,
        'winRate': 55.2,
        'hands': 120,
        'avatar': '🎮',
        'trend': 'up',
      },
      {
        'name': 'PLAYER5',
        'score': 700,
        'winRate': 52.8,
        'hands': 90,
        'avatar': '🎲',
        'trend': 'stable',
      },
    ];
  }

  @override
  Widget build(BuildContext context) {
    final ranking = _getRankingData();

    return Scaffold(
      backgroundColor: const Color(0xFFF6F8FF),
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 200,
            floating: false,
            pinned: true,
            backgroundColor: Colors.transparent,
            flexibleSpace: FlexibleSpaceBar(
              background: Container(
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [Color(0xFF7C4DFF), Color(0xFFB388FF)],
                  ),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const SizedBox(height: 40),
                    const Text(
                      '🏆 ランキング',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 16),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 8,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.2),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: const Text(
                        '今月のトッププレイヤー',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: _buildTopThreePlayers(ranking),
          ),
          SliverPadding(
            padding: const EdgeInsets.all(16),
            sliver: SliverList(
              delegate: SliverChildBuilderDelegate(
                (context, index) {
                  if (index >= ranking.length - 3) return null;
                  final player = ranking[index + 3];
                  return _buildRankingCard(player, index + 4);
                },
                childCount: ranking.length - 3,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTopThreePlayers(List<Map<String, dynamic>> ranking) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Column(
        children: [
          // 1位
          _buildTopPlayerCard(
            ranking[0],
            1,
            isFirst: true,
          ),
          const SizedBox(height: 16),
          // 2位
          _buildTopPlayerCard(
            ranking[1],
            2,
            scale: 0.95,
          ),
          const SizedBox(height: 16),
          // 3位
          _buildTopPlayerCard(
            ranking[2],
            3,
            scale: 0.9,
          ),
        ],
      ),
    );
  }

  Widget _buildTopPlayerCard(
    Map<String, dynamic> player,
    int rank, {
    double scale = 1.0,
    bool isFirst = false,
  }) {
    final rankColors = {
      1: [Color(0xFFFFD700), Color(0xFFFFA000)], // 金
      2: [Color(0xFFE0E0E0), Color(0xFFBDBDBD)], // 銀
      3: [Color(0xFFCD7F32), Color(0xFF8B4513)], // 銅
    };

    return Transform.scale(
      scale: scale,
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: rankColors[rank]!,
          ),
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.2),
              blurRadius: 10,
              offset: const Offset(0, 5),
            ),
          ],
        ),
        child: Row(
          children: [
            // ランク表示
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.3),
                shape: BoxShape.circle,
              ),
              child: Center(
                child: Text(
                  '$rank',
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            const SizedBox(width: 16),
            // プレイヤー情報
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (isFirst)
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.3),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: const Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(Icons.emoji_events,
                              color: Colors.white, size: 16),
                          SizedBox(width: 4),
                          Text(
                            'チャンピオン',
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                    ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      Text(
                        player['avatar'],
                        style: const TextStyle(fontSize: 24),
                      ),
                      const SizedBox(width: 8),
                      Text(
                        player['name'],
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 4,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.2),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Text(
                          '勝率 ${player['winRate']}%',
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 12,
                          ),
                        ),
                      ),
                      Text(
                        '${player['score']} pt',
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildRankingCard(Map<String, dynamic> player, int rank) {
    return Container(
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
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 8,
        ),
        leading: Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            color: _getRankColor(rank).withOpacity(0.1),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Center(
            child: Text(
              player['avatar'],
              style: const TextStyle(fontSize: 20),
            ),
          ),
        ),
        title: Row(
          children: [
            Text(
              player['name'],
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
            const SizedBox(width: 8),
            _buildTrendIcon(player['trend']),
          ],
        ),
        subtitle: Text(
          '勝率 ${player['winRate']}% | ${player['hands']}ハンド',
          style: TextStyle(
            color: Colors.black.withOpacity(0.6),
            fontSize: 12,
          ),
        ),
        trailing: Container(
          padding: const EdgeInsets.symmetric(
            horizontal: 12,
            vertical: 6,
          ),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                _getRankColor(rank),
                _getRankColor(rank).withOpacity(0.8),
              ],
            ),
            borderRadius: BorderRadius.circular(20),
          ),
          child: Text(
            '${player['score']} pt',
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTrendIcon(String trend) {
    IconData icon;
    Color color;

    switch (trend) {
      case 'up':
        icon = Icons.arrow_upward;
        color = Colors.green;
        break;
      case 'down':
        icon = Icons.arrow_downward;
        color = Colors.red;
        break;
      default:
        icon = Icons.remove;
        color = Colors.grey;
    }

    return Icon(icon, size: 16, color: color);
  }

  Color _getRankColor(int rank) {
    if (rank <= 3) return const Color(0xFF7C4DFF);
    if (rank <= 10) return const Color(0xFFB388FF);
    return const Color(0xFFE0E0E0);
  }
}
