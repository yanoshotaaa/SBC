import 'package:flutter/material.dart';
import '../models/title.dart';
import 'title_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late PlayerTitle _currentTitle;

  @override
  void initState() {
    super.initState();
    _currentTitle =
        PlayerTitle.getDefaultTitles().firstWhere((title) => title.isUnlocked);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF6F8FF),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(bottom: 8),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const Text('=SoftBank',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 22,
                              color: Colors.black)),
                      Row(
                        children: [
                          // 称号アイコン
                          IconButton(
                            icon: Container(
                              padding: const EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                color: _currentTitle.color.withOpacity(0.1),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Icon(
                                _currentTitle.icon,
                                color: _currentTitle.color,
                              ),
                            ),
                            onPressed: () async {
                              final result = await Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const TitleScreen(),
                                ),
                              );
                              if (result != null && result is PlayerTitle) {
                                setState(() {
                                  _currentTitle = result;
                                });
                              }
                            },
                          ),
                          // 設定アイコン
                          IconButton(
                            icon:
                                const Icon(Icons.settings, color: Colors.black),
                            onPressed: () {
                              // 設定画面へのナビゲーション
                            },
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                // ... existing code ...
              ],
            ),
          ),
        ),
      ),
    );
  }
}
