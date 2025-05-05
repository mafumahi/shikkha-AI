import 'package:speech_to_text/speech_to_text.dart';

class SpeechService {
  final _speech = SpeechToText();

  Future<String> listen() async {
    bool available = await _speech.initialize();
    if (available) {
      await _speech.listen(localeId: "bn_BD");
      await Future.delayed(Duration(seconds: 5));
      _speech.stop();
      return _speech.lastRecognizedWords;
    } else {
      return "ভয়েস ইনপুট পাওয়া যায়নি";
    }
  }
}
