// lib/result_page.dart

import 'package:flutter/material.dart';
import 'home/home_page.dart';

class ResultPage extends StatelessWidget {
  final int score;
  final int total;
  final VoidCallback onRestart;

  const ResultPage({
    super.key,
    required this.score,
    required this.total,
    required this.onRestart,
  });

  @override
  Widget build(BuildContext context) {
    final percent = (score / total * 100).round();
    final passed = percent >= 60;

    return Scaffold(
      appBar: AppBar(title: const Text('สรุปผลแบบทดสอบ')),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(passed ? Icons.emoji_events : Icons.refresh, size: 84),
              const SizedBox(height: 16),
              Text('คุณได้ $score / $total คะแนน',
                  style: Theme.of(context).textTheme.headlineSmall),
              const SizedBox(height: 8),
              Text('คิดเป็น $percent%',
                  style: Theme.of(context).textTheme.titleMedium),
              const SizedBox(height: 24),
              Wrap(
                spacing: 12,
                children: [
                  FilledButton.icon(
                    icon: const Icon(Icons.replay),
                    label: const Text('ลองทำใหม่'),
                    onPressed: onRestart,
                  ),
                  OutlinedButton.icon(
                    icon: const Icon(Icons.home),
                    label: const Text('กลับหน้าหลัก'),
                    onPressed: () {
                      Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(
                          builder: (_) => const HomePage(),
                        ),
                        (route) => false,
                      );
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
