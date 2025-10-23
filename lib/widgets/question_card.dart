import 'package:flutter/material.dart';

class QuestionCard extends StatefulWidget {
  final String question;
  final Function(int) onChanged;

  const QuestionCard({super.key, required this.question, required this.onChanged});

  @override
  State<QuestionCard> createState() => _QuestionCardState();
}

class _QuestionCardState extends State<QuestionCard> {
  int selected = 0;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(widget.question, style: const TextStyle(fontSize: 16)),
            DropdownButton<int>(
              value: selected,
              items: const [
                DropdownMenuItem(value: 0, child: Text("Never")),
                DropdownMenuItem(value: 1, child: Text("Sometimes")),
                DropdownMenuItem(value: 2, child: Text("Often")),
                DropdownMenuItem(value: 3, child: Text("Always")),
              ],
              onChanged: (val) {
                setState(() => selected = val ?? 0);
                widget.onChanged(selected);
              },
            )
          ],
        ),
      ),
    );
  }
}