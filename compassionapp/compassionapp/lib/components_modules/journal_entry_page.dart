// components/journal_entry_page.dart
import 'package:flutter/material.dart';

class JournalEntryBox extends StatefulWidget {
  final DateTime date;

  const JournalEntryBox({super.key, required this.date});

  @override
  _JournalEntryBoxState createState() => _JournalEntryBoxState();
}

class _JournalEntryBoxState extends State<JournalEntryBox> {
  String? _selectedMood;
  final List<String> _moods = ['Happy', 'Sad', 'Angry', 'Excited', 'Calm'];


  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            'Journal Entry - ${widget.date.day}/${widget.date.month}/${widget.date.year}',
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 10),
          DropdownButtonFormField<String>(
            decoration: const InputDecoration(
              labelText: 'Select your mood',
              border: OutlineInputBorder(),
            ),
            value: _selectedMood,
            items: _moods.map((String mood) {
              return DropdownMenuItem<String>(
                value: mood,
                child: Text(mood),
              );
            }).toList(),
            onChanged: (String? newValue) {
              setState(() {
                _selectedMood = newValue;
              });
            },
          ),
          const SizedBox(height: 10),
          const TextField(
            decoration: InputDecoration(
              labelText: 'Write about your day...',
              border: OutlineInputBorder(),
            ),
            maxLines: 5,
          ),
          const SizedBox(height: 10),
          ElevatedButton(
            onPressed: () {
              // Save the entry along with the selected mood
            },
            child: const Text('Save Entry'),
          ),
        ],
      ),
    );
  }
}