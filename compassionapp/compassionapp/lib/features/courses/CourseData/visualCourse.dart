import 'package:compassionapp/features/courses/courses.dart';
import 'package:flutter/material.dart';

class VisualCourse extends Course {
  VisualCourse()
      : super(
          id: '4',
          title: 'Visual Course',
          description: 'Explore visual techniques.',
          imageUrl: 'assets/images/hearths.jpg',
        );

  @override
  Widget buildContent() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Image.asset(imageUrl),
        const SizedBox(height: 20),
        Text(
          description,
          style: const TextStyle(fontSize: 16),
        ),
        const SizedBox(height: 20),
        const Text(
          'Explore visual techniques.',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
      ],
    );
  }
}