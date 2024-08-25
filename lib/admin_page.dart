import 'package:flutter/material.dart';
import 'add_question_page.dart';

class AdminPage extends StatefulWidget {
  final List<Map<String, dynamic>> categories;

  AdminPage({required this.categories});

  @override
  _AdminPageState createState() => _AdminPageState();
}

class _AdminPageState extends State<AdminPage> {
  void _addCategory(String name) {
    setState(() {
      widget.categories.add({'name': name, 'questions': []});
    });
  }

  void _deleteCategory(String categoryName) {
    setState(() {
      widget.categories
          .removeWhere((category) => category['name'] == categoryName);
    });
  }

  void _onQuestionAdded(String categoryName, Map<String, dynamic> question) {
    setState(() {
      widget.categories
          .firstWhere(
              (category) => category['name'] == categoryName)['questions']
          .add(question);
    });
  }

  @override
  Widget build(BuildContext context) {
    TextEditingController _categoryController = TextEditingController();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Admin Page'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _categoryController,
              decoration: const InputDecoration(
                labelText: 'Add New Category',
              ),
            ),
            const SizedBox(height: 12),
            ElevatedButton(
              onPressed: () {
                _addCategory(_categoryController.text);
                _categoryController.clear();
              },
              child: const Text('Add Category'),
            ),
            const SizedBox(height: 16),
            Expanded(
              child: ListView.builder(
                itemCount: widget.categories.length,
                itemBuilder: (context, index) {
                  String categoryName = widget.categories[index]['name'];
                  return ListTile(
                    title: Text(categoryName),
                    trailing: IconButton(
                      icon: const Icon(Icons.delete, color: Colors.red),
                      onPressed: () {
                        _deleteCategory(categoryName);
                      },
                    ),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => AddQuestionPage(
                            category: widget.categories[index],
                            onQuestionAdded: (question) =>
                                _onQuestionAdded(categoryName, question),
                          ),
                        ),
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
