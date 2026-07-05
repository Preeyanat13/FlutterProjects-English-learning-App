import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;
import '../../models/vocab_item.dart';
import 'quiz_page.dart';

class VocabListPage extends StatefulWidget {
  final VocabCategory category;
  const VocabListPage({super.key, required this.category});

  @override
  State<VocabListPage> createState() => _VocabListPageState();
}

class _VocabListPageState extends State<VocabListPage> {
  final FlutterTts flutterTts = FlutterTts();
  late stt.SpeechToText speech;
  Map<int, Color> cardColors = {}; // เก็บสีของแต่ละ Card

  @override
  void initState() {
    super.initState();
    speech = stt.SpeechToText();
  }

  Future<void> _speak(String text, String language) async {
    await flutterTts.setLanguage(language);
    await flutterTts.setPitch(1.1);
    await flutterTts.setSpeechRate(language == "en-US" ? 0.45 : 0.5);
    await flutterTts.speak(text);
  }

  Future<void> _listenAndCheck(int index, String correctWord) async {
    bool available = await speech.initialize();
    if (!available) return;

    await speech.listen(
      listenFor: const Duration(seconds: 5),
      localeId: 'en_US',
      onResult: (val) {
        final spoken = val.recognizedWords.toLowerCase().trim();
        final correct = correctWord.toLowerCase().trim();
        setState(() {
          if (spoken == correct) {
            cardColors[index] = Colors.green.shade300;
          } else {
            cardColors[index] = Colors.red.shade300;
          }
        });
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      appBar: AppBar(
        title: Text(
          'คำศัพท์หมวด: ${widget.category.name}',
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.deepPurple,
        foregroundColor: Colors.white,
        centerTitle: true,
        elevation: 6,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(20),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        icon: const Icon(Icons.quiz),
        label: const Text('ทำแบบทดสอบ'),
        backgroundColor: Colors.deepPurple,
        foregroundColor: Colors.white,
        elevation: 4,
        onPressed: () => Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => QuizPage(category: widget.category),
          ),
        ),
      ),
      body: ListView.separated(
        padding: const EdgeInsets.fromLTRB(16, 16, 16, 96),
        itemCount: widget.category.items.length,
        separatorBuilder: (_, __) => const SizedBox(height: 16),
        itemBuilder: (context, i) {
          final item = widget.category.items[i];
          return Card(
            elevation: 6,
            color: cardColors[i] ?? Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            shadowColor: Colors.deepPurple.withOpacity(0.25),
            child: InkWell(
              borderRadius: BorderRadius.circular(20),
              onLongPress: () {
                Clipboard.setData(
                    ClipboardData(text: '${item.en} - ${item.th}'));
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('คัดลอกคำศัพท์เรียบร้อยแล้ว')),
                );
              },
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _ColorTileOrEmoji(item: item),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '${i + 1}. ${item.en}',
                            style: const TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.w600,
                              color: Colors.deepPurple,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            item.th,
                            style: const TextStyle(
                              fontSize: 18,
                              color: Colors.black87,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Row(
                            children: [
                              ElevatedButton.icon(
                                icon: const Icon(Icons.volume_up, size: 18),
                                label: const Text('EN'),
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.indigo.shade50,
                                  foregroundColor: Colors.indigo.shade800,
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 12, vertical: 8),
                                  textStyle: const TextStyle(fontSize: 13),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  elevation: 0,
                                ),
                                onPressed: () async {
                                  await _speak(item.en, "en-US");
                                },
                              ),
                              
                              const SizedBox(width: 8),
                              ElevatedButton.icon(
                                icon: const Icon(Icons.volume_up_outlined,
                                    size: 18),
                                label: const Text('TH'),
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.green.shade50,
                                  foregroundColor: Colors.green.shade800,
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 12, vertical: 8),
                                  textStyle: const TextStyle(fontSize: 13),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  elevation: 0,
                                ),
                                onPressed: () async {
                                  await _speak(item.th, "th-TH");
                                },
                              ),
                              const SizedBox(width: 8),
                              ElevatedButton.icon(
                                icon: const Icon(Icons.mic, size: 18),
                                label: const Text('พูด'),
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.blue.shade50,
                                  foregroundColor: Colors.blue.shade800,
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 12, vertical: 8),
                                  textStyle: const TextStyle(fontSize: 13),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  elevation: 0,
                                ),
                                onPressed: () async {
                                  await _listenAndCheck(i, item.en);
                                },
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

class _ColorTileOrEmoji extends StatelessWidget {
  final VocabItem item;
  const _ColorTileOrEmoji({required this.item});

  @override
  Widget build(BuildContext context) {
    if (item.colorSwatch != null) {
      final border = Theme.of(context).colorScheme.outlineVariant;
      return Container(
        width: 56,
        height: 56,
        decoration: BoxDecoration(
          color: item.colorSwatch,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(color: border, width: 1.2),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 4,
              offset: const Offset(2, 2),
            ),
          ],
        ),
      );
    }
    return Container(
      width: 56,
      height: 56,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(14),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 4,
            offset: const Offset(2, 2),
          ),
        ],
      ),
      child: Text(item.emoji, style: const TextStyle(fontSize: 32)),
    );
  }
}
