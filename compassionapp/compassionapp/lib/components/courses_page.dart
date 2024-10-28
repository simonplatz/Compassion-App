import 'package:compassionapp/features/courses/courseData.dart';
import 'package:compassionapp/features/courses/course_list.dart';
import 'package:compassionapp/features/courses/courses.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CoursesPage extends StatelessWidget {
  const CoursesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<CourseData>(
      builder: (context, courseData, child) {
        return Scaffold(
          appBar: AppBar(
            title: const Text('Courses'),
            actions: [
              IconButton(
                icon: const Icon(Icons.add),
                onPressed: () {
                  courseData.addCourse(Course(
                    title: 'New Course',
                    description: 'Description of the new course.',
                    imageUrl: 'assets/images/self_compassion.jpg',
                  ));
                },
              ),
            ],
          ),
          body: SingleChildScrollView(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextField(
                    decoration: const InputDecoration(
                      labelText: 'Search Courses',
                      border: OutlineInputBorder(),
                      prefixIcon: Icon(Icons.search),
                    ),
                    onChanged: (query) {
                      courseData.updateSearchQuery(query);
                    },
                  ),
                ),
                CourseList(
                  courses: courseData.courses,
                  pageController: PageController(viewportFraction: 0.8),
                  onRemoveCourse: courseData.removeCourse,
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}