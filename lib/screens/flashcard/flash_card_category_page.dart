import 'package:flutter/material.dart';
import 'flash_card_page.dart';
import '../../data/flash_card_data.dart';

class FlashCardCategoryPage extends StatelessWidget {
  const FlashCardCategoryPage({super.key});

  // ฟังก์ชันแมปหมวดหมู่เป็นอิโมจิ
  String getEmojiForCategory(String category) {
    switch (category.toLowerCase()) {
      case 'ผลไม้':
        return '🍎';
      case 'สัตว์':
        return '🐶';
      case 'ของใช้':
        return '🛒';
      case 'สี':
        return '🎨';
      case 'ยานพาหนะ':
        return '🚗';
      case 'อาชีพ':
        return '👩‍⚕️';
      case 'กีฬา':
        return '🥅';
      case 'สถานที่':
        return '🏖️';
      default:
        return '📚';
    }
  }

  @override
  Widget build(BuildContext context) {
    final categories = flashCards.map((e) => e.category).toSet().toList();

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "🧠 เลือกหมวดหมู่แฟลชการ์ด",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        centerTitle: true,
        backgroundColor: const Color(0xFF66BB6A), // เขียวสดใส
        elevation: 4,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      backgroundColor: const Color(0xFFD0F4C5), // เขียวหวานอ่อนๆ
      body: ListView.builder(
        padding: const EdgeInsets.all(20),
        itemCount: categories.length,
        itemBuilder: (context, index) {
          final category = categories[index];
          final emoji = getEmojiForCategory(category);

          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: Container(
              decoration: BoxDecoration(
                color: const Color(0xFFE8F5E9), // เขียวอ่อนชัดเจน
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: Colors.green.withOpacity(0.2),
                    blurRadius: 12,
                    offset: const Offset(0, 6),
                  ),
                ],
              ),
              child: ListTile(
                contentPadding: const EdgeInsets.symmetric(
                  vertical: 16,
                  horizontal: 20,
                ),
                leading: Text(
                  emoji,
                  style: const TextStyle(fontSize: 28),
                ),
                title: Text(
                  category,
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF2E7D32), // เขียวเข้มอ่านชัด
                  ),
                ),
                trailing: const Icon(
                  Icons.arrow_forward_ios_rounded,
                  color: Color(0xFF66BB6A),
                  size: 20,
                ),
                onTap: () {
                  Navigator.push(
                    context,
                    PageRouteBuilder(
                      pageBuilder: (_, __, ___) =>
                          FlashCardPage(selectedCategory: category),
                      transitionsBuilder: (_, animation, __, child) {
                        return FadeTransition(
                          opacity: animation,
                          child: child,
                        );
                      },
                    ),
                  );
                },
              ),
            ),
          );
        },
      ),
    );
  }
}
