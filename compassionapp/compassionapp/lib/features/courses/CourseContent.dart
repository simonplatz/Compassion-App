import 'package:flutter/material.dart';

class CourseContent extends StatelessWidget {
  final String courseName;

  const CourseContent({super.key, required this.courseName});

  @override
  Widget build(BuildContext context) {
    return _getCourseContent(courseName);
  }

  Widget _getCourseContent(String courseName) {
    switch (courseName) {
      case 'Mindfulness':
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.asset('assets/images/mindfulness.jpg'),
            const SizedBox(height: 20),
            const Text(
              'Mindfulness is the practice of being present in the moment. It helps reduce stress and improve mental clarity.',
              style: TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 20),
            const Text(
              'Exercises:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const Text(
              '1. Breathing exercises\n2. Body scan meditation\n3. Mindful walking',
              style: TextStyle(fontSize: 16),
            ),
          ],
        );
      case 'Self-Compassion':
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.asset('assets/images/self_compassion.jpg'),
            const SizedBox(height: 20),
            const Text(
              'Self-compassion involves treating yourself with kindness and understanding during difficult times.',
              style: TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 20),
            const Text(
              'Exercises:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const Text(
              '1. Self-kindness meditation\n2. Loving-kindness meditation\n3. Journaling about self-compassion',
              style: TextStyle(fontSize: 16),
            ),
          ],
        );
      case 'Stress Relief':
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.asset('assets/images/stress_relief.jpg'),
            const SizedBox(height: 20),
            const Text(
              'Stress relief techniques help you manage and reduce stress effectively.',
              style: TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 20),
            const Text(
              'Exercises:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const Text(
              '1. Progressive muscle relaxation\n2. Deep breathing exercises\n3. Visualization techniques',
              style: TextStyle(fontSize: 16),
            ),
          ],
        );
      default:
        return const Text(
          'Course content not available.',
          style: TextStyle(fontSize: 16),
        );
    }
  }
}