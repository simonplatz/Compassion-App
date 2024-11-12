import 'package:compassionapp/features/courses/courseListWidget.dart';
import 'package:compassionapp/features/courses/courseManager.dart';
import 'package:compassionapp/features/courses/course_list.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CoursesPage extends StatelessWidget {
  const CoursesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<CourseManager>(
      builder: (context, courseManager, child) {
        return Scaffold(
          body: CustomScrollView(
            slivers: [
              SliverAppBar(
                floating: true,
                pinned: true,
                expandedHeight: 70.0,
                bottom: AppBar(
                  title: Padding(
                    padding: const EdgeInsets.all(2.0),
                    child: TextField(
                      decoration: const InputDecoration(
                        labelText: 'Søg Kurser',
                        border: OutlineInputBorder(),
                        prefixIcon: Icon(Icons.search),
                      ),
                      onChanged: (query) {
                        courseManager.updateSearchQuery(query);
                      },
                    ),
                  ),
                ),
                
              ),
              SliverList(
                delegate: SliverChildListDelegate(
                  [
                    CourseList(
                      courses: courseManager.courses,
                      pageController: PageController(viewportFraction: 0.8),
                      onRemoveCourse: courseManager.removeCourse,
                    ),
                    const Padding(
                      padding: EdgeInsets.all(16.0),
                      child: Text('Kursus liste', style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold)),
                    ),
                    CourseListWidget(
                      courses: courseManager.courses,
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
