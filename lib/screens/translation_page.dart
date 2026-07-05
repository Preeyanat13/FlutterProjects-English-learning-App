import 'package:flutter/material.dart';
import 'package:translator/translator.dart';

class TranslationPage extends StatefulWidget {
  const TranslationPage({super.key});

  @override
  State<TranslationPage> createState() => _TranslationPageState();
}

class _TranslationPageState extends State<TranslationPage> {
  final TextEditingController _controller = TextEditingController();
  final GoogleTranslator _translator = GoogleTranslator();

  String _translatedText = '';

  bool _isLikelyValid(String text) {
    final trimmed = text.trim();
    if (trimmed.isEmpty) return false;
    final thaiPattern = RegExp(r'^[ก-๙0-9\s.,!?]+$');
    final engPattern = RegExp(r'^[A-Za-z0-9\s.,!?]+$');
    if (!(thaiPattern.hasMatch(trimmed) || engPattern.hasMatch(trimmed))) return false;
    final repeatedPattern = RegExp(r'(.)\1{4,}');
    if (repeatedPattern.hasMatch(trimmed)) return false;
    return true;
  }

  void _translateText() async {
    final inputText = _controller.text.trim();
    if (!_isLikelyValid(inputText)) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('ข้อความไม่ถูกต้อง / Invalid text')),
      );
      return;
    }
    try {
      var result = await _translator.translate(inputText, to: 'th');
      if (result.text == inputText) {
        result = await _translator.translate(inputText, to: 'en');
      }
      setState(() {
        _translatedText = result.text;
      });
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('เกิดข้อผิดพลาดในการแปล / Translation error')),
      );
    }
  }

  void _clearText() {
    _controller.clear();
    setState(() {
      _translatedText = '';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.deepPurple[50],
      appBar: AppBar(
        title: const Text('🌐 Translator'),
        backgroundColor: Colors.deepPurple,
        elevation: 4,
        actions: [
          IconButton(
            icon: const Icon(Icons.clear),
            tooltip: 'ล้างข้อความ / Clear',
            onPressed: _clearText,
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            // Input TextField
            Card(
              color: Colors.deepPurple[100],
              elevation: 3,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
              child: Padding(
                padding: const EdgeInsets.all(12),
                child: TextField(
                  controller: _controller,
                  decoration: const InputDecoration(
                    hintText: 'พิมพ์ข้อความที่นี่ / Enter text',
                    border: InputBorder.none,
                    prefixIcon: Icon(Icons.text_fields, color: Colors.deepPurple),
                  ),
                  maxLines: null,
                  style: const TextStyle(color: Colors.deepPurple),
                ),
              ),
            ),
            const SizedBox(height: 20),

            // Translate Button
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: _translateText,
                icon: const Icon(Icons.translate),
                label: const Text('แปล / Translate'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.deepPurple,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  textStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                  elevation: 4,
                ),
              ),
            ),
            const SizedBox(height: 24),

            // Result
            if (_translatedText.isNotEmpty)
              Card(
                color: Colors.deepPurple[700], // พื้นหลังเข้มขึ้น
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                elevation: 4,
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: SelectableText(
                    _translatedText,
                    style: const TextStyle(
                      fontSize: 20, // ตัวอักษรใหญ่ขึ้น
                      fontWeight: FontWeight.bold, // ตัวอักษรหนาขึ้น
                      color: Colors.yellowAccent, // สีตัวอักษรคอนทราสต์สูง
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
