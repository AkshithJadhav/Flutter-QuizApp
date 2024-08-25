import 'package:flutter/material.dart';

class QuizPage extends StatefulWidget {
  final String username;
  final List<Map<String, dynamic>> categories;

  QuizPage({required this.username, required this.categories});

  @override
  _QuizPageState createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> {
  List<Map<String, dynamic>>? _selectedCategoryQuestions;
  int _currentQuestionIndex = 0;
  int _score = 0;

  void _selectCategory(String categoryName) {
    setState(() {
      _selectedCategoryQuestions = (widget.categories.firstWhere(
                  (category) => category['name'] == categoryName)['questions']
              as List)
          .cast<
              Map<String,
                  dynamic>>(); // Explicitly cast to List<Map<String, dynamic>>
      _currentQuestionIndex = 0;
      _score = 0;
    });
  }

  void _checkAnswer(String selectedOption) {
    if (selectedOption ==
        _selectedCategoryQuestions![_currentQuestionIndex]['answer']) {
      _score++;
    }

    setState(() {
      _currentQuestionIndex++;
    });

    // Check if the quiz is complete
    if (_currentQuestionIndex >= _selectedCategoryQuestions!.length) {
      _showScoreAndRedirect();
    }
  }

  void _showScoreAndRedirect() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Quiz Completed'),
        content: Text('Your score: $_score'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context); // Close the dialog
              Navigator.pop(context); // Go back to categories page
            },
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Quiz Page - ${widget.username}'),
      ),
      body: Center(
        child: _selectedCategoryQuestions == null
            ? GridView.builder(
                padding:
                    const EdgeInsets.symmetric(horizontal: 40, vertical: 16),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2, // Number of columns
                  crossAxisSpacing: 16.0,
                  mainAxisSpacing: 16.0,
                  childAspectRatio: 1.0, // Aspect ratio of the grid items
                ),
                itemCount: widget.categories.length,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () =>
                        _selectCategory(widget.categories[index]['name']),
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.blueAccent,
                        borderRadius: BorderRadius.circular(16.0),
                      ),
                      child: Center(
                        child: Text(
                          widget.categories[index]['name'],
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 40,
                            fontWeight: FontWeight.bold,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                  );
                },
              )
            : _currentQuestionIndex < _selectedCategoryQuestions!.length
                ? Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          'Question ${_currentQuestionIndex + 1} of ${_selectedCategoryQuestions!.length}',
                          style: const TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          _selectedCategoryQuestions![_currentQuestionIndex]
                              ['question'],
                          style: const TextStyle(
                              fontSize: 30, fontWeight: FontWeight.bold),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      ..._selectedCategoryQuestions![_currentQuestionIndex]
                              ['options']
                          .map<Widget>((option) => Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 4.0),
                                child: ElevatedButton(
                                  onPressed: () => _checkAnswer(option),
                                  child: Text(option),
                                ),
                              ))
                          .toList(),
                    ],
                  )
                : Container(), // Empty container as the dialog will be shown.
      ),
    );
  }
}
