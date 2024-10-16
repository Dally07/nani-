
import 'package:flutter/material.dart';
import 'quiz_page.dart';

class QuizIntroductionPage extends StatelessWidget {
  final String quizTitle;
  final String quizDescription;

  const QuizIntroductionPage({
    Key? key,
    required this.quizTitle,
    required this.quizDescription,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(quizTitle),
        backgroundColor: const Color.fromARGB(255, 33, 59, 172),
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.blue, Colors.purple],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                quizTitle,
                style: const TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 20),
              Text(
                quizDescription,
                style: const TextStyle(
                  fontSize: 18,
                  color: Colors.white70,
                ),
              ),
              const SizedBox(height: 40),
              Center(
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 50, vertical: 15), backgroundColor: Colors.orangeAccent,
                    textStyle: const TextStyle(
                      fontSize: 18,
                    ),
                  ),
                  onPressed: () {
                    // Navigate to the actual quiz page
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => QuizPage(quizTitle: quizTitle),
                      ),
                    );
                  },
                  child: const Text('Commencer le Quiz'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}