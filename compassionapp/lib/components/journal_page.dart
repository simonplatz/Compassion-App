// components/journal_page.dart
import 'package:flutter/material.dart';

class JournalPage extends StatefulWidget {
  const JournalPage({super.key});

  @override
  _JournalPageState createState() => _JournalPageState();
}

class _JournalPageState extends State<JournalPage> {
  final TextEditingController _controller = TextEditingController();
  String _journalEntry = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Journal'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _controller,
              decoration: const InputDecoration(labelText: 'Write about your day...'),
              maxLines: 5,
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  _journalEntry = _controller.text;
                });
              },
              child: Text('Save Entry'),
            ),
            SizedBox(height: 20),
            const Text(
              'Your Journal Entry:',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            Text(_journalEntry),
          ],
        ),
      ),
    );
  }
}