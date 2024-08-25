import 'package:flutter/material.dart';
import 'admin_page.dart';
import 'quiz_page.dart';

class LoginPage extends StatelessWidget {
  final List<Map<String, dynamic>> categories;
  final Function(List<Map<String, dynamic>>) onUpdateCategories;

  LoginPage(
      {super.key, required this.categories, required this.onUpdateCategories});

  final TextEditingController _usernameController = TextEditingController();

  void _login(BuildContext context) {
    String username = _usernameController.text;

    if (username.isNotEmpty) {
      if (username.toLowerCase() == "admin") {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => AdminPage(
              categories: categories,
            ),
          ),
        );
      } else {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => QuizPage(
              username: username,
              categories: categories,
            ),
          ),
        );
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please enter a username')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'W E L C O M E',
              style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
            ),
            const SizedBox(
              height: 10,
            ),
            const Text("THE QUIZ APP"),
            const SizedBox(
              height: 40,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: TextField(
                controller: _usernameController,
                decoration: const InputDecoration(
                    labelText: 'Username',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                    )),
              ),
            ),
            const SizedBox(
              height: 35,
            ),
            ElevatedButton(
              onPressed: () => _login(context),
              style: const ButtonStyle(
                  textStyle: MaterialStatePropertyAll(TextStyle(fontSize: 18))),
              child: const Text('Login'),
            ),
          ],
        ),
      ),
    );
  }
}
