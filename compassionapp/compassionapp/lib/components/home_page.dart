import 'package:compassionapp/backend/database/databaseHelper.dart';
import 'package:compassionapp/features/courses/courseManager.dart';
import 'package:compassionapp/features/courses/courseListWidget.dart';
import 'package:compassionapp/features/journal/journalEntry.dart';
import 'package:flutter/material.dart';
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
            CourseListWidget(
              courses: courseManager.courses,
            ),
            FutureBuilder<List<JournalEntry>>(
              future: dbHelper.getJournalEntries(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return const Center(child: Text('No journal entries found.'));
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
                          'Previous Moods',
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
                                      Text(
                                        _getMoodEmoji(entry.mood),
                                        style: const TextStyle(fontSize: 40),
                                      ),
                                      Text(entry.mood,
                                          style: const TextStyle(fontSize: 16)),
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
              icon: const Text('😊'),
              label: const Expanded(
                child: Center(
                child: Text('Gå til Journal og Vælg Humør'),
                ),
              ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

String _getMoodEmoji(String mood) {
  switch (mood) {
    case 'Excited':
      return '😃';
    case 'Happy':
      return '😊';
    case 'Neutral':
      return '😐';
    case 'Sad':
      return '😢';
    case 'Angry':
      return '😠';
    default:
      return '😶';
  }
}