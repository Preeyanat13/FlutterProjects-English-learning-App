import 'package:flutter/material.dart';
import 'home_page.dart';
import '../flashcard/flash_card_category_page.dart';
import '../translation_page.dart';
import '../english/english_lesson_page.dart';
import '../matching_game_page.dart';
import '../story_page.dart';
import 'welcome_page.dart';

class IntroPage extends StatelessWidget {
  const IntroPage({super.key});

  final bool isThai = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Gradient Background
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [const Color.fromARGB(255, 255, 255, 255), const Color.fromARGB(255, 255, 255, 255),const Color.fromARGB(255, 255, 255, 255)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // Header
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                      icon: const Icon(Icons.arrow_back, color: Color.fromARGB(255, 0, 46, 161)),
                      tooltip: 'กลับ',
                      onPressed: () => Navigator.pop(context),
                    ),
                    Text(
                      "เลือกหมวดหมู่",
                      style: TextStyle(
                        color: const Color.fromARGB(255, 0, 9, 181),
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        shadows: [
                          Shadow(
                            color: Colors.black26,
                            blurRadius: 4,
                            offset: Offset(1, 2),
                          ),
                        ],
                      ),
                    ),
                    IconButton(
                      icon: const Icon(Icons.logout, color: Color.fromARGB(255, 0, 18, 158)),
                      tooltip: 'ออกจากระบบ',
                      onPressed: () {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(builder: (_) => const WelcomePage()),
                        );
                      },
                    ),
                  ],
                ),
                const SizedBox(height: 32),

                // Category Buttons
                _buildCategoryButton(
                  context,
                  icon: Icons.menu_book_rounded,
                  title: "คำศัพท์",
                  gradient: LinearGradient(
                    colors: [Colors.indigo.shade500, const Color.fromARGB(255, 184, 196, 255)],
                  ),
                  onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => const HomePage()),
                  ),
                ),
                const SizedBox(height: 16),
                _buildCategoryButton(
                  context,
                  icon: Icons.style_outlined,
                  title: "แฟลชการ์ด",
                  gradient: LinearGradient(
                    colors: [Colors.green.shade600, const Color.fromARGB(255, 190, 255, 193)],
                  ),
                  onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => const FlashCardCategoryPage()),
                  ),
                ),
                const SizedBox(height: 16),
                _buildCategoryButton(
                  context,
                  icon: Icons.ondemand_video,
                  title: isThai ? "คลิปสอนภาษาอังกฤษ" : "English Lesson Videos",
                  gradient: LinearGradient(
                    colors: [Colors.orange.shade600, const Color.fromARGB(255, 250, 219, 171)],
                  ),
                  onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => EnglishLessonPage()),
                  ),
                ),
                const SizedBox(height: 16),
                _buildCategoryButton(
                  context,
                  icon: Icons.g_translate,
                  title: isThai ? "แปลภาษา" : "Translator",
                  gradient: LinearGradient(
                    colors: [Colors.purple.shade700, const Color.fromARGB(255, 245, 188, 255)],
                  ),
                  onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => TranslationPage()),
                  ),
                ),
                const SizedBox(height: 16),
                _buildCategoryButton(
                  context,
                  icon: Icons.auto_stories,
                  title: isThai ? "อ่านนิทาน" : "Story Reader",
                  gradient: LinearGradient(
                    colors: [Colors.pink.shade400, const Color.fromARGB(255, 255, 196, 216)],
                  ),
                  onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => const StorySelectionPage()),
                  ),
                ),
                const SizedBox(height: 16),
                _buildCategoryButton(
                  context,
                  icon: Icons.videogame_asset_rounded,
                  title: "เกมจับคู่คำศัพท์",
                  gradient: LinearGradient(
                    colors: [Colors.teal.shade600, const Color.fromARGB(255, 158, 255, 245)],
                  ),
                  onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => const MatchingGamePage()),
                  ),
                ),
                const SizedBox(height: 32),

                // Footer Text
                Center(
                  child: Text(
                    "พร้อมเรียนรู้ไปด้วยกัน!",
                    style: TextStyle(
                      fontSize: 18,
                      fontStyle: FontStyle.italic,
                      color: Colors.white.withOpacity(0.9),
                      shadows: [
                        Shadow(
                          color: Colors.black38,
                          blurRadius: 4,
                          offset: Offset(1, 2),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildCategoryButton(
    BuildContext context, {
    required IconData icon,
    required String title,
    required LinearGradient gradient,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(24),
      child: Container(
        decoration: BoxDecoration(
          gradient: gradient,
          borderRadius: BorderRadius.circular(24),
          boxShadow: [
            BoxShadow(
              color: Colors.black26,
              blurRadius: 12,
              offset: Offset(2, 6),
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
          child: Row(
            children: [
              Icon(icon, size: 36, color: Colors.white),
              const SizedBox(width: 20),
              Expanded(
                child: Text(
                  title,
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
              const Icon(Icons.arrow_forward_ios, color: Colors.white70, size: 20),
            ],
          ),
        ),
      ),
    );
  }
}
