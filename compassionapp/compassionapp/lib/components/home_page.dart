import 'package:compassionapp/features/journal/moodManager.dart';
import 'package:flutter/material.dart';
import 'package:compassionapp/backend/database/databaseHelper.dart';
import 'package:compassionapp/features/courses/courseManager.dart';
import 'package:compassionapp/features/courses/courseListWidget.dart';
import 'package:compassionapp/features/journal/journalEntry.dart';
import 'package:provider/provider.dart';
import 'package:compassionapp/GlobalState/state_component.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final courseManager = Provider.of<CourseManager>(context);
    final dbHelper = Provider.of<DatabaseHelper>(context);

    final appState = Provider.of<AppState>(context);


    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Courses',
                    style: TextStyle(
                      fontSize: 24.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      appState.setSelectedIndex(2); // Assuming 2 is the index for the CoursesPage
                    },
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.white,
                      backgroundColor: Colors.teal,
                      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                      textStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                    ),
                    child: const Text('See All'),
                  ),
                ],
              ),
            ),
            CourseListWidget(
              courses: courseManager.courses,
            ),
            FutureBuilder<List<JournalEntry>>(
              future: dbHelper.getJournalEntries(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(child: Text('Fejl: ${snapshot.error}'));
                } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return const Center(
                      child: Text('Ingen journalindlæg fundet.'));
                } else {
                  final journalEntries = snapshot.data!;
                  final recentEntries =
                      dbHelper.getRecentEntries(journalEntries);
                  recentEntries.sort((a, b) => a.date.compareTo(b.date));
                  return Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Tidligere Humør',
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 10),
                        Container(
                          padding: const EdgeInsets.all(8.0),
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.teal),
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                          child: SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: Row(
                              children: recentEntries.map((entry) {
                                return Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                    children: [
                                      Text(
                                        '${entry.date.day}/${entry.date.month}',
                                        style: const TextStyle(fontSize: 16),
                                      ),
                                      const SizedBox(height: 5),
                                      Text(
                                        MoodManager.getMoodEmoji(entry.mood),
                                        style: const TextStyle(fontSize: 40),
                                      ),
                                      const SizedBox(height: 5),
                                      Text(
                                        entry.mood,
                                        style: const TextStyle(fontSize: 16),
                                      ),
                                    ],
                                  ),
                                );
                              }).toList(),
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                }
              },
            ),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
              child: ElevatedButton.icon(
                onPressed: () {
                  appState.navigateToJournal(DateTime.now());
                },
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.white,
                  backgroundColor: Colors.teal,
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                  textStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                ),
                icon: const Icon(Icons.edit),
                label: const Text('Go to Journal and Select Mood'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
