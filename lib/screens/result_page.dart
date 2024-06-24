import 'package:flutter/material.dart';
import 'package:confetti/confetti.dart';

class ResultPage extends StatefulWidget {
  final int score;
  final int total;

  const ResultPage({Key? key, required this.score, required this.total, required void Function() onRestart}) : super(key: key);

  @override
  ResultPageState createState() => ResultPageState();
}

class ResultPageState extends State<ResultPage> {
  late ConfettiController _confettiController;

  @override
  void initState() {
    super.initState();
    _confettiController = ConfettiController(duration: const Duration(seconds: 10));
    _confettiController.play();  // Démarre l'animation des confettis à l'initialisation
  }

  @override
  void dispose() {
    _confettiController.dispose();  // Nettoyage du contrôleur de confettis
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double percentage = widget.score / widget.total;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Results'),
        backgroundColor: Colors.teal,
      ),
      body: Stack(
        children: [
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Votre score est ${widget.score} en ${widget.total} question',
                  style: const TextStyle(fontSize: 24),
                ),
                const SizedBox(height: 20),
                CircularProgressIndicator(
                  value: percentage,
                  strokeWidth: 8,
                  backgroundColor: Colors.grey[200],
                  valueColor: const AlwaysStoppedAnimation<Color>(Colors.teal),
                ),
                const SizedBox(height: 30),
                ElevatedButton(
                  child: const Text('Nouveaux quiz'),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
              ],
            ),
          ),
          Align(
            alignment: Alignment.topCenter,
            child: ConfettiWidget(
              confettiController: _confettiController,
              blastDirectionality: BlastDirectionality.explosive,
              shouldLoop: false,
              colors: const [Colors.green, Colors.blue, Colors.pink, Colors.orange, Colors.purple],
            ),
          ),
        ],
      ),
    );
  }
}