// components/journal_entry_page.dart
import 'package:compassionapp/backend/database/databaseHelper.dart';
import 'package:compassionapp/features/journal/journalEntry.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class JournalEntryBox extends StatefulWidget {
  final DateTime date;
  const JournalEntryBox({super.key, required this.date});

  @override
  _JournalEntryBoxState createState() => _JournalEntryBoxState();
}

class _JournalEntryBoxState extends State<JournalEntryBox> {
  String? _selectedMood;
  final List<String> _moods = ['Happy', 'Sad', 'Angry', 'Excited', 'Calm'];
  final TextEditingController _contentController = TextEditingController();
  final FocusNode _contentFocusNode = FocusNode();
  JournalEntry? _journalEntry;

  @override
  void didUpdateWidget(JournalEntryBox oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.date != widget.date) {
      _fetchJournalEntry();
    }
  }

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
        _selectedMood = _moods.contains(_journalEntry!.mood) ? _journalEntry!.mood : null;
      });
    } else {
      _clearFields();
    }
    _contentFocusNode.requestFocus();
  }

  void _clearFields() {
    _contentController.clear();
    setState(() {
      _selectedMood = null;
      _journalEntry = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    final dbHelper = Provider.of<DatabaseHelper>(context);

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
          TextField(
            controller: _contentController,
            decoration: const InputDecoration(
              labelText: 'Write about your day...',
              border: OutlineInputBorder(),
            ),
            maxLines: 5,
          ),
          const SizedBox(height: 10),
          ElevatedButton(
            onPressed: () async {
              final newEntry = JournalEntry(
                id: _journalEntry?.id,
                content: _contentController.text,
                date: widget.date,
                mood: _selectedMood ?? 'Null',
              );
              await dbHelper.insertJournalEntry(newEntry);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Journal entry saved!')),
              );
            },
            child: const Text('Save Entry'),
          ),
        ],
      ),
    );
  }
}