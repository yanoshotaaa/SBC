class GameStats {
  final int totalHands;
  final double winRate;
  final double avgPot;
  final double aggression;

  GameStats({
    required this.totalHands,
    required this.winRate,
    required this.avgPot,
    required this.aggression,
  });

  factory GameStats.fromJson(Map<String, dynamic> json) {
    return GameStats(
      totalHands: json['total_hands'] ?? 0,
      winRate: (json['win_rate'] ?? 0.0).toDouble(),
      avgPot: (json['avg_pot'] ?? 0.0).toDouble(),
      aggression: (json['aggression'] ?? 0.0).toDouble(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'total_hands': totalHands,
      'win_rate': winRate,
      'avg_pot': avgPot,
      'aggression': aggression,
    };
  }
}
