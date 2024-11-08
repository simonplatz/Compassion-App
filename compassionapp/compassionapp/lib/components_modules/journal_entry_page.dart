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
    {'emoji': '😃', 'label': 'Excited'},
    {'emoji': '😊', 'label': 'Happy'},
    {'emoji': '😌', 'label': 'Calm'},
    {'emoji': '😢', 'label': 'Sad'},
    {'emoji': '😡', 'label': 'Angry'},
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
    final dbHelper = Provider.of<DatabaseHelper>(context);
    return SingleChildScrollView(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            'Journal Entry - ${widget.date.day}/${widget.date.month}/${widget.date.year}',
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 2),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                _moods[_moodValue.toInt()]['emoji']!,
                style: const TextStyle(fontSize: 24),
              ),
              const SizedBox(width: 8),
              Text(
                _moods[_moodValue.toInt()]['label']!,
                style: const TextStyle(fontSize: 18),
              ),
            ],
          ),
          FlutterSlider(
            values: [_moodValue],
            max: (_moods.length - 1).toDouble(),
            min: 0,
            step: FlutterSliderStep(step: 1),
            handler: FlutterSliderHandler(
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.teal,
                  shape: BoxShape.circle,
                ),
                child: Text(
                  _moods[_moodValue.toInt()]['emoji']!,
                  style: const TextStyle(fontSize: 24),
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
            decoration: const InputDecoration(
              labelText: 'Write about your day...',
              border: OutlineInputBorder(),
            ),
            maxLines: 5,
          ),
          ElevatedButton(
            onPressed: () async {
              final newEntry = JournalEntry(
                id: _journalEntry?.id,
                content: _contentController.text,
                date: widget.date,
                mood: _moods[_moodValue.toInt()]['label']!,
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
