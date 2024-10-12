// components/courses_page.dart
import 'package:flutter/material.dart';
import 'therapy_page.dart';

class CoursesPage extends StatelessWidget {
  final List<String> courses = ['Mindfulness', 'Self-Compassion', 'Stress Relief'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Courses'),
      ),
      body: ListView.builder(
        itemCount: courses.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(courses[index]),
            trailing: ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => TherapyPage(courseName: courses[index])),
                );
              },
              child: Text('View Course'),
            ),
          );
        },
      ),
    );
  }
}
