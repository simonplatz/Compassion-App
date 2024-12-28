import 'package:flutter_test/flutter_test.dart';
import 'package:compassionapp/features/courses/courseManager.dart';

void main() {
  group('CourseManager Tests', () {
    late CourseManager courseManager;

    setUp(() {
      courseManager = CourseManager();
    });

    test('Initial courses list is not empty', () {
      expect(courseManager.courses.isNotEmpty, true);
    });

    test('updateSearchQuery updates search query', () {
      courseManager.updateSearchQuery('mindfulness');
      expect(courseManager.filteredCourses.length, lessThan(courseManager.courses.length));
    });

    test('markCourseAsCompleted marks a course as completed', () {
      final courseName = courseManager.courses.first.title;
      courseManager.markCourseAsCompleted(courseName);
      expect(courseManager.getCourseByName(courseName).completed, true);
    });
  });
}