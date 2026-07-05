import 'package:flutter/material.dart';

class MatchingGamePage extends StatefulWidget {
  const MatchingGamePage({super.key});

  @override
  State<MatchingGamePage> createState() => _MatchingGamePageState();
}

class _MatchingGamePageState extends State<MatchingGamePage> {
  final Map<String, List<Map<String, String>>> categories = {
    'ผลไม้': [
      {'word': 'Apple', 'meaning': 'แอปเปิล'},
      {'word': 'Banana', 'meaning': 'กล้วย'},
      {'word': 'Orange', 'meaning': 'ส้ม'},
      {'word': 'Grapes', 'meaning': 'องุ่น'},
      {'word': 'Mango', 'meaning': 'มะม่วง'},
    ],
    'สัตว์': [
      {'word': 'Dog', 'meaning': 'สุนัข'},
      {'word': 'Cat', 'meaning': 'แมว'},
      {'word': 'Elephant', 'meaning': 'ช้าง'},
      {'word': 'Lion', 'meaning': 'สิงโต'},
      {'word': 'Tiger', 'meaning': 'เสือ'},
    ],
    'สิ่งของ': [
      {'word': 'Book', 'meaning': 'หนังสือ'},
      {'word': 'Car', 'meaning': 'รถยนต์'},
      {'word': 'Chair', 'meaning': 'เก้าอี้'},
      {'word': 'Table', 'meaning': 'โต๊ะ'},
      {'word': 'Phone', 'meaning': 'โทรศัพท์'},
    ],
    'สี': [
      {'word': 'Red', 'meaning': 'แดง'},
      {'word': 'Blue', 'meaning': 'น้ำเงิน'},
      {'word': 'Green', 'meaning': 'เขียว'},
      {'word': 'Yellow', 'meaning': 'เหลือง'},
      {'word': 'Black', 'meaning': 'ดำ'},
    ],
    'ยานพาหนะ': [
      {'word': 'Car', 'meaning': 'รถยนต์'},
      {'word': 'Bicycle', 'meaning': 'จักรยาน'},
      {'word': 'Bus', 'meaning': 'รถบัส'},
      {'word': 'Train', 'meaning': 'รถไฟ'},
      {'word': 'Airplane', 'meaning': 'เครื่องบิน'},
    ],
    'อาชีพ': [
      {'word': 'Doctor', 'meaning': 'หมอ'},
      {'word': 'Teacher', 'meaning': 'ครู'},
      {'word': 'Engineer', 'meaning': 'วิศวกร'},
      {'word': 'Nurse', 'meaning': 'พยาบาล'},
      {'word': 'Chef', 'meaning': 'เชฟ'}, 
    ],
    'กีฬา': [
      {'word': 'Football', 'meaning': 'ฟุตบอล'},
      {'word': 'Basketball', 'meaning': 'บาสเกตบอล'},
      {'word': 'Tennis', 'meaning': 'เทนนิส'},
      {'word': 'Swimming', 'meaning': 'ว่ายน้ำ'},
      {'word': 'Running', 'meaning': 'วิ่ง'},
    ],
    'สถานที่': [
      {'word': 'School', 'meaning': 'โรงเรียน'},
      {'word': 'Hospital', 'meaning': 'โรงพยาบาล'},
      {'word': 'Market', 'meaning': 'ตลาด'},
      {'word': 'Park', 'meaning': 'สวนสาธารณะ'},
      {'word': 'Library', 'meaning': 'ห้องสมุด'},
    ],
  };

  final Map<String, String> categoryEmojis = {
    'ผลไม้': '🍎',
    'สัตว์': '🐶',
    'สิ่งของ': '📚',
    'สี': '🎨',
    'ยานพาหนะ': '🚗',
    'อาชีพ': '👩‍⚕️',
    'กีฬา': '⚽',
    'สถานที่': '🏫',
  };

