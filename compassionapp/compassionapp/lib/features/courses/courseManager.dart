
import 'package:compassionapp/features/courses/CourseData/CompassionTherapy.dart';
import 'package:compassionapp/features/courses/CourseData/MindfulnessCourse.dart';
import 'package:compassionapp/features/courses/CourseData/visualCourse.dart';

import 'package:compassionapp/features/DecisionTree/decisionTreeNode.dart';
import 'package:compassionapp/features/courses/courses.dart';

import 'package:flutter/material.dart';
import 'courses.dart';

class CourseManager extends ChangeNotifier {
    final List<Course> _courses = [
    MindfulnessCourse(),
    CompassionTherapy(),
    VisualCourse(),
  ];

  final Map<String, bool> _courseVisibility = {};

  String _searchQuery = '';

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
    return _courseVisibility[course.title] ?? true;
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

  Course getCourseByName(String courseName) {
    return _courses.firstWhere((course) => course.title == courseName);
  }

  void markCourseAsCompleted(String courseName) {
    final course = _courses.firstWhere((course) => course.title == courseName);
    course.completed = true;
    notifyListeners();
  }
}