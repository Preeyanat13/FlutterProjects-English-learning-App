import 'package:flutter/material.dart';
import 'video_player_page.dart';

class EnglishLessonPage extends StatelessWidget {
  const EnglishLessonPage({super.key});

  final List<Map<String, String>> clips = const [
    {"title": "บทเรียน 1: A-Z Alphabet", "url": "assets/videos/lesson14.mp4"},
    {"title": "บทเรียน 2: Verb to be", "url": "assets/videos/lesson1.mp4"},
    {"title": "บทเรียน 3: Present Simple", "url": "assets/videos/lesson2.mp4"},
    {"title": "บทเรียน 4: Present Continuous", "url": "assets/videos/lesson3.mp4"},
    {"title": "บทเรียน 5: Present Perfect", "url": "assets/videos/lesson4.mp4"},
    {"title": "บทเรียน 6: Present Perfect Continuous", "url": "assets/videos/lesson5.mp4"},
    {"title": "บทเรียน 7: Past Simple", "url": "assets/videos/lesson6.mp4"},
    {"title": "บทเรียน 8: Past Continuous", "url": "assets/videos/lesson7.mp4"},
    {"title": "บทเรียน 9: Past Perfect", "url": "assets/videos/lesson8.mp4"},
    {"title": "บทเรียน 10: Past Perfect Continuous", "url": "assets/videos/lesson9.mp4"},
    {"title": "บทเรียน 11: Future Simple", "url": "assets/videos/lesson10.mp4"},
    {"title": "บทเรียน 12: Future Continuous", "url": "assets/videos/lesson11.mp4"},
    {"title": "บทเรียน 13: Future Perfect", "url": "assets/videos/lesson12.mp4"},
    {"title": "บทเรียน 14: Future Perfect Continuous", "url": "assets/videos/lesson13.mp4"},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("คลิปสอนภาษาอังกฤษ"),
        backgroundColor: Colors.deepOrange,
      ),
      body: ListView.separated(
        padding: const EdgeInsets.all(16),
        itemCount: clips.length,
        separatorBuilder: (_, __) => const SizedBox(height: 12),
        itemBuilder: (context, index) {
          final clip = clips[index];
          return GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => VideoPlayerPage(
                    title: clip["title"]!,
                    url: clip["url"]!,
                  ),
                ),
              );
            },
            child: Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.deepOrange.shade50,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.deepOrange),
              ),
              child: Row(
                children: [
                  const Icon(Icons.play_circle_fill,
                      color: Colors.deepOrange, size: 40),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Text(
                      clip["title"]!,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
