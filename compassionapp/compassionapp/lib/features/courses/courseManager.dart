import 'package:compassionapp/features/courses/CourseData/CompassionTherapy.dart';
import 'package:compassionapp/features/courses/CourseData/MindfulnessCourse.dart';
import 'package:compassionapp/features/courses/CourseData/visualCourse.dart';
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

  List<Course> get courses => _courses.where((course) {
    return _courseVisibility[course.title] ?? true;
  }).toList();

  void updateCourseVisibilityBasedOnAnswers({
    required String goal,
    required String experience,
    required String preference,
  }) {
    // Example algorithm to determine course visibility based on answers
    if (goal == 'Reduce Stress' && experience == 'Beginner' && preference == 'Visual') {
      _courseVisibility['Mindfulness'] = true;
      _courseVisibility['Compassion-Fokuseret Terapi'] = false;
      _courseVisibility['Visual Course'] = true;
    } else if (goal == 'Improve Focus' && experience == 'Intermediate' && preference == 'Auditory') {
      _courseVisibility['Mindfulness'] = true;
      _courseVisibility['Compassion-Fokuseret Terapi'] = false;
      _courseVisibility['Visual Course'] = false;
    } else if (goal == 'Enhance Compassion' && experience == 'Advanced' && preference == 'Kinesthetic') {
      _courseVisibility['Mindfulness'] = false;
      _courseVisibility['Compassion-Fokuseret Terapi'] = true;
      _courseVisibility['Visual Course'] = false;
    } else {
      _courseVisibility['Mindfulness'] = true;
      _courseVisibility['Compassion-Fokuseret Terapi'] = true;
      _courseVisibility['Visual Course'] = true;
    }
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