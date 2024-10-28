// components/therapy_page.dart
import 'package:compassionapp/features/courses/CourseContent.dart';
import 'package:flutter/material.dart';

class TherapyPage extends StatelessWidget {
  final String courseName;

  const TherapyPage({super.key, required this.courseName});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(courseName, style: const TextStyle(fontWeight: FontWeight.bold)),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Welcome to the $courseName course!',
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            Text(
              'Here you will learn more about $courseName and practice exercises to improve your well-being.',
              style: const TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 20),
            CourseContent(courseName: courseName),
          ],
        ),
      ),
    );
  }
}