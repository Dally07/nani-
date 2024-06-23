import 'package:flutter/material.dart';
import '../data/questions.dart'; // Assure-toi d'importer les données correctement
import 'result_page.dart';

class QuizPage extends StatefulWidget {
  const QuizPage({Key? key}) : super(key: key);

  @override
  QuizPageState createState() => QuizPageState();
}

class QuizPageState extends State<QuizPage> {
  int _currentQuestionIndex = 0;
  int _score = 0;

  @override
  void initState() {
    super.initState();
    // Mélanger les questions au début du quiz
    questions.shuffle();
  }

  void _answerQuestion(bool isCorrect) {
    if (isCorrect) {
      _score++;
    }
    setState(() {
      _currentQuestionIndex++;
    });
    if (_currentQuestionIndex < questions.length) {
      // Naviguer vers la prochaine question
    } else {
      // Naviguer vers la page des résultats
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
    if (_currentQuestionIndex >= questions.length) {
      // Gérer le cas où _currentQuestionIndex est en dehors des limites
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
                  // Réinitialiser le quiz (si nécessaire)
                  setState(() {
                    _currentQuestionIndex = 0;
                    _score = 0;
                    questions.shuffle(); // Mélanger les questions à nouveau
                  });
                },
                child: const Text('Restart Quiz'),
              ),
            ],
          ),
        ),
      );
    }

    final question = questions[_currentQuestionIndex];

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
            ...question.answers.map((answer) {
              return ElevatedButton(
                onPressed: () => _answerQuestion(answer.isCorrect),
                child: Text(answer.text),
              );
            }).toList(),
          ],
        ),
      ),
    );
  }
}
