import 'package:flutter_tts/flutter_tts.dart';

class TTSService {
  final FlutterTts _tts = FlutterTts();

  Future<void> speak(String text) async {
    await _tts.setLanguage("bn-BD");
    await _tts.setSpeechRate(0.4);
    await _tts.speak(text);
  }
}
