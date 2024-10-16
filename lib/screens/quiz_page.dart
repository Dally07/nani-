import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';

import 'package:nani/models/question.dart';
import '../data/questions.dart';
import 'result_page.dart';

class QuizPage extends StatefulWidget {
  const QuizPage({Key? key, required this.quizTitle}) : super(key: key);
  final String quizTitle;

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
  Timer? _timer; // Déclaration du Timer
  int _timeLeft = 20; // Temps limite en secondes

  @override
  void initState() {
    super.initState();
    _startNewQuiz();
  }

  // Fonction pour démarrer ou redémarrer un quiz
  void _startNewQuiz() {
    setState(() {
      List<Question> filteredQuiz = questions.where((q) => q.quizTitle == widget.quizTitle).toList();
      questions.shuffle();
      quizQuestions = filteredQuiz.take(10).toList();
      _currentQuestionIndex = 0;
      _score = 0;
      _answered = false;
      _selectedAnswerIndex = null;
      _startTimer();
    });
  }

  // Démarrer le timer pour chaque question
  void _startTimer() {
    _timer?.cancel(); // Annuler le timer précédent
    _timeLeft = 20; // Temps initial
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        if (_timeLeft > 0) {
          _timeLeft--;
        } else {
          // Temps écoulé
          _timer?.cancel();
          if (!_answered) {
            _answerQuestion(-1, false); // Considérer comme incorrect
          }
        }
      });
    });
  }

  // Fonction pour répondre à une question
  void _answerQuestion(int index, bool isCorrect) {
    setState(() {
      _answered = true;
      _selectedAnswerIndex = index;
      _timer?.cancel(); // Arrêter le timer

      if (isCorrect) {
        _score++;
      }
    });

    Future.delayed(const Duration(seconds: 2), () {
      if (mounted) {
        setState(() {
          _currentQuestionIndex++;
          _answered = false;
          _selectedAnswerIndex = null;
        });

        if (_currentQuestionIndex >= quizQuestions.length) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => ResultPage(
                score: _score,
                total: quizQuestions.length,
                onRestart: _startNewQuiz,
              ),
            ),
          );
        } else {
          _startTimer(); // Redémarrer le timer pour la nouvelle question
        }
      }
    });
  }

  @override
  void dispose() {
    _timer?.cancel(); // Nettoyage du timer
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (_currentQuestionIndex >= quizQuestions.length) {
      return Scaffold(
        appBar: AppBar(
          title: const Text('Nani?'),
          backgroundColor: Colors.teal,
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
                onPressed: _startNewQuiz,
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
            Text(
              'Time left: $_timeLeft seconds',
              style: const TextStyle(fontSize: 18, color: Colors.red),
            ),
            const SizedBox(height: 20),
            ...question.answers.asMap().entries.map((entry) {
              int index = entry.key;
              Answer answer = entry.value;
              Widget icon = const SizedBox.shrink();

              if (_answered) {
                if (index == _selectedAnswerIndex) {
                  icon = answer.isCorrect
                      ? const Icon(Icons.check, color: Colors.green)
                      : const Icon(Icons.close, color: Colors.red);
                } else if (answer.isCorrect) {
                  icon = const Icon(Icons.check, color: Colors.green);
                }
              }

              return Container(
                margin: const EdgeInsets.only(bottom: 10),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: _answered ? Colors.grey : Colors.teal,
                  ),
                  onPressed: _answered
                      ? null
                      : () => _answerQuestion(index, answer.isCorrect),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        answer.text,
                        style: const TextStyle(color: Colors.white),
                      ),
                      icon,
                    ],
                  ),
                ),
              );
            }).toList(),
          ],
        ),
      ),
    );
  }
}
