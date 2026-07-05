import 'package:flutter/material.dart';
import '../../data/seed_data.dart';
import '../vocab_list_page.dart';
import '../quiz_page.dart';
import '../../loginScreen.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('เรียนคำศัพท์ภาษาอังกฤษ'),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          tooltip: 'กลับ',
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            tooltip: 'ออกจากระบบ',
            onPressed: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (_) => const LoginScreen()),
              );
            },
          ),
        ],
      ),

      // ✅ ห่อด้วย SingleChildScrollView
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 8),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
              child: Card(
                elevation: 3,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                color: theme.colorScheme.primaryContainer.withOpacity(0.85),
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Text(
                    'เลือกหมวดเพื่อเรียน หรือกดเริ่มแบบทดสอบจากหมวดที่เลือก',
                    style: theme.textTheme.bodyLarge?.copyWith(
                          fontWeight: FontWeight.w600,
                          color: theme.colorScheme.onPrimaryContainer,
                        ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ),

            // ✅ GridView แบบ shrinkWrap
            Padding(
              padding: const EdgeInsets.all(16),
              child: GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: kCategories.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 16,
                  crossAxisSpacing: 16,
                  childAspectRatio: 0.78, // ✅ ปรับใหม่ให้ tile สูงพอ
                ),
                itemBuilder: (context, i) => _CategoryTile(category: kCategories[i]),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _CategoryTile extends StatelessWidget {
  final category;
  const _CategoryTile({required this.category});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final primaryColor = theme.colorScheme.primary;

    return Material(
      elevation: 4,
      borderRadius: BorderRadius.circular(20),
      clipBehavior: Clip.antiAlias,
      color: theme.colorScheme.surfaceVariant,
      child: InkWell(
        onTap: () {
          Navigator.push(context, MaterialPageRoute(
            builder: (_) => VocabListPage(category: category),
          ));
        },
        child: Padding(
          padding: const EdgeInsets.all(14),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // ✅ Icon
              Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      primaryColor.withOpacity(0.7),
                      primaryColor,
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                      color: primaryColor.withOpacity(0.3),
                      blurRadius: 6,
                      offset: const Offset(0, 3),
                    )
                  ],
                ),
                padding: const EdgeInsets.all(14),
                child: Icon(
                  category.icon,
                  size: 40, // ✅ ลดขนาด icon
                  color: Colors.white,
                ),
              ),

              const SizedBox(height: 12),

              // ✅ ชื่อหมวดหมู่
              Text(
                category.name,
                textAlign: TextAlign.center,
                style: theme.textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.w700,
                  color: theme.colorScheme.onSurfaceVariant,
                  fontSize: 15, // ✅ ปรับขนาดตัวอักษร
                ),
              ),

              const Spacer(), // ✅ ดันปุ่มลงล่างสุด

              // ✅ ปุ่มแบบกะขนาดอัตโนมัติ
              SizedBox(
                height: 40,
                child: FilledButton.tonalIcon(
                  icon: const Icon(Icons.quiz_outlined, size: 18),
                  label: const Text('เริ่มแบบ'),
                  style: FilledButton.styleFrom(
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    textStyle: const TextStyle(fontSize: 13, fontWeight: FontWeight.w600),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14),
                    ),
                  ),
                  onPressed: () {
                    Navigator.push(context, MaterialPageRoute(
                      builder: (_) => QuizPage(category: category),
                    ));
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
