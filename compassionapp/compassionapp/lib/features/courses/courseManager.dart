import 'package:compassionapp/features/DecisionTree/decisionTreeNode.dart';
import 'package:compassionapp/features/courses/courses.dart';
import 'package:flutter/material.dart';
import 'CourseData/CompassionTherapy.dart';
import 'CourseData/MindfulnessCourse.dart';
import 'CourseData/VisualCourse.dart';

class CourseManager extends ChangeNotifier {
  final List<Course> _courses = _generateCourses();
  String _searchQuery = '';
  final Map<String, bool> _courseVisibility = {
    'Mindfulness': true,
    'Compassion-Fokuseret Terapi': true,
    'Visual Course': true,
  };

  static List<Course> _generateCourses() {
    return [
      MindfulnessCourse(),
      CompassionTherapy(),
      VisualCourse(),
    ];
  }

Map<String, int> calculateScores(DecisionTreeNode node, Map<String, String> answers) {
  Map<String, int> scores = {
    'Mindfulness': 0,
    'Compassion-Fokuseret Terapi': 0,
    'Visual Course': 0,
  };
// needs improvement
  void traverseTree(DecisionTreeNode? currentNode, int currentScore) {
    if (currentNode == null) return;

    String? answer = answers[currentNode.question];
    if (answer != null) {
      currentScore += currentNode.weights[answer] ?? 0;
      traverseTree(currentNode.children[answer], currentScore);
    } 
      scores['Mindfulness'] = (scores['Mindfulness'] ?? 0) + currentScore;
      scores['Compassion-Fokuseret Terapi'] = (scores['Compassion-Fokuseret Terapi'] ?? 0) + currentScore;
      scores['Visual Course'] = (scores['Visual Course'] ?? 0) + currentScore;
    
  }

  traverseTree(node, 0);
  return scores;
}

  List<Course> get courses => _courses.where((course) {
        final isVisible = _courseVisibility[course.title] ?? false;
        final matchesSearchQuery = course.title.toLowerCase().contains(_searchQuery.toLowerCase()) ||
            course.description.toLowerCase().contains(_searchQuery.toLowerCase());
        return isVisible && matchesSearchQuery;
      }).toList();

  void updateCourseVisibilityBasedOnAnswers({
    required String goal,
    required String experience,
    required String preference,
  }) {
    DecisionTreeNode decisionTree = createDecisionTree();
    Map<String, String> answers = {
      'What is your primary goal?': goal,
      'What is your experience level?': experience,
      'What is your preferred learning style?': preference,
    };

    Map<String, int> scores = calculateScores(decisionTree, answers);

    // Set visibility based on scores
    _courseVisibility['Mindfulness'] = scores['Mindfulness']! > 0;
    _courseVisibility['Compassion-Fokuseret Terapi'] = scores['Compassion-Fokuseret Terapi']! > 0;
    _courseVisibility['Visual Course'] = scores['Visual Course']! > 0;

    notifyListeners();
  }

  void updateSearchQuery(String query) {
    _searchQuery = query;
    notifyListeners();
  }

  Widget getCourseContent(String courseName) {
    final course = _courses.firstWhere((course) => course.title == courseName);
    return course.buildContent();
  }
}