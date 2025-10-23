import 'package:flutter/material.dart';
import 'screens/quiz_screen.dart';

void main() {
  runApp(const AutismApp());
}

class AutismApp extends StatelessWidget {
  const AutismApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Autism Screening',
      theme: ThemeData(primarySwatch: Colors.indigo),
      home: const QuizScreen(),
    );
  }
}