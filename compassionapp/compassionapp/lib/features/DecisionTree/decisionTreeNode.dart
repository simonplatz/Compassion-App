class DecisionTreeNode {
  final String question;
  final Map<String, DecisionTreeNode?> children;
  final Map<String, int> weights;

  DecisionTreeNode({
    required this.question,
    required this.children,
    required this.weights,
  });
}

DecisionTreeNode createDecisionTree() {
  return DecisionTreeNode(
    question: 'What is your primary goal?',
    children: {
      'Reduce Stress': DecisionTreeNode(
        question: 'What is your experience level?',
        children: {
          'Beginner': DecisionTreeNode(
            question: 'What is your preferred learning style?',
            children: {
              'Visual': null,
              'Auditory': null,
              'Kinesthetic': null,
            },
            weights: {
              'Visual': 10,
              'Auditory': 5,
              'Kinesthetic': 3,
            },
          ),
          'Intermediate': DecisionTreeNode(
            question: 'What is your preferred learning style?',
            children: {
              'Visual': null,
              'Auditory': null,
              'Kinesthetic': null,
            },
            weights: {
              'Visual': 7,
              'Auditory': 10,
              'Kinesthetic': 5,
            },
          ),
          'Advanced': DecisionTreeNode(
            question: 'What is your preferred learning style?',
            children: {
              'Visual': null,
              'Auditory': null,
              'Kinesthetic': null,
            },
            weights: {
              'Visual': 5,
              'Auditory': 7,
              'Kinesthetic': 10,
            },
          ),
        },
        weights: {
          'Beginner': 10,
          'Intermediate': 7,
          'Advanced': 5,
        },
      ),
      'Improve Focus': DecisionTreeNode(
        question: 'What is your experience level?',
        children: {
          'Beginner': DecisionTreeNode(
            question: 'What is your preferred learning style?',
            children: {
              'Visual': null,
              'Auditory': null,
              'Kinesthetic': null,
            },
            weights: {
              'Visual': 5,
              'Auditory': 10,
              'Kinesthetic': 7,
            },
          ),
          'Intermediate': DecisionTreeNode(
            question: 'What is your preferred learning style?',
            children: {
              'Visual': null,
              'Auditory': null,
              'Kinesthetic': null,
            },
            weights: {
              'Visual': 7,
              'Auditory': 10,
              'Kinesthetic': 5,
            },
          ),
          'Advanced': DecisionTreeNode(
            question: 'What is your preferred learning style?',
            children: {
              'Visual': null,
              'Auditory': null,
              'Kinesthetic': null,
            },
            weights: {
              'Visual': 10,
              'Auditory': 7,
              'Kinesthetic': 5,
            },
          ),
        },
        weights: {
          'Beginner': 7,
          'Intermediate': 10,
          'Advanced': 5,
        },
      ),
      'Enhance Compassion': DecisionTreeNode(
        question: 'What is your experience level?',
        children: {
          'Beginner': DecisionTreeNode(
            question: 'What is your preferred learning style?',
            children: {
              'Visual': null,
              'Auditory': null,
              'Kinesthetic': null,
            },
            weights: {
              'Visual': 5,
              'Auditory': 7,
              'Kinesthetic': 10,
            },
          ),
          'Intermediate': DecisionTreeNode(
            question: 'What is your preferred learning style?',
            children: {
              'Visual': null,
              'Auditory': null,
              'Kinesthetic': null,
            },
            weights: {
              'Visual': 7,
              'Auditory': 5,
              'Kinesthetic': 10,
            },
          ),
          'Advanced': DecisionTreeNode(
            question: 'What is your preferred learning style?',
            children: {
              'Visual': null,
              'Auditory': null,
              'Kinesthetic': null,
            },
            weights: {
              'Visual': 10,
              'Auditory': 5,
              'Kinesthetic': 7,
            },
          ),
        },
        weights: {
          'Beginner': 5,
          'Intermediate': 7,
          'Advanced': 10,
        },
      ),
    },
    weights: {
      'Reduce Stress': 10,
      'Improve Focus': 7,
      'Enhance Compassion': 5,
    },
  );
}