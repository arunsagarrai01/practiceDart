import 'dart:io';

class Question {
  String question;
  List<String> options;
  int correctAnswer;

  Question(this.question, this.options, this.correctAnswer);
}

void main() {
  List<Question> questions = [
    Question('What is the capital of Nepal?', [
      'Pokhara',
      'Kathmandu',
      'Lalitpur',
      'Biratnagar',
    ], 2),
    Question('Which language is used with Flutter?', [
      'Java',
      'Dart',
      'Python',
      'C++',
    ], 2),
    Question('Which keyword creates a class in Dart?', [
      'object',
      'class',
      'create',
      'struct',
    ], 2),
    Question('Which symbol is used for comments in Dart?', [
      '//',
      '##',
      '<!--',
      '**',
    ], 1),
    Question('Which collection stores multiple values in order?', [
      'List',
      'String',
      'bool',
      'double',
    ], 1),
  ];

  int score = 0;

  print('==============================');
  print('       DART QUIZ APP');
  print('==============================');

  for (int i = 0; i < questions.length; i++) {
    Question q = questions[i];

    print('\nQuestion ${i + 1}: ${q.question}');

    for (int j = 0; j < q.options.length; j++) {
      print('${j + 1}. ${q.options[j]}');
    }

    stdout.write('Your answer: ');
    int answer = int.parse(stdin.readLineSync()!);

    if (answer == q.correctAnswer) {
      print('Correct! ✓');
      score++;
    } else {
      print('Wrong! ✗');
    }
  }

  print('\n==============================');
  print('QUIZ FINISHED');
  print('==============================');

  print('Your Score: $score/${questions.length}');

  double percentage = (score / questions.length) * 100;

  print('Percentage: ${percentage.toStringAsFixed(1)}%');

  if (percentage >= 80) {
    print('Excellent! 🏆');
  } else if (percentage >= 60) {
    print('Good job! 👍');
  } else if (percentage >= 40) {
    print('Keep practicing! 📚');
  } else {
    print('You need more practice.');
  }
}