  List<Map<String, String>> wordPairs = [];
  List<String> items = [];
  String? firstSelected;
  List<String> matched = [];

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _selectCategory();
    });
  }

  Future<void> _selectCategory() async {
    final selected = await showDialog<String>(
      context: context,
      barrierDismissible: false,
      builder: (_) => SimpleDialog(
        backgroundColor: Colors.teal[50],
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: const Text(
          'เลือกหมวดหมู่',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        children: categories.keys.map((category) {
          final emoji = categoryEmojis[category] ?? '';
          return SimpleDialogOption(
            onPressed: () => Navigator.pop(context, category),
            child: Row(
              children: [
                Text(emoji, style: const TextStyle(fontSize: 28)),
                const SizedBox(width: 12),
                Text(
                  category,
                  style: const TextStyle(fontSize: 18),
                ),
              ],
            ),
          );
        }).toList(),
      ),
    );

    if (selected != null) {
      startGameWithCategory(selected);
    }
  }

  void startGameWithCategory(String category) {
    final selectedPairs = categories[category]!;

    setState(() {
      wordPairs = selectedPairs;
      items = [
        ...selectedPairs.map((e) => e['word']!),
        ...selectedPairs.map((e) => e['meaning']!),
      ];
      items.shuffle();
      matched.clear();
      firstSelected = null;
    });
  }

  void handleTap(String item) {
    if (matched.contains(item)) return;

    setState(() {
      if (firstSelected == null) {
        firstSelected = item;
      } else {
        final match = wordPairs.firstWhere(
          (pair) =>
              (pair['word'] == firstSelected && pair['meaning'] == item) ||
              (pair['meaning'] == firstSelected && pair['word'] == item),
          orElse: () => {},
        );

        if (match.isNotEmpty) {
          matched.addAll([firstSelected!, item]);
        }

        firstSelected = null;
      }

      if (matched.length == items.length) {
        Future.delayed(const Duration(milliseconds: 300), () {
          showDialog(
            context: context,
            builder: (_) => AlertDialog(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20)),
              title: const Text('เก่งมาก!'),
              content: const Text('คุณจับคู่คำศัพท์ทั้งหมดได้สำเร็จ 🎉'),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                    _selectCategory();
                  },
                  child: const Text('เล่นอีกครั้ง'),
                ),
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text('ปิด'),
                ),
              ],
            ),
          );
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final isReady = wordPairs.isNotEmpty;

    return Scaffold(
      backgroundColor: Colors.teal[50],
      appBar: AppBar(
        title: const Text('เกมจับคู่คำศัพท์'),
        backgroundColor: Colors.teal.shade700,
        elevation: 8,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(20),
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            tooltip: 'เลือกหมวดหมู่ใหม่',
            onPressed: _selectCategory,
          ),
        ],
      ),
      body: isReady
          ? Padding(
              padding: const EdgeInsets.all(12),
              child: GridView.count(
                crossAxisCount: 3,
                mainAxisSpacing: 16,
                crossAxisSpacing: 16,
                children: items.map((item) {
                  final isRevealed =
                      matched.contains(item) || firstSelected == item;

                  return GestureDetector(
                    onTap: () => handleTap(item),
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 350),
                      decoration: BoxDecoration(
                        gradient: isRevealed
                            ? LinearGradient(
                                colors: [
                                  Colors.teal.shade300,
                                  Colors.teal.shade100,
                                ],
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                              )
                            : LinearGradient(
                                colors: [
                                  Colors.grey.shade400,
                                  Colors.grey.shade200,
                                ],
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                              ),
                        borderRadius: BorderRadius.circular(16),
                        boxShadow: [
                          BoxShadow(
                            color: isRevealed
                                ? Colors.teal.shade200.withOpacity(0.6)
                                : Colors.black12,
                            blurRadius: 8,
                            offset: const Offset(2, 2),
                          ),
                        ],
                      ),
                      child: Center(
                        child: Text(
                          isRevealed ? item : '?',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w600,
                            color: isRevealed
                                ? Colors.teal.shade900
                                : Colors.grey.shade700,
                            shadows: [
                              Shadow(
                                color: Colors.black26,
                                blurRadius: 2,
                                offset: const Offset(1, 1),
                              ),
                            ],
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                  );
                }).toList(),
              ),
            )
          : const Center(
              child: CircularProgressIndicator(
                color: Colors.teal,
              ),
            ),
    );
  }
}
