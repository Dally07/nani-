class Question {
  final String questionText;
  final List<Answer> answers;

  Question({required this.questionText, required this.answers});
}

class Answer {
  final String text;
  final bool isCorrect;

  Answer({required this.text, required this.isCorrect});
}
