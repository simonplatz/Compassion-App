import 'package:compassionapp/features/courses/CourseData/CompassionTherapy.dart';
import 'package:compassionapp/features/courses/CourseData/MindfulnessCourse.dart';

import 'package:compassionapp/features/DecisionTree/decisionTreeNode.dart';
import 'package:compassionapp/features/courses/courses.dart';

import 'package:compassionapp/features/courses/CourseData/compassion_journey.dart';
import 'package:flutter/material.dart';

class CourseManager extends ChangeNotifier {
  final List<Course> _courses = [
    MindfulnessCourse(),
    CompassionTherapy(),
    CompassionJourney(),
  ];

  final Map<String, bool> _courseVisibility = {};

  String _searchQuery = '';

  Map<String, int> calculateScores(
      DecisionTreeNode node, Map<String, String> answers) {
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
      scores['Compassion-Fokuseret Terapi'] =
          (scores['Compassion-Fokuseret Terapi'] ?? 0) + currentScore;
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
    _courseVisibility['Compassion-Fokuseret Terapi'] =
        scores['Compassion-Fokuseret Terapi']! > 0;
    _courseVisibility['Visual Course'] = scores['Visual Course']! > 0;

    // Example algorithm to determine course visibility based on answers
    if (goal == 'Reduce Stress' &&
        experience == 'Beginner' &&
        preference == 'Visual') {
      _courseVisibility[MindfulnessCourse().title] = true;
      _courseVisibility[CompassionTherapy().title] = false;
      _courseVisibility[CompassionJourney().title] = true;
    } else if (goal == 'Improve Focus' &&
        experience == 'Intermediate' &&
        preference == 'Auditory') {
      _courseVisibility[MindfulnessCourse().title] = true;
      _courseVisibility[CompassionTherapy().title] = false;
      _courseVisibility[CompassionJourney().title] = false;
    } else if (goal == 'Enhance Compassion' &&
        experience == 'Advanced' &&
        preference == 'Kinesthetic') {
      _courseVisibility[MindfulnessCourse().title] = false;
      _courseVisibility[CompassionTherapy().title] = true;
      _courseVisibility[CompassionJourney().title] = false;
    } else {
      _courseVisibility[MindfulnessCourse().title] = true;
      _courseVisibility[CompassionTherapy().title] = true;
      _courseVisibility[CompassionJourney().title] = true;
    }
    notifyListeners();
  }

  void updateSearchQuery(String query) {
    _searchQuery = query;
    notifyListeners();
  }

  List<Course> get filteredCourses {
    if (_searchQuery.isEmpty) {
      return courses;
    } else {
      return courses.where((course) {
        return course.title
                .toLowerCase()
                .contains(_searchQuery.toLowerCase()) ||
            course.description
                .toLowerCase()
                .contains(_searchQuery.toLowerCase());
      }).toList();
    }
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
