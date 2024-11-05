import 'package:compassionapp/features/courses/courseData.dart';
import 'package:compassionapp/features/courses/courseListWidget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final courseData = Provider.of<CourseData>(context);

    return Scaffold(
     
      body: SingleChildScrollView(
        child: Column(
          children: [
            CourseListWidget(
              courses: courseData.courses,
              onRemoveCourse: courseData.removeCourse,
            ),
          ],
        ),
      ),
    );
  }
}