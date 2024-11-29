import 'package:compassionapp/features/courses/courses.dart';
import 'package:compassionapp/services/visisbility_manager.dart';
import 'package:flutter/material.dart';

class CourseManager extends ChangeNotifier {
   final List<Course> _courses = Course.getCourses();

   final VisibilityManager _visibilityManager = VisibilityManager();

  String _searchQuery = '';


List<Course> get courses => _courses.where((course) {
        return _visibilityManager.courseVisibility[course.title] ?? true;
      }).toList();

  void updateCourseVisibilityBasedOnAnswers({
    required String goal,
    required String experience,
    required String preference,
  }) {
    _visibilityManager.updateVisibilityBasedOnAnswers(
      goal: goal,
      experience: experience,
      preference: preference,
    );
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
