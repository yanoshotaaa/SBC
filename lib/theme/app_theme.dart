import 'package:flutter/material.dart';

class AppTheme {
  static const Color primaryColor = Color(0xFFF6F8FF);
  static const Color accentColor = Colors.amber;
  static const Color textColor = Colors.black;

  // カードのスタイル
  static BoxDecoration cardDecoration = BoxDecoration(
    color: Colors.white,
    borderRadius: BorderRadius.circular(10),
    boxShadow: [
      BoxShadow(
        color: Colors.black.withOpacity(0.06),
        blurRadius: 10,
        offset: const Offset(0, 4),
      ),
    ],
  );

  // アクションボタンのスタイル
  static ButtonStyle actionButtonStyle = ElevatedButton.styleFrom(
    backgroundColor: Colors.white,
    foregroundColor: Colors.black,
    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(10),
    ),
  );

  // テキストスタイル
  static const TextStyle headerStyle = TextStyle(
    fontSize: 22,
    fontWeight: FontWeight.bold,
    color: textColor,
  );

  static const TextStyle subHeaderStyle = TextStyle(
    fontSize: 20,
    fontWeight: FontWeight.bold,
    color: textColor,
  );

  static const TextStyle bodyStyle = TextStyle(
    fontSize: 16,
    color: textColor,
  );

  // レンジグリッドのスタイル
  static const Color raiseColor = Colors.red;
  static const Color raiseOrCallColor = Colors.yellow;
  static const Color raiseOrFoldColor = Colors.blue;
  static const Color callColor = Colors.green;
  static const Color foldColor = Colors.white;
}
