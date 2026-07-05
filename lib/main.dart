import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'screens/home/welcome_page.dart';
import 'firebase_options.dart';
import 'package:firebase_core/firebase_core.dart'; 

//เข้าสู่ระบบ ให้กรอกชื่อ รหัสผ่าน และกดปุ่มลงทะเบียนเพื่อสร้างบัญชีใหม่ แล้วเข้าสู่ระบบด้วยบัญชีที่สร้างขึ้น 
//test@example.com   123456
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const VocabApp());
}

class VocabApp extends StatelessWidget {
  const VocabApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Vocabulary Learner',
      debugShowCheckedModeBanner: false,
      themeMode: ThemeMode.system,
      theme: ThemeData(
        useMaterial3: true,
        colorSchemeSeed: const Color(0xFF4F46E5), // สีหลัก (indigo)
        brightness: Brightness.light,
        textTheme: GoogleFonts.promptTextTheme(), // ✅ ใช้ฟอนต์ Prompt (ไทยสวยมาก)
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.deepPurple,
          foregroundColor: Colors.white,
          elevation: 0,
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.deepPurple,
            foregroundColor: Colors.white,
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
        ),
      ),
      darkTheme: ThemeData(
        useMaterial3: true,
        colorSchemeSeed: const Color(0xFF4F46E5),
        brightness: Brightness.dark,
        textTheme: GoogleFonts.promptTextTheme(ThemeData.dark().textTheme),
        appBarTheme: const AppBarTheme(
          backgroundColor: Color(0xFF1E1E2E),
          foregroundColor: Colors.white,
        ),
      ),
      home: const WelcomePage(), // ✅ หน้าเริ่มต้น
    );
  }
}
