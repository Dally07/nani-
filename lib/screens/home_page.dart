import 'package:flutter/material.dart';
import 'quiz_page.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Quiz App'),
      ),
      body: Center(
        child: ElevatedButton(
          child: const Text('Start Quiz'),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const QuizPage()),
            );
          },
        ),
      ),
    );
  }
}
