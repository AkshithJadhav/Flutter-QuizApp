import 'package:flutter/material.dart';

class AddQuestionPage extends StatefulWidget {
  final Map<String, dynamic> category;
  final Function(Map<String, dynamic>) onQuestionAdded;

  AddQuestionPage({required this.category, required this.onQuestionAdded});

  @override
  _AddQuestionPageState createState() => _AddQuestionPageState();
}

class _AddQuestionPageState extends State<AddQuestionPage> {
  TextEditingController _questionController = TextEditingController();
  TextEditingController _answerController = TextEditingController();
  List<TextEditingController> _optionControllers = [
    TextEditingController(),
    TextEditingController(),
    TextEditingController(),
    TextEditingController(),
  ];

  void _addQuestion() {
    Map<String, dynamic> newQuestion = {
      'question': _questionController.text,
      'options':
          _optionControllers.map((controller) => controller.text).toList(),
      'answer': _answerController.text,
    };

    widget.onQuestionAdded(newQuestion);

    _questionController.clear();
    _answerController.clear();
    _optionControllers.forEach((controller) => controller.clear());

    // Update UI to reflect the new question count
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    int questionCount =
        widget.category['questions'].length + 1; // Current question number

    return Scaffold(
      appBar: AppBar(
        title: Text('Add Question to ${widget.category['name']}'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Question $questionCount',
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _questionController,
              decoration: const InputDecoration(labelText: 'Question'),
            ),
            const SizedBox(height: 8),
            ..._optionControllers.map((controller) {
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 4.0),
                child: TextField(
                  controller: controller,
                  decoration: const InputDecoration(labelText: 'Option'),
                ),
              );
            }).toList(),
            const SizedBox(height: 8),
            TextField(
              controller: _answerController,
              decoration: const InputDecoration(labelText: 'Correct Answer'),
            ),
            const SizedBox(height: 16),
            Center(
              child: ElevatedButton(
                onPressed: _addQuestion,
                child: const Text('Add Question'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
