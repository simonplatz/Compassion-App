// components/therapy_page.dart
import 'package:flutter/material.dart';

class TherapyPage extends StatelessWidget {
  final String courseName;

  const TherapyPage({super.key, required this.courseName});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('$courseName Course'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Text(
              'Welcome to the $courseName course!',
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            Text('Here you will learn more about $courseName and practice exercises to improve your well-being.'),
          ],
        ),
      ),
    );
  }
}