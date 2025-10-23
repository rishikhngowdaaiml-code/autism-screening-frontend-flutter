import 'package:flutter/material.dart';
import '../services/api_service.dart';
import '../widgets/question_card.dart';

class QuizScreen extends StatefulWidget {
  const QuizScreen({super.key});

  @override
  State<QuizScreen> createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  final List<String> questions = [
    "Avoids eye contact?",
    "Speech delayed?",
    "Repetitive behaviors?",
    "Struggles with emotions?",
    "Prefers to play alone?",
    "Intense interests?",
    "Resistant to change?",
    "Unusual sensory responses?",
    "Struggles with social cues?",
    "Limited gestures?"
  ];

  List<int> answers = List.filled(10, 0);
  double? result;
  bool loading = false;

  void submitAnswers() async {
    setState(() => loading = true);
    try {
      double score = await ApiService.submitAnswers(answers);
      setState(() {
        result = score;
        loading = false;
      });
    } catch (e) {
      setState(() => loading = false);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Error connecting to backend")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Autism Screening")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Expanded(
              child: ListView.builder(
                itemCount: questions.length,
                itemBuilder: (context, index) {
                  return QuestionCard(
                    question: questions[index],
                    onChanged: (val) => answers[index] = val,
                  );
                },
              ),
            ),
            ElevatedButton(
              onPressed: loading ? null : submitAnswers,
              child: loading
                  ? const CircularProgressIndicator()
                  : const Text("Submit"),
            ),
            if (result != null)
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  "Estimated likelihood: ${result!.toStringAsFixed(2)}%",
                  style: const TextStyle(fontSize: 18),
                ),
              )
          ],
        ),
      ),
    );
  }
}