import 'package:flutter/material.dart';
import 'login_page.dart';

void main() {
  runApp(const QuizApp());
}

class QuizApp extends StatefulWidget {
  const QuizApp({super.key});

  @override
  _QuizAppState createState() => _QuizAppState();
}

class _QuizAppState extends State<QuizApp> {
  List<Map<String, dynamic>> categories = [];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Quiz App',
      theme: ThemeData.dark(),
      debugShowCheckedModeBanner: false,
      home: LoginPage(
        categories: categories,
        onUpdateCategories: (newCategories) {
          setState(() {
            categories = newCategories;
          });
        },
      ),
    );
  }
}
