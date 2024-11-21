import 'package:compassionapp/GlobalState/state_component.dart';
import 'package:compassionapp/features/courses/courseManager.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class TherapyPage extends StatelessWidget {
  final String courseName;
  const TherapyPage({super.key, required this.courseName});

  @override
  Widget build(BuildContext context) {
    final appState = Provider.of<AppState>(context);
    return Consumer<CourseManager>(
      builder: (context, courseManager, child) {
        final course = courseManager.getCourseByName(courseName);
        return Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.teal,
            title: Text(courseName, textAlign: TextAlign.center),
            centerTitle: true,
            actions: [
              if (course.completed) // Ensure completed is not null
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.white,
                      backgroundColor: Colors.black,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16.0, vertical: 8.0),
                    ),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Text('Gennemført'),
                  ),
                ),
            ],
          ),
          body: Padding(
            padding: const EdgeInsets.all(0),
            child: courseManager.getCourseContent(courseName),
          ),
        );
      },
    );
  }
}
