import 'dart:math';
import 'package:flutter/material.dart';
import '../../models/vocab_item.dart';
import '../../models/quiz_question.dart';
import 'result_page.dart';

class QuizPage extends StatefulWidget {
  final VocabCategory category;
  const QuizPage({super.key, required this.category});

  @override
  State<QuizPage> createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> {
  final _rng = Random();
  late final List<QuizQuestion> _questions;
  int _index = 0;
  int _score = 0;
  int? _selected;

  @override
  void initState() {
    super.initState();
    _questions = _buildQuestions(widget.category.items, count: 10);
  }

  List<QuizQuestion> _buildQuestions(List<VocabItem> items, {int count = 10}) {
    final pool = List<VocabItem>.from(items);
    while (pool.length < 4) pool.addAll(items);

    List<QuizQuestion> qs = [];
    for (int i = 0; i < count; i++) {
      final isEnToTh = _rng.nextBool();
      final correct = pool[_rng.nextInt(items.length)];
      final distractors = <VocabItem>[];
      while (distractors.length < 3) {
        final pick = items[_rng.nextInt(items.length)];
        if (pick.en != correct.en && !distractors.any((d) => d.en == pick.en)) {
          distractors.add(pick);
        }
      }
      final rawOptions = [correct, ...distractors]..shuffle(_rng);
      final options = isEnToTh
          ? rawOptions.map((e) => e.th).toList()
          : rawOptions.map((e) => e.en).toList();
      final correctIndex = rawOptions.indexWhere((e) => e.en == correct.en);
      final prompt = isEnToTh ? 'แปลว่าอะไร: ${correct.en}' : 'คำว่าอะไร: ${correct.th}';
      final explain = '${correct.en} = ${correct.th}';
      qs.add(QuizQuestion(
        prompt: prompt,
        options: options,
        correctIndex: correctIndex,
        explain: explain,
      ));
    }
    return qs;
  }

  void _submitAnswer(int choice) {
    setState(() {
      _selected = choice;
      if (choice == _questions[_index].correctIndex) _score++;
    });
  }

  void _next() {
    if (_index < _questions.length - 1) {
      setState(() {
        _index++;
        _selected = null;
      });
    } else {
      Navigator.pushReplacement(context, MaterialPageRoute(
        builder: (_) => ResultPage(
          score: _score,
          total: _questions.length,
          onRestart: () {
            Navigator.pushReplacement(context, MaterialPageRoute(
              builder: (_) => QuizPage(category: widget.category),
            ));
          },
        ),
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    final q = _questions[_index];
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('แบบทดสอบ: ${widget.category.name}'),
        backgroundColor: theme.colorScheme.primary,
        elevation: 4,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
        child: Column(
          children: [
            _QuizProgress(index: _index, total: _questions.length, score: _score),
            const SizedBox(height: 20),
            Card(
              elevation: 3,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
              child: Padding(
                padding: const EdgeInsets.all(24),
                child: Text(
                  q.prompt,
                  style: theme.textTheme.headlineSmall?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: theme.colorScheme.primary,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: ListView.separated(
                itemCount: q.options.length,
                separatorBuilder: (_, __) => const SizedBox(height: 12),
                itemBuilder: (context, i) {
                  final selected = _selected == i;
                  final isCorrect = q.correctIndex == i;
                  final showResult = _selected != null;
                  Color? bg;
                  if (showResult) {
                    if (selected && isCorrect) bg = Colors.green.withOpacity(.2);
                    else if (selected && !isCorrect) bg = Colors.red.withOpacity(.2);
                    else if (isCorrect) bg = Colors.green.withOpacity(.15);
                  }
                  return Card(
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                    color: bg ?? theme.colorScheme.surface,
                    elevation: 2,
                    child: ListTile(
                      contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                      title: Text(
                        q.options[i],
                        style: TextStyle(
                          fontSize: 18,
                          color: theme.colorScheme.onSurface,
                        ),
                      ),
                      trailing: showResult
                          ? (isCorrect
                              ? Icon(Icons.check_circle, color: Colors.green.shade700, size: 28)
                              : (selected ? Icon(Icons.cancel, color: Colors.red.shade700, size: 28) : null))
                          : null,
                      onTap: showResult ? null : () => _submitAnswer(i),
                    ),
                  );
                },
              ),
            ),
            if (_selected != null)
              Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    'เฉลย: ${q.explain}',
                    style: theme.textTheme.bodyMedium?.copyWith(
                      fontStyle: FontStyle.italic,
                      color: theme.colorScheme.onBackground.withOpacity(0.7),
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 16),
                  FilledButton.icon(
                    icon: Icon(Icons.arrow_forward, color: theme.colorScheme.onPrimary),
                    label: Text(
                      _index == _questions.length - 1 ? 'สรุปผล' : 'ข้อต่อไป',
                      style: TextStyle(color: theme.colorScheme.onPrimary),
                    ),
                    style: FilledButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                      backgroundColor: theme.colorScheme.primary,
                      shadowColor: theme.colorScheme.primary.withOpacity(0.6),
                      elevation: 4,
                    ),
                    onPressed: _next,
                  ),
                ],
              ),
          ],
        ),
      ),
    );
  }
}

class _QuizProgress extends StatelessWidget {
  final int index;
  final int total;
  final int score;
  const _QuizProgress({required this.index, required this.total, required this.score});

  @override
  Widget build(BuildContext context) {
    final value = (index + 1) / total;
    final theme = Theme.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          'ข้อที่ ${index + 1} จาก $total • คะแนนปัจจุบัน: $score',
          textAlign: TextAlign.center,
          style: theme.textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.w600),
        ),
        const SizedBox(height: 8),
        ClipRRect(
          borderRadius: BorderRadius.circular(12),
          child: LinearProgressIndicator(
            value: value,
            minHeight: 12,
            backgroundColor: theme.colorScheme.surfaceVariant,
            color: theme.colorScheme.primary,
          ),
        ),
      ],
    );
  }
}
