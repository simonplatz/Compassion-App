class Question {
  final String question;
  final List<String> options;
  final String groupValue;

  Question({
    required this.question,
    required this.options,
    required this.groupValue,
  });
}

class QuestionOptions {
  static const List<String> goals = ['Reducere stress', 'Forbedre fokus', 'Øge medfølelse'];
  static const List<String> experienceLevels = ['Begynder', 'Mellem', 'Avanceret'];
  static const List<String> learningStyles = ['Visuel', 'Auditiv', 'Kinæstetisk'];
}


final List<Question> questions = [
  Question(
    question: 'Hvad er dit primære mål?',
    options: QuestionOptions.goals,
    groupValue: 'goal',
  ),
  Question(
    question: 'Hvad er dit erfaringsniveau?',
    options: QuestionOptions.experienceLevels,
    groupValue: 'experience',
  ),
  Question(
    question: 'Hvad er din foretrukne læringsstil?',
    options: QuestionOptions.learningStyles,
    groupValue: 'preference',
  ),
];