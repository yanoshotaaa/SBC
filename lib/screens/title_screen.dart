import 'package:flutter/material.dart';
import '../models/title.dart';

class TitleScreen extends StatefulWidget {
  const TitleScreen({Key? key}) : super(key: key);

  @override
  State<TitleScreen> createState() => _TitleScreenState();
}

class _TitleScreenState extends State<TitleScreen> {
  late List<PlayerTitle> _titles;
  String _selectedCategory = 'すべて';
  PlayerTitle? _selectedTitle;

  @override
  void initState() {
    super.initState();
    _titles = PlayerTitle.getDefaultTitles();
    _selectedTitle = _titles.firstWhere((title) => title.isUnlocked);
  }

  List<String> get _categories {
    final categories = _titles.map((t) => t.category).toSet().toList();
    return ['すべて', ...categories];
  }

  List<PlayerTitle> get _filteredTitles {
    if (_selectedCategory == 'すべて') {
      return _titles;
    }
    return _titles.where((t) => t.category == _selectedCategory).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF6F8FF),
      appBar: AppBar(
        title: const Text('称号選択'),
        backgroundColor: Colors.transparent,
        elevation: 0,
        foregroundColor: Colors.black,
      ),
      body: Column(
        children: [
          // 現在選択中の称号
          if (_selectedTitle != null)
            Container(
              margin: const EdgeInsets.all(16),
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    _selectedTitle!.color.withOpacity(0.2),
                    _selectedTitle!.color.withOpacity(0.1),
                  ],
                ),
                borderRadius: BorderRadius.circular(16),
                border: Border.all(
                  color: _selectedTitle!.color.withOpacity(0.3),
                  width: 2,
                ),
              ),
              child: Row(
                children: [
                  Icon(
                    _selectedTitle!.icon,
                    size: 40,
                    color: _selectedTitle!.color,
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          _selectedTitle!.name,
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          _selectedTitle!.description,
                          style: TextStyle(
                            color: Colors.black.withOpacity(0.6),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

          // カテゴリーフィルター
          Container(
            height: 50,
            margin: const EdgeInsets.symmetric(horizontal: 16),
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: _categories.length,
              itemBuilder: (context, index) {
                final category = _categories[index];
                final isSelected = category == _selectedCategory;
                return Padding(
                  padding: const EdgeInsets.only(right: 8),
                  child: ChoiceChip(
                    label: Text(category),
                    selected: isSelected,
                    onSelected: (selected) {
                      if (selected) {
                        setState(() {
                          _selectedCategory = category;
                        });
                      }
                    },
                    backgroundColor: Colors.white,
                    selectedColor: const Color(0xFF7C4DFF).withOpacity(0.2),
                    labelStyle: TextStyle(
                      color:
                          isSelected ? const Color(0xFF7C4DFF) : Colors.black,
                      fontWeight:
                          isSelected ? FontWeight.bold : FontWeight.normal,
                    ),
                  ),
                );
              },
            ),
          ),

          // 称号リスト
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: _filteredTitles.length,
              itemBuilder: (context, index) {
                final title = _filteredTitles[index];
                final isSelected = title.id == _selectedTitle?.id;
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
                    border: isSelected
                        ? Border.all(
                            color: title.color,
                            width: 2,
                          )
                        : null,
                  ),
                  child: ListTile(
                    leading: Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: title.color.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Icon(
                        title.icon,
                        color: title.color,
                      ),
                    ),
                    title: Text(
                      title.name,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(title.description),
                        const SizedBox(height: 4),
                        if (!title.isUnlocked)
                          Text(
                            '必要ポイント: ${title.requiredPoints}',
                            style: TextStyle(
                              color: Colors.red.withOpacity(0.8),
                              fontSize: 12,
                            ),
                          ),
                      ],
                    ),
                    trailing: title.isUnlocked
                        ? IconButton(
                            icon: Icon(
                              isSelected
                                  ? Icons.check_circle
                                  : Icons.circle_outlined,
                              color: isSelected ? title.color : Colors.grey,
                            ),
                            onPressed: () {
                              setState(() {
                                _selectedTitle = title;
                              });
                            },
                          )
                        : const Icon(
                            Icons.lock,
                            color: Colors.grey,
                          ),
                    onTap: title.isUnlocked
                        ? () {
                            setState(() {
                              _selectedTitle = title;
                            });
                          }
                        : null,
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
