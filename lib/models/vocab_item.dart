import 'package:flutter/material.dart';

class VocabItem {
  final String emoji;
  final String en;
  final String th;
  final Color? colorSwatch;

  const VocabItem({
    required this.emoji,
    required this.en,
    required this.th,
    this.colorSwatch,
  });
}

class VocabCategory {
  final String id;
  final String name;
  final IconData icon;
  final List<VocabItem> items;

  const VocabCategory({
    required this.id,
    required this.name,
    required this.icon,
    required this.items,
  });
}
