// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';
import 'package:poker_analyzer/main.dart';
import 'package:poker_analyzer/widgets/cards/playing_card.dart';

void main() {
  testWidgets('アプリの基本UIテスト', (WidgetTester tester) async {
    // アプリを起動
    await tester.pumpWidget(
      ChangeNotifierProvider(
        create: (_) => PokerAnalysisProvider(),
        child: const MyApp(),
      ),
    );

    // ヘッダーが表示されていることを確認
    expect(find.text('=SoftBank'), findsOneWidget);
    expect(find.text('🃏 テキサスホールデム\nハンド分析AI'), findsOneWidget);

    // アップロードセクションが表示されていることを確認
    expect(find.text('📁 ハンドデータをアップロード'), findsOneWidget);
    expect(find.text('データ読み込み'), findsOneWidget);
    expect(find.text('🎮 自動データ読み込み'), findsOneWidget);
  });

  testWidgets('カード表示のテスト', (WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: Column(
            children: const [
              PlayingCard(card: 'Ah'),
              PlayingCard(card: 'Kd'),
            ],
          ),
        ),
      ),
    );

    // カードが正しく表示されていることを確認
    expect(find.text('Ah'), findsOneWidget);
    expect(find.text('Kd'), findsOneWidget);
  });
}
