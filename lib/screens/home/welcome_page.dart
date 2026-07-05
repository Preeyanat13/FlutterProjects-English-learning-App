import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../loginScreen.dart';

class WelcomePage extends StatelessWidget {
  const WelcomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      body: Stack(
        children: [
          // Background Image with Gradient Overlay
          Positioned.fill(
            child: Image.asset(
              'assets/images/welcome2.png', // Your background image
              fit: BoxFit.cover,
            ),
          ),
          Positioned.fill(
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [const Color.fromARGB(255, 0, 14, 213).withOpacity(0.5), const Color.fromARGB(255, 0, 179, 255).withOpacity(0.5)],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
              ),
            ),
          ),

          // Main Content
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 32),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Spacer(flex: 2),

                  // Hero Image
                  SizedBox(
                    height: 160,
                    child: Image.asset('assets/images/1.png'), // Cute learning image
                  ),

                  const SizedBox(height: 24),

                  // Welcome Text with enhanced style
                  Text(
                    'ยินดีต้อนรับ!',
                    style: GoogleFonts.kanit(
                      textStyle: theme.textTheme.headlineMedium?.copyWith(
                        fontWeight: FontWeight.w800,
                        color: const Color.fromARGB(255, 255, 255, 255), // White text for contrast
                        shadows: [
                          Shadow(
                            blurRadius: 4.0,
                            color: Colors.black45,
                            offset: Offset(2.0, 2.0),
                          ),
                        ],
                      ),
                    ),
                    textAlign: TextAlign.center,
                  ),

                  const SizedBox(height: 12),

                  Text(
                    'เรียนรู้ภาษาอังกฤษแบบสนุก ๆ\nพร้อมแบบทดสอบท้าทายความรู้ของคุณ!',
                    style: GoogleFonts.kanit(
                      textStyle: theme.textTheme.bodyLarge?.copyWith(
                        color: const Color.fromARGB(255, 255, 255, 255).withOpacity(0.9), // Lighter text for readability
                        height: 1.4,
                        shadows: [
                          Shadow(
                            blurRadius: 4.0,
                            color: Colors.black45,
                            offset: Offset(2.0, 2.0),
                          ),
                        ],
                      ),
                    ),
                    textAlign: TextAlign.center,
                  ),

                  const Spacer(flex: 3),

                  // Start Button with custom color styling
                  SizedBox(
                    width: double.infinity,
                    child: FilledButton.icon(
                      icon: const Icon(Icons.arrow_forward),
                      label: const Text('เริ่มต้นใช้งาน'),
                      style: FilledButton.styleFrom(
                        backgroundColor: const Color.fromARGB(255, 40, 91, 179), // Blue accent button
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(vertical: 18),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(14),
                        ),
                        textStyle: GoogleFonts.kanit(fontSize: 18, fontWeight: FontWeight.w600),
                        elevation: 4,
                        shadowColor: Colors.black38,
                      ),
                      onPressed: () {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(builder: (_) => const LoginScreen()),
                        );
                      },
                    ),
                  ),

                  const SizedBox(height: 40),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

