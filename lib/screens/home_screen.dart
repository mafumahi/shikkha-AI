import 'package:flutter/material.dart';
import '../services/tts_service.dart';
import '../services/speech_service.dart';
import '../services/tflite_service.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final tts = TTSService();
  final speech = SpeechService();
  final ai = TFLiteService();
  String response = "AI প্রস্তুত!";

  @override
  void initState() {
    super.initState();
    ai.initModel();
  }

  Future<void> handleVoice() async {
    setState(() {
      response = "শুনছি...";
    });
    String question = await speech.listen();
    String context = "পানি তিনটি অবস্থায় থাকে — কঠিন, তরল ও গ্যাস। বরফ হলো কঠিন অবস্থা।";
    String answer = ai.getAnswer(question, context);
    await tts.speak(answer);
    setState(() {
      response = answer;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("ShikkhaAI")),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          children: [
            Text(response, style: TextStyle(fontSize: 24)),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: handleVoice,
              child: Text("প্রশ্ন করুন"),
            ),
          ],
        ),
      ),
    );
  }
}
