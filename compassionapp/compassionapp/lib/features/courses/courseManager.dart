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
        return course.title.toLowerCase().contains(_searchQuery.toLowerCase()) ||
        course.description.toLowerCase().contains(_searchQuery.toLowerCase());
      }).toList();

  bool isCourseVisible(String courseName) {
    return _courseVisibility[courseName] ?? false;
  }

  void toggleCourseVisibility(String courseName) {
    _courseVisibility[courseName] = !(_courseVisibility[courseName] ?? false);
    notifyListeners();
  }

  void addCourse(Course course) {
    _courses.add(course);
    notifyListeners();
  }

  void removeCourse(int index) {
    _courses.removeAt(index);
    notifyListeners();
  }

  void updateSearchQuery(String query) {
    _searchQuery = query;
    notifyListeners();
  }

  Widget getCourseContent(String courseName) {
    final course = _courses.firstWhere(
      (course) => course.title == courseName
    );
    return course.buildContent();
  }
}
