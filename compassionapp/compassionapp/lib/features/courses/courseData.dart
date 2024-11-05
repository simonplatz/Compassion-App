import 'package:compassionapp/features/courses/courses.dart';
import 'package:flutter/material.dart';

class CourseData extends ChangeNotifier {
  final List<Course> _courses = [
    Course(
      title: 'Mindfulness',
      description: 'Learn the art of mindfulness.',
      imageUrl: 'assets/images/self_compassion.jpg',
      id: '',
    ),
    Course(
      title: 'Self-Compassion',
      description: 'Practice self-compassion techniques.',
      imageUrl: 'assets/images/self_compassion.jpg',
      id: '',
    ),
    Course(
      title: 'Compassion-Focused Therapy',
      description: 'Discover ways to relieve stress.',
      imageUrl: 'assets/images/self_compassion.jpg',
      id: '',
    ),
  ];

  String _searchQuery = '';

  List<Course> get courses => _courses.where((course) {
        return course.title
                .toLowerCase()
                .contains(_searchQuery.toLowerCase()) ||
            course.description
                .toLowerCase()
                .contains(_searchQuery.toLowerCase());
      }).toList();

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
}
