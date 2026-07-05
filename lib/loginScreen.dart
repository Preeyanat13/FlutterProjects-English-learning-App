import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'authenticationService.dart';
import 'screens/home/intro_page.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen>
    with SingleTickerProviderStateMixin {
  String email = '';
  String password = '';
  bool obscure = true;

  late AnimationController _controller;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();
    _controller =
        AnimationController(vsync: this, duration: const Duration(seconds: 2))
          ..forward();
    _fadeAnimation =
        CurvedAnimation(parent: _controller, curve: Curves.easeInOut);
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: Stack(
        children: [
          // Blue → Sky Blue Gradient Background
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Color(0xFF0D47A1), // Dark Blue
                  Color(0xFF1976D2), // Medium Blue
                  Color(0xFF42A5F5), // Light Blue
                  Color(0xFF81D4FA), // Sky Blue
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
          ),

          // Circle Decorations
          Positioned(
            top: -80,
            left: -60,
            child: _circle(220, Colors.white.withOpacity(0.15)),
          ),
          Positioned(
            bottom: -100,
            right: -50,
            child: _circle(260, Colors.white.withOpacity(0.12)),
          ),
          Positioned(
            top: 200,
            right: -100,
            child: _circle(180, Colors.white.withOpacity(0.08)),
          ),

          // White Rounded Login Card
          Center(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
              child: FadeTransition(
                opacity: _fadeAnimation,
                child: Container(
                  width: size.width * 0.9,
                  padding: const EdgeInsets.all(28),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(30),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.2),
                        blurRadius: 20,
                        offset: const Offset(0, 8),
                      ),
                    ],
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      // Icon
                      ScaleTransition(
                        scale: _fadeAnimation,
                        child: const Icon(Icons.lock_outline_rounded,
                            size: 72, color: Colors.blue),
                      ),
                      const SizedBox(height: 16),
                      Text(
                        'Login',
                        style: GoogleFonts.poppins(
                          fontSize: 28,
                          fontWeight: FontWeight.w700,
                          color: Colors.blue.shade900,
                          letterSpacing: 1.2,
                        ),
                      ),
                      const SizedBox(height: 32),

                      // Email field
                      _inputField(
                        label: "Email",
                        hint: "example@email.com",
                        icon: Icons.email_outlined,
                        onChanged: (v) => setState(() => email = v),
                      ),
                      const SizedBox(height: 20),

                      // Password field
                      _inputField(
                        label: "Password",
                        hint: "Enter your password",
                        icon: Icons.lock_outline,
                        obscure: obscure,
                        suffix: IconButton(
                          icon: Icon(
                            obscure ? Icons.visibility_off : Icons.visibility,
                            color: Colors.blueGrey,
                          ),
                          onPressed: () =>
                              setState(() => obscure = !obscure),
                        ),
                        onChanged: (v) => setState(() => password = v),
                      ),
                      const SizedBox(height: 32),

                      // Login button
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: () {
                            AuthenticationService()
                                .login(email, password)
                                .then((success) {
                              if (success) {
                                Navigator.of(context).pushReplacement(
                                  MaterialPageRoute(
                                    builder: (_) => const IntroPage(),
                                  ),
                                );
                              } else {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text(
                                        'Login failed. Please try again.'),
                                  ),
                                );
                              }
                            });
                          },
                          style: ElevatedButton.styleFrom(
                            padding: const EdgeInsets.symmetric(vertical: 16),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(18),
                            ),
                            backgroundColor: Colors.blue,
                          ),
                          child: Text(
                            'Login',
                            style: GoogleFonts.poppins(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),

                      const SizedBox(height: 18),

                      // Register button
                      TextButton(
                        onPressed: () {
                          AuthenticationService()
                              .register(email, password)
                              .then((success) {
                            final msg = success
                                ? 'Registration successful.'
                                : 'Registration failed.';
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text(msg)),
                            );
                          });
                        },
                        child: Text(
                          "Don't have an account? Register",
                          style: GoogleFonts.poppins(
                            color: Colors.blue.shade700,
                            fontSize: 14,
                            decoration: TextDecoration.underline,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Reusable input field
  Widget _inputField({
    required String label,
    required String hint,
    required IconData icon,
    bool obscure = false,
    Widget? suffix,
    Function(String)? onChanged,
  }) {
    return TextFormField(
      obscureText: obscure,
      onChanged: onChanged,
      style: GoogleFonts.poppins(color: Colors.black87),
      decoration: InputDecoration(
        labelText: label,
        labelStyle: GoogleFonts.poppins(color: Colors.blueGrey),
        hintText: hint,
        hintStyle: const TextStyle(color: Colors.black26),
        prefixIcon: Icon(icon, color: Colors.blue),
        suffixIcon: suffix,
        filled: true,
        fillColor: Colors.grey.shade100,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: const BorderSide(color: Colors.blue, width: 1.5),
        ),
      ),
    );
  }

  // Circle decoration
  Widget _circle(double size, Color color) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: color,
      ),
    );
  }
}
