// lib/components_modules/journalEntryBox.dart
import 'package:compassionapp/backend/database/databaseHelper.dart';
import 'package:compassionapp/features/journal/journalEntry.dart';
import 'package:compassionapp/features/journal/moodManager.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class JournalEntryBox extends StatefulWidget {
  final DateTime date;
  const JournalEntryBox({super.key, required this.date});

  @override
  _JournalEntryBoxState createState() => _JournalEntryBoxState();
}

class _JournalEntryBoxState extends State<JournalEntryBox> {
  double _moodValue = 0;
  final TextEditingController _contentController = TextEditingController();
  final FocusNode _contentFocusNode = FocusNode();
  JournalEntry? _journalEntry;

  @override
  void initState() {
    super.initState();
    _fetchJournalEntry();
  }

  void _fetchJournalEntry() async {
    final dbHelper = Provider.of<DatabaseHelper>(context, listen: false);
    final entry = await dbHelper.getJournalEntryForDate(widget.date);
    if (entry != null) {
      setState(() {
        _journalEntry = entry;
        _contentController.text = _journalEntry!.content;
        final moodIndex = MoodManager.moods.indexWhere((mood) => mood['label'] == _journalEntry!.mood);
        _moodValue = moodIndex != -1 ? moodIndex.toDouble() : 0.0;
      });
    } else {
      _clearFields();
    }
    _contentFocusNode.requestFocus();
  }

  void _clearFields() {
    _contentController.clear();
    setState(() {
      _moodValue = 0;
      _journalEntry = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    final dbHelper = DatabaseHelper();
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Hvordan har du det i dag?',
            style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
          ),
          DropdownButton<int>(
            alignment: Alignment.center,
            value: _moodValue.toInt(),
            items: List.generate(MoodManager.moods.length, (index) {
              return DropdownMenuItem<int>(
                value: index,
                child: Text(
                  '${MoodManager.moods[index]['emoji']} ${MoodManager.moods[index]['label']}',
                  style: TextStyle(fontSize: 24.0),
                ),
              );
            }),
            onChanged: (int? newValue) {
              setState(() {
                _moodValue = newValue!.toDouble();
              });
            },
          ),
          TextField(
            controller: _contentController,
            decoration: InputDecoration(
              labelText: 'Skriv om din dag...',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12.0),
              ),
              filled: true,
              fillColor: Colors.teal.shade50,
            ),
            maxLines: 7,
          ),
          Center(
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.white,
                backgroundColor: Colors.teal,
                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
              onPressed: () async {
                final newEntry = JournalEntry(
                  id: _journalEntry?.id,
                  content: _contentController.text,
                  date: widget.date,
                  mood: MoodManager.moods[_moodValue.toInt()]['label']!,
                );
                await dbHelper.insertJournalEntry(newEntry);
                if (mounted) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Dagbogsindlæg gemt!')),
                  );
                }
              },
              child: const Text('Gem Indlæg'),
            ),
          ),
        ],
      ),
    );
  }
}