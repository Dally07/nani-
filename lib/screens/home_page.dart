import 'package:flutter/material.dart';
import 'quiz_introduction_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  HomePageState createState() => HomePageState();
}

class HomePageState extends State<HomePage> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  

  @override
  void initState() {
    super.initState();

  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: const Text('Nani?'),
        backgroundColor: const Color.fromARGB(255, 33, 59, 172),
      ),
      body: Container(
            color:const Color.fromARGB(202, 42, 88, 228),
            
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Illustration centrale représentant l'informatique
                  Image.asset(
                    'assets/illustration/ordi.jpeg',
                    height: 300,
                  ),
                  const Text(
                    'Bienvenue dans le Quiz Informatique!',
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 30),
                  // Carte pour le quiz sur l'histoire de l'informatique
                  QuizCard(
                    title: 'Quiz: Histoire de l\'informatique',
                    icon: Icons.history_edu,
                    color: const Color(0xFF5DADE2),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const QuizIntroductionPage(
                            quizTitle: 'Histoire de l\'informatique',
                            quizDescription: 'Ce quiz vous testera sur les grandes dates et événements marquants de l\'histoire de l\'informatique.',
                          ),
                          
                        ),
                      );
                    },
                  ),
                  const SizedBox(height: 20),

                  // Carte pour le quiz sur les langages de programmation
                  QuizCard(
                    title: 'Quiz: Langages de programmation',
                    icon: Icons.code,
                    color: const Color(0xFF85C1E9),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const QuizIntroductionPage(
                            quizTitle: 'Langages de programmation',
                            quizDescription: 'Testez vos connaissances sur les langages de programmation comme C, Java, Python et plus encore.',
                          ),
                        ),
                      );
                    },
                  ),
                  const SizedBox(height: 20),

                  // Carte pour le quiz sur la POO
                  QuizCard(
                    title: 'Quiz: Méthodes de développement (POO)',
                    icon: Icons.developer_mode,
                    color: const Color(0xFF48C9B0),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const QuizIntroductionPage(
                            quizTitle: 'Méthodes de développement (POO)',
                            quizDescription: 'Découvrez les concepts fondamentaux de la Programmation Orientée Objet.',
                          ),
                        ),
                      );
                    },
                  ),
                  const SizedBox(height: 20),

                  // Carte pour le quiz sur la cybersécurité
                  QuizCard(
                    title: 'Quiz: Cybersécurité',
                    icon: Icons.security,
                    color: const Color(0xFF1C2833),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const QuizIntroductionPage(
                            quizTitle: 'Cybersécurité',
                            quizDescription: 'Explorez les concepts clés de la cybersécurité, les attaques et les mesures de défense.',
                          ),
                        ),
                      );
                    },
                  ),
                  const SizedBox(height: 20),

                  // Carte pour le quiz sur le réseau et les protocoles
                  QuizCard(
                    title: 'Quiz: Réseaux et Protocoles',
                    icon: Icons.device_hub,
                    color: const Color(0xFF566573),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const QuizIntroductionPage(
                            quizTitle: 'Réseaux et Protocoles',
                            quizDescription: 'Apprenez-en plus sur les protocoles réseau, les communications et les infrastructures.',
                          ),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          )
          );
  }
}

// Widget réutilisable pour les différentes cartes de quiz
class QuizCard extends StatelessWidget {
  final String title;
  final IconData icon;
  final Color color;
  final VoidCallback onTap;

  const QuizCard({
    Key? key,
    required this.title,
    required this.icon,
    required this.color,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        color: color,
        elevation: 8,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
          child: Row(
            children: [
              Icon(
                icon,
                color: Colors.white,
                size: 40,
              ),
              const SizedBox(width: 20),
              Expanded(
                child: Text(
                  title,
                  style: const TextStyle(
                    fontSize: 18,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}