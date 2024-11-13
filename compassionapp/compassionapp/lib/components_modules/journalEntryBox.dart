import 'package:compassionapp/backend/database/databaseHelper.dart';
import 'package:compassionapp/features/journal/journalEntry.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_xlider/flutter_xlider.dart';

class JournalEntryBox extends StatefulWidget {
  final DateTime date;
  const JournalEntryBox({super.key, required this.date});

  @override
  _JournalEntryBoxState createState() => _JournalEntryBoxState();
}

class _JournalEntryBoxState extends State<JournalEntryBox> {
  double _moodValue = 0;
  final List<Map<String, String>> _moods = [
    {'label': 'Very Bad', 'emoji': '😢'},
    {'label': 'Bad', 'emoji': '😟'},
    {'label': 'Neutral', 'emoji': '😐'},
    {'label': 'Good', 'emoji': '😊'},
    {'label': 'Very Good', 'emoji': '😁'},
  ];
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
        final moodIndex =
            _moods.indexWhere((mood) => mood['label'] == _journalEntry!.mood);
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
            'How do you feel today? ${_moods[_moodValue.toInt()]['emoji']!}',
            style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
          ),
          FlutterSlider(
            values: [_moodValue],
            max: 4,
            min: 0,
            step: const FlutterSliderStep(step: 1),
            handler: FlutterSliderHandler(
              decoration: const BoxDecoration(),
              child: Material(
                type: MaterialType.circle,
                color: Colors.teal,
                elevation: 3,
                child: Container(
                  padding: const EdgeInsets.all(1),
                  child: const Icon(
                    Icons.circle,
                    size: 20,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            trackBar: FlutterSliderTrackBar(
              activeTrackBar: BoxDecoration(color: Colors.teal),
              inactiveTrackBar: BoxDecoration(color: Colors.teal.shade100),
            ),
            tooltip: FlutterSliderTooltip(
              disabled: true,
            ),
            onDragging: (handlerIndex, lowerValue, upperValue) {
              setState(() {
                _moodValue = lowerValue;
              });
            },
          ),
          TextField(
            controller: _contentController,
            decoration: InputDecoration(
              labelText: 'Write about your day...',
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
                padding:
                    const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
              onPressed: () async {
                final newEntry = JournalEntry(
                  id: _journalEntry?.id,
                  content: _contentController.text,
                  date: widget.date,
                  mood: _moods[_moodValue.toInt()]['label']!,
                );
                await dbHelper.insertJournalEntry(newEntry);
                if (mounted) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Journal entry saved!')),
                  );
                }
              },
              child: const Text('Save Entry'),
            ),
          ),
        ],
      ),
    );
  }
}