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
}