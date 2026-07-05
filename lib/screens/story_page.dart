import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;
import 'package:flutter_tts/flutter_tts.dart'; // ✅ ใช้แทน dart:html

// ================== หน้าเลือกนิทาน ==================
class StorySelectionPage extends StatelessWidget {
  const StorySelectionPage({super.key});

  final List<Map<String, dynamic>> stories = const [
    {
      'title': 'The Little Rabbit',
      'image': 'assets/images/story1.webp',
      'content': [
        "Once upon a time, there was a little rabbit named Fluffy.",
        "Fluffy loved to play in the forest and hop around with his friends.",
        "One sunny day, he met a friendly turtle named Toby.",
        "They decided to explore the forest together.",
        "Fluffy learned that slow and steady can also be fun.",
        "From that day on, Fluffy and Toby became best friends.",
        "They played together every day and shared many adventures."
      ],
      'translation': [
        "กาลครั้งหนึ่งมีลูกกระต่ายตัวน้อยชื่อฟลัฟฟี่",
        "ฟลัฟฟี่ชอบเล่นในป่าและกระโดดเล่นกับเพื่อน ๆ ของเขา",
        "วันหนึ่งแดดส่องสว่าง เขาได้พบเต่าที่เป็นมิตรชื่อโทบี้",
        "พวกเขาตัดสินใจสำรวจป่าด้วยกัน",
        "ฟลัฟฟี่เรียนรู้ว่าการทำสิ่งต่าง ๆ อย่างช้า ๆ และมั่นคงก็สนุกได้เหมือนกัน",
        "ตั้งแต่นั้น ฟลัฟฟี่และโทบี้ก็กลายเป็นเพื่อนสนิท",
        "พวกเขาเล่นด้วยกันทุกวันและมีผจญภัยมากมาย"
      ],
      'videoUrl': 'assets/videos/story1.mp4'
    },
    {
      'title': 'The Clever Fox',
      'image': 'assets/images/story2.jpg',
      'content': [
        "Once there was a clever fox named Felix.",
        "Felix wanted to eat some delicious grapes in the vineyard.",
        "He jumped and jumped but the grapes were too high.",
        "Felix thought for a while and came up with a smart plan.",
        "He found a long stick to knock the grapes down.",
        "Finally, he enjoyed the sweet grapes happily.",
        "Felix realized that thinking creatively can solve problems."
      ],
      'translation': [
        "ครั้งหนึ่งมีสุนัขจิ้งจอกฉลาดชื่อเฟลิกซ์",
        "เฟลิกซ์อยากกินองุ่นหวาน ๆ ในสวนองุ่น",
        "เขากระโดดแล้วกระโดดอีก แต่ก็เอื้อมองุ่นไม่ถึง",
        "เฟลิกซ์คิดอยู่สักพักและวางแผนอย่างฉลาด",
        "เขาหาไม้ยาวมาเคาะองุ่นให้ตกลงมา",
        "ในที่สุดเขาก็ได้กินองุ่นหวานอย่างมีความสุข",
        "เฟลิกซ์เรียนรู้ว่าการคิดสร้างสรรค์ช่วยแก้ปัญหาได้"
      ],
      'videoUrl': 'assets/videos/story2.mp4'
    },
    {
      'title': 'The Brave Little Bird',
      'image': 'assets/images/story3.webp',
      'content': [
        "There was once a little bird who wanted to fly high.",
        "Other birds told him it was too dangerous.",
        "One day, he decided to try anyway.",
        "He flapped his wings as hard as he could.",
        "He soared into the sky and felt free.",
        "The little bird realized that courage makes dreams come true."
      ],
      'translation': [
        "กาลครั้งหนึ่งมีนกตัวเล็กที่อยากบินให้สูง",
        "นกตัวอื่นบอกว่ามันอันตรายเกินไป",
        "วันหนึ่งเขาตัดสินใจลองอยู่ดี",
        "เขากระพือปีกสุดแรง",
        "เขาลอยขึ้นไปบนท้องฟ้าและรู้สึกอิสระ",
        "นกน้อยเรียนรู้ว่าความกล้าทำให้ความฝันเป็นจริง"
      ],
      'videoUrl': 'assets/videos/story3.mp4'
    },
    {
      'title': 'The Honest Woodcutter',
      'image': 'assets/images/story4.webp',
      'content': [
        "A woodcutter once dropped his axe into the river.",
        "He was very sad and didn’t know what to do.",
        "A kind fairy appeared and offered to help.",
        "She brought a golden axe, but the woodcutter said it was not his.",
        "Then she brought a silver axe, but he refused again.",
        "Finally, she gave him his real axe.",
        "The fairy rewarded him with all three axes for his honesty."
      ],
      'translation': [
        "กาลครั้งหนึ่งคนตัดไม้ทำขวานตกลงในแม่น้ำ",
        "เขาเสียใจมากและไม่รู้จะทำอย่างไร",
        "นางฟ้าใจดีปรากฏตัวและเสนอตัวช่วย",
        "เธอนำขวานทองมาให้ แต่คนตัดไม้บอกว่าไม่ใช่ของเขา",
        "จากนั้นเธอก็นำขวานเงินมา แต่เขาก็ปฏิเสธอีก",
        "สุดท้ายเธอจึงนำขวานจริงของเขามาให้",
        "นางฟ้าจึงให้รางวัลแก่เขาด้วยขวานทั้งสามเล่มเพราะความซื่อสัตย์"
      ],
      'videoUrl': 'assets/videos/story4.mp4'
    },
    {
      'title': 'The Lion and the Mouse',
      'image': 'assets/images/story5.webp',
      'content': [
        "One day, a lion was sleeping in the forest.",
        "A little mouse ran over his paw and woke him up.",
        "The lion caught the mouse and wanted to eat him.",
        "The mouse begged, promising to help the lion one day.",
        "Later, the lion was trapped in a hunter’s net.",
        "The mouse came and gnawed the net until the lion was free.",
        "The lion thanked the mouse and they became friends."
      ],
      'translation': [
        "วันหนึ่งสิงโตกำลังนอนหลับในป่า",
        "หนูน้อยวิ่งผ่านอุ้งเท้าของเขาและทำให้เขาตื่น",
        "สิงโตจับหนูได้และอยากจะกินมัน",
        "หนูขอร้องโดยสัญญาว่าวันหนึ่งจะช่วยสิงโต",
        "ต่อมา สิงโตติดอยู่ในตาข่ายของพราน",
        "หนูมากัดตาข่ายจนสิงโตเป็นอิสระ",
        "สิงโตขอบคุณหนูและพวกเขาก็กลายเป็นเพื่อนกัน"
      ],
      'videoUrl': 'assets/videos/story5.mp4'
    },
    {
      'title': 'The Tortoise and the Hare',
      'image': 'assets/images/story6.jpeg',
      'content': [
        "A hare once boasted about how fast he could run.",
        "He challenged the tortoise to a race.",
        "The hare ran ahead quickly and decided to take a nap.",
        "The tortoise walked slowly but steadily.",
        "When the hare woke up, the tortoise had already reached the finish line.",
        "The hare learned that slow and steady wins the race."
      ],
      'translation': [
        "ครั้งหนึ่งกระต่ายโม้ว่าเขาวิ่งได้เร็วแค่ไหน",
        "เขาท้าทายเต่าให้แข่งวิ่ง",
        "กระต่ายวิ่งนำไปไกลแล้วตัดสินใจนอนพัก",
        "เต่าเดินช้า ๆ แต่มั่นคง",
        "เมื่อกระต่ายตื่น เต่าก็ถึงเส้นชัยแล้ว",
        "กระต่ายได้เรียนรู้ว่าช้าแต่มั่นคงชนะการแข่งขัน"
      ],
      'videoUrl': 'assets/videos/story6.mp4'
    },
    {
      'title': 'The Ant and the Grasshopper',
      'image': 'assets/images/story7.jpg',
      'content': [
        "In the summer, the grasshopper sang and played.",
        "The ant worked hard to store food for the winter.",
        "The grasshopper laughed at the ant for working so hard.",
        "When winter came, the grasshopper had no food.",
        "He went to the ant and asked for help.",
        "The ant shared a little food but reminded him to work next time.",
        "The grasshopper learned the value of hard work and preparation."
      ],
      'translation': [
        "ในฤดูร้อน ตั๊กแตนร้องเพลงและเล่นสนุก",
        "มดทำงานหนักเก็บสะสมอาหารสำหรับฤดูหนาว",
        "ตั๊กแตนหัวเราะเยาะมดที่ทำงานหนัก",
        "เมื่อฤดูหนาวมาถึง ตั๊กแตนไม่มีอาหาร",
        "เขาไปหามดและขอความช่วยเหลือ",
        "มดแบ่งอาหารเล็กน้อยให้ แต่เตือนให้เขาทำงานครั้งหน้า",
        "ตั๊กแตนได้เรียนรู้คุณค่าของความขยันและการเตรียมตัว"
      ],
      'videoUrl': 'assets/videos/story7.mp4'
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("เลือกนิทาน"),
        backgroundColor: Colors.orangeAccent,
      ),
      body: Padding(
        padding: const EdgeInsets.all(12),
        child: GridView.builder(
          itemCount: stories.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 12,
            mainAxisSpacing: 12,
            childAspectRatio: 0.75,
          ),
          itemBuilder: (context, index) {
            return GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => StoryPage(
                      story: stories[index]['content'],
                      translation: stories[index]['translation'],
                      title: stories[index]['title'],
                      videoUrl: stories[index]['videoUrl'],
                    ),
                  ),
                );
              },
              child: Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                elevation: 6,
                color: Colors.orange[50],
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    ClipRRect(
                      borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
                      child: Image.asset(
                        stories[index]['image'],
                        height: 120,
                        width: double.infinity,
                        fit: BoxFit.cover,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8),
                      child: Text(
                        stories[index]['title'],
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.deepOrange,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

// ================== หน้าอ่านนิทาน ==================
class StoryPage extends StatefulWidget {
  final List<String> story;
  final List<String> translation;
  final String title;
  final String videoUrl;

  const StoryPage({
    super.key,
    required this.story,
    required this.translation,
    required this.title,
    required this.videoUrl,
  });

  @override
  State<StoryPage> createState() => _StoryPageState();
}

class _StoryPageState extends State<StoryPage> {
  int currentIndex = 0;
  late stt.SpeechToText _speech;
  late FlutterTts _flutterTts; // ✅ ใช้แทน dart:html
  bool isListening = false;
  String userSpeech = "";
  bool showTranslation = false;

  late VideoPlayerController _videoController;
  bool isVideoReady = false;

  @override
  void initState() {
    super.initState();
    _speech = stt.SpeechToText();
    _flutterTts = FlutterTts(); // ✅

    _videoController = VideoPlayerController.network(widget.videoUrl)
      ..initialize().then((_) {
        setState(() {
          isVideoReady = true;
        });
      });
  }

  @override
  void dispose() {
    _videoController.dispose();
    super.dispose();
  }

  // ✅ แก้ฟังก์ชันนี้
  void _playExampleVoice() async {
    final sentence = widget.story[currentIndex];
    await _flutterTts.setLanguage("en-US");
    await _flutterTts.setSpeechRate(0.8);
    await _flutterTts.speak(sentence);
  }

  void _startListening() async {
    bool available = await _speech.initialize();
    if (available) {
      setState(() => isListening = true);
      _speech.listen(
        onResult: (result) {
          setState(() {
            userSpeech = result.recognizedWords;
          });
        },
        listenMode: stt.ListenMode.dictation,
      );
    }
  }

  void _stopListening() {
    setState(() => isListening = false);
    _speech.stop();
  }

  List<TextSpan> _highlightedText() {
    List<String> targetWords = widget.story[currentIndex].split(' ');
    List<String> userWords = userSpeech.split(' ');

    List<TextSpan> spans = [];
    for (int i = 0; i < targetWords.length; i++) {
      Color color = Colors.black;
      if (i < userWords.length) {
        color = (targetWords[i].toLowerCase() == userWords[i].toLowerCase())
            ? Colors.green
            : Colors.red;
      }
      spans.add(TextSpan(
        text: targetWords[i] + ' ',
        style: TextStyle(
          color: color,
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
      ));
    }
    return spans;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        backgroundColor: Colors.orangeAccent,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (isVideoReady) ...[
              ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: AspectRatio(
                  aspectRatio: _videoController.value.aspectRatio,
                  child: VideoPlayer(_videoController),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IconButton(
                    icon: Icon(
                      _videoController.value.isPlaying
                          ? Icons.pause_circle
                          : Icons.play_circle_fill,
                      size: 40,
                      color: Colors.deepOrange,
                    ),
                    onPressed: () {
                      setState(() {
                        _videoController.value.isPlaying
                            ? _videoController.pause()
                            : _videoController.play();
                      });
                    },
                  ),
                ],
              ),
              const SizedBox(height: 20),
            ],
            RichText(
              text: TextSpan(children: _highlightedText()),
            ),
            if (showTranslation) ...[
              const SizedBox(height: 10),
              Text(
                widget.translation[currentIndex],
                style: const TextStyle(
                  fontSize: 18,
                  color: Colors.blueAccent,
                  fontStyle: FontStyle.italic,
                ),
              )
            ],
            const SizedBox(height: 20),
            Wrap(
              spacing: 12,
              runSpacing: 10,
              children: [
                ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.orangeAccent,
                  ),
                  onPressed: _playExampleVoice,
                  icon: const Icon(Icons.volume_up),
                  label: const Text("ฟังตัวอย่าง"),
                ),
                ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                    backgroundColor:
                        isListening ? Colors.redAccent : Colors.greenAccent,
                  ),
                  onPressed: isListening ? _stopListening : _startListening,
                  icon: Icon(isListening ? Icons.mic : Icons.mic_none),
                  label: Text(isListening ? "หยุดฟัง" : "เริ่มพูด"),
                ),
                ElevatedButton.icon(
                  style:
                      ElevatedButton.styleFrom(backgroundColor: Colors.blueAccent),
                  onPressed: () {
                    setState(() {
                      userSpeech = "";
                    });
                    if (isListening) _stopListening();
                    _startListening();
                  },
                  icon: const Icon(Icons.refresh),
                  label: const Text("พูดใหม่"),
                ),
                ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.purpleAccent),
                  onPressed: () {
                    setState(() {
                      showTranslation = !showTranslation;
                    });
                  },
                  icon: const Icon(Icons.translate),
                  label: Text(showTranslation ? "ซ่อนคำแปล" : "แสดงคำแปล"),
                ),
              ],
            ),
            const SizedBox(height: 20),
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.circular(12),
              ),
              child: Text(
                "คุณพูด: $userSpeech",
                style: const TextStyle(fontSize: 18),
              ),
            ),
            const Spacer(),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.deepOrange,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  textStyle: const TextStyle(
                      fontSize: 18, fontWeight: FontWeight.bold),
                ),
                onPressed: () {
                  if (currentIndex < widget.story.length - 1) {
                    setState(() {
                      currentIndex++;
                      userSpeech = "";
                    });
                  }
                },
                child: const Text("ถัดไป"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
