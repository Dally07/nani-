import 'package:flutter/material.dart';
import '../data/questions.dart';
import 'result_page.dart';

class QuizPage extends StatefulWidget {
  const QuizPage({Key? key}) : super(key: key);

  @override
  QuizPageState createState() => QuizPageState();
}

class QuizPageState extends State<QuizPage> {
  int _currentQuestionIndex = 0;
  int _score = 0;

  void _answerQuestion(bool isCorrect) {
    if (isCorrect) {
      _score++;
    }
    setState(() {
      _currentQuestionIndex++;
    });
    if (_currentQuestionIndex >= questions.length) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => ResultPage(score: _score, total: questions.length),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final question = questions[_currentQuestionIndex];

    return Scaffold(
      appBar: AppBar(
        title: const Text('NANI?'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              question.questionText,
              style: const TextStyle(fontSize: 24),
            ),
            const SizedBox(height: 20),
            ...question.answers.map((answer) {
              return ElevatedButton(
                child: Text(answer.text),
                onPressed: () => _answerQuestion(answer.isCorrect),
              );
            }).toList(),
          ],
        ),
      ),
    );
  }
}
