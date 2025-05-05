import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:tflite_flutter/tflite_flutter.dart';

class TFLiteService {
  late Interpreter _interpreter;
  late Map<String, int> _wordIndex;
  late List<String> _reverseIndex;

  Future<void> initModel() async {
    _interpreter = await Interpreter.fromAsset('model.tflite');
    String jsonStr = await rootBundle.loadString('assets/tokenizer.json');
    final Map<String, dynamic> tokenizerMap = json.decode(jsonStr);
    _wordIndex = Map<String, int>.from(tokenizerMap['config']['word_index']);
    _reverseIndex = List.filled(_wordIndex.length + 1, '');
    _wordIndex.forEach((word, idx) {
      if (idx < _reverseIndex.length) _reverseIndex[idx] = word;
    });
  }

  List<int> tokenize(String text) {
    final words = text.trim().split(' ');
    return words.map((w) => _wordIndex[w] ?? _wordIndex["<OOV>"]!).toList();
  }

  String getAnswer(String question, String context) {
    final inputText = "$question [SEP] $context";
    List<int> inputTokens = tokenize(inputText);
    if (inputTokens.length > 50) inputTokens = inputTokens.sublist(0, 50);
    while (inputTokens.length < 50) inputTokens.add(0);

    var input = [inputTokens];
    var output = List.generate(1, (_) => List.filled(5, 0)).cast<List<int>>();
    _interpreter.run(input, output);

    return output[0].map((id) => _reverseIndex[id]).join(" ");
  }
}
