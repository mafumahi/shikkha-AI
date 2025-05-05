import 'package:flutter/material.dart';
import 'screens/home_screen.dart';

void main() {
  runApp(ShikkhaAIApp());
}

class ShikkhaAIApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ShikkhaAI',
      home: HomeScreen(),
    );
  }
}
