class QuizQuestion {
  final String prompt;
  final List<String> options;
  final int correctIndex;
  final String explain;

  QuizQuestion({
    required this.prompt,
    required this.options,
    required this.correctIndex,
    required this.explain,
  });
}
