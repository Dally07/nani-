import '../models/question.dart';

final List<Question> questions = [
  Question(
    questionText: 'What is the capital of France?',
    answers: [
      Answer(text: 'Paris', isCorrect: true),
      Answer(text: 'London', isCorrect: false),
      Answer(text: 'Berlin', isCorrect: false),
      Answer(text: 'Madrid', isCorrect: false),
    ],
  ),
  Question(
    questionText: 'Who wrote "Hamlet"?',
    answers: [
      Answer(text: 'William Shakespeare', isCorrect: true),
      Answer(text: 'Charles Dickens', isCorrect: false),
      Answer(text: 'Mark Twain', isCorrect: false),
      Answer(text: 'Jane Austen', isCorrect: false),
    ],
  ),
];
