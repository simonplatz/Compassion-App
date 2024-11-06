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
      body: Scrollbar(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Velkommen til $courseName kurset!',
                style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 20),
              Text(
                'Her vil du lære mere om $courseName og øve øvelser for at forbedre dit velbefindende.',
                style: const TextStyle(fontSize: 16),
              ),
              const SizedBox(height: 20),
              Consumer<CourseManager>(
                builder: (context, courseManager, child) {
                  return courseManager.getCourseContent(courseName);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}