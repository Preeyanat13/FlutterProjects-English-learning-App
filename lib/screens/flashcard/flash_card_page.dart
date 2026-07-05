import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import '../../data/flash_card_data.dart';

class FlashCardPage extends StatefulWidget {
  final String selectedCategory;
  const FlashCardPage({super.key, required this.selectedCategory});

  @override
  State<FlashCardPage> createState() => _FlashCardPageState();
}

class _FlashCardPageState extends State<FlashCardPage> {
  late List<FlashCard> cardsInCategory;
  int _currentIndex = 0;
  bool _showMeaning = false;

  final FlutterTts flutterTts = FlutterTts();

  @override
  void initState() {
    super.initState();
    cardsInCategory = flashCards
        .where((card) => card.category == widget.selectedCategory)
        .toList();
  }

  @override
  void dispose() {
    flutterTts.stop();
    super.dispose();
  }

  Future<void> _speak(String text, {String langCode = "en-US"}) async {
    await flutterTts.setLanguage(langCode);
    await flutterTts.setPitch(1.0);
    await flutterTts.speak(text);
  }

  void _nextCard() {
    setState(() {
      _showMeaning = false;
      _currentIndex = (_currentIndex + 1) % cardsInCategory.length;
    });
  }

  void _previousCard() {
    setState(() {
      _showMeaning = false;
      _currentIndex =
          (_currentIndex - 1 + cardsInCategory.length) % cardsInCategory.length;
    });
  }

  void _flipCard() {
    setState(() {
      _showMeaning = !_showMeaning;
    });

    final card = cardsInCategory[_currentIndex];
    if (!_showMeaning) {
      _speak(card.word, langCode: "en-US");
    } else {
      _speak(card.meaning, langCode: "th-TH");
    }
  }

  @override
  Widget build(BuildContext context) {
    final card = cardsInCategory[_currentIndex];

    return Scaffold(
      backgroundColor: Colors.white,  // พื้นหลังสีขาว
      appBar: AppBar(
        title: Text(
          "📚 ${widget.selectedCategory}",
          style: const TextStyle(
            color: Colors.green,  // เปลี่ยนสีหัวข้อเป็นเขียวให้เด่นบนพื้นขาว
            fontWeight: FontWeight.bold,
            shadows: [
              Shadow(
                color: Colors.greenAccent,
                blurRadius: 10,
                offset: Offset(0, 0),
              ),
            ],
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
        foregroundColor: Colors.green,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            children: [
              Expanded(
                child: GestureDetector(
                  onTap: _flipCard,
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 400),
                    curve: Curves.easeInOut,
                    decoration: BoxDecoration(
                      color: const Color.fromARGB(255, 255, 255, 255), // การ์ดพื้นสีเขียวอ่อน เพื่อไม่ให้จืด
                      borderRadius: BorderRadius.circular(32),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.greenAccent.withOpacity(0.3),
                          blurRadius: 20,
                          spreadRadius: 2,
                          offset: const Offset(0, 0),
                        ),
                        BoxShadow(
                          color: Colors.green.withOpacity(0.2),
                          blurRadius: 15,
                          spreadRadius: 1,
                          offset: const Offset(0, 0),
                        ),
                      ],
                      border: Border.all(
                        color: Colors.greenAccent.shade200.withOpacity(0.8),
                        width: 1.5,
                      ),
                    ),
                    child: Center(
                      child: Padding(
                        padding: const EdgeInsets.all(24.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            if (card.imagePath != null)
                              Padding(
                                padding: const EdgeInsets.only(bottom: 24),
                                child: Image.asset(
                                  card.imagePath!,
                                  height: 120,
                                  fit: BoxFit.contain,
                                ),
                              ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Flexible(
                                  child: AnimatedSwitcher(
                                    duration: const Duration(milliseconds: 300),
                                    child: Text(
                                      _showMeaning ? card.meaning : card.word,
                                      key: ValueKey<bool>(_showMeaning),
                                      style: TextStyle(
                                        fontSize: 36,
                                        fontWeight: FontWeight.w700,
                                        color: _showMeaning
                                            ? Colors.green.shade900 // เขียวเข้มสำหรับคำแปล
                                            : Colors.green.shade800, // เขียวเข้มสำหรับคำศัพท์
                                        letterSpacing: 0.5,
                                        shadows: [
                                          Shadow(
                                            color: Colors.black.withOpacity(0.1),
                                            blurRadius: 1,
                                            offset: const Offset(0, 1),
                                          ),
                                        ],
                                      ),
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 12),
                                IconButton(
                                  icon: const Icon(Icons.volume_up),
                                  iconSize: 28,
                                  color: Colors.green.shade700,
                                  onPressed: () {
                                    if (_showMeaning) {
                                      _speak(card.meaning, langCode: "th-TH");
                                    } else {
                                      _speak(card.word, langCode: "en-US");
                                    }
                                  },
                                ),
                              ],
                            ),
                            const SizedBox(height: 14),
                            Text(
                              _showMeaning
                                  ? "แตะเพื่อกลับไปยังคำศัพท์"
                                  : "แตะเพื่อดูคำแปล",
                              style: TextStyle(
                                color: Colors.grey.shade700,
                                fontSize: 14,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 32),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ElevatedButton.icon(
                    onPressed: _previousCard,
                    icon: const Icon(Icons.arrow_back_ios_new_rounded),
                    label: const Text("ก่อนหน้า"),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green.shade700,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 22, vertical: 14),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      elevation: 6,
                      shadowColor: Colors.green.shade400,
                    ),
                  ),
                  ElevatedButton.icon(
                    onPressed: _nextCard,
                    icon: const Icon(Icons.arrow_forward_ios_rounded),
                    label: const Text("ถัดไป"),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green.shade400,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 24, vertical: 14),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      elevation: 6,
                      shadowColor: Colors.green.shade200,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              Text(
                "การ์ดที่ ${_currentIndex + 1} จาก ${cardsInCategory.length}",
                style: const TextStyle(
                  fontSize: 14,
                  color: Colors.black54,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
