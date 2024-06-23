import 'dart:math';
import 'package:flutter/material.dart';
import 'package:nani/models/question.dart';
import '../data/questions.dart';
import 'result_page.dart';

class QuizPage extends StatefulWidget {
  const QuizPage({Key? key}) : super(key: key);

  @override
  QuizPageState createState() => QuizPageState();
}

class QuizPageState extends State<QuizPage> {
  List<Question> quizQuestions = [];
  int _currentQuestionIndex = 0;
  int _score = 0;
  final Random random = Random();
  bool _answered = false;
  int? _selectedAnswerIndex;

  @override
  void initState() {
    super.initState();
    questions.shuffle(); // Mélanger les questions
    quizQuestions = questions.take(10).toList(); // Prendre les 10 premières questions
  }

  void _answerQuestion(int index, bool isCorrect) {
    setState(() {
      _answered = true;
      _selectedAnswerIndex = index;
      if (isCorrect) {
        _score++;
      }
    });

    Future.delayed(const Duration(seconds: 1), () {
      setState(() {
        _currentQuestionIndex++;
        _answered = false;
        _selectedAnswerIndex = null;
      });

      if (_currentQuestionIndex >= quizQuestions.length) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => ResultPage(score: _score, total: quizQuestions.length),
          ),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_currentQuestionIndex >= quizQuestions.length) {
      return Scaffold(
        appBar: AppBar(
          title: const Text('Quiz'),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'Quiz Completed!',
                style: TextStyle(fontSize: 24),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  setState(() {
                    _currentQuestionIndex = 0;
                    _score = 0;
                    questions.shuffle();
                    quizQuestions = questions.take(10).toList();
                  });
                },
                child: const Text('Restart Quiz'),
              ),
            ],
          ),
        ),
      );
    }

    final question = quizQuestions[_currentQuestionIndex];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Quiz'),
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
            ...question.answers.asMap().entries.map((entry) {
              int index = entry.key;
              Answer answer = entry.value;
              Color color;

              if (_answered) {
                if (index == _selectedAnswerIndex) {
                  color = answer.isCorrect ? Colors.green : Colors.red;
                } else if (answer.isCorrect) {
                  color = Colors.green;
                } else {
                  color = Colors.grey; // Change other buttons to grey
                }
              } else {
                color = Colors.blue;
              }

              return Container(
                margin: const EdgeInsets.only(bottom: 10), // Margin for spacing
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: color, // Button background color
                  ),
                  onPressed: _answered
                      ? null
                      : () => _answerQuestion(index, answer.isCorrect),
                  child: Text(answer.text),
                ),
              );
            }).toList(),
          ],
        ),
      ),
    );
  }
}