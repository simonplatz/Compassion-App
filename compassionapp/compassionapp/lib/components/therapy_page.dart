// components/therapy_page.dart
import 'package:compassionapp/features/courses/courseManager.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class TherapyPage extends StatelessWidget {
  final String courseName;

  const TherapyPage({super.key, required this.courseName});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(courseName, style: const TextStyle(fontWeight: FontWeight.bold)),
        backgroundColor: Colors.teal,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Consumer<CourseManager>(
          builder: (context, courseManager, child) {
            return courseManager.getCourseContent(courseName);
          },
        ),
      ),
    );
  }
}