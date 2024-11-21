import 'package:compassionapp/GlobalState/state_component.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MindfulnessQuiz extends StatefulWidget {
  const MindfulnessQuiz({super.key});

  @override
  _MindfulnessQuizState createState() => _MindfulnessQuizState();
}

class _MindfulnessQuizState extends State<MindfulnessQuiz> {
  final List<Map<String, dynamic>> _questions = [
    {
      'question':
          'Jeg kunne opleve en følelse og ikke være bevidst om det før noget tid senere.',
      'options': ['Aldrig', 'Sjældent', 'Nogle gange', 'Ofte', 'Altid'],
      'selectedOption': null,
    },
    {
      'question':
          'Jeg bryder eller spilder ting på grund af skødesløshed, ikke at være opmærksom eller tænke på noget andet.',
      'options': ['Aldrig', 'Sjældent', 'Nogle gange', 'Ofte', 'Altid'],
      'selectedOption': null,
    },
    // Add more questions here
  ];

  void _submitQuiz() {
    bool allAnswered =
        _questions.every((question) => question['selectedOption'] != null);

    if (!allAnswered) {
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('Ubesvarede spørgsmål',
                style: TextStyle(fontWeight: FontWeight.bold)),
            content: Text(
                'Besvar venligst alle spørgsmål, før du indsender quizzen.'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text('OK', style: TextStyle(color: Colors.teal)),
              ),
            ],
          );
        },
      );
      return;
    }
    showDialog(
      context: context,
      builder: (context) {
      return AlertDialog(
        title: Text('Tak!', style: TextStyle(fontWeight: FontWeight.bold)),
        content: Text(
          'Tak fordi du tog quizzen. Du vil nu blive omdirigeret til kursussiden.'),
        actions: [
        TextButton(
          onPressed: () {
          // this is used to get out of the content and back to the course page
          Navigator.of(context).popUntil((route) => route.isFirst);
          },
          child: Text('OK', style: TextStyle(color: Colors.teal)),
        ),
        ],
      );
      },
    );
    }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Mindfulness Quiz'),
        backgroundColor: Colors.teal,
      ),
      body: ListView.builder(
        itemCount: _questions.length,
        itemBuilder: (context, index) {
          final question = _questions[index];
          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Card(
              elevation: 4.0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      question['question'],
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    ...question['options'].map<Widget>((option) {
                      return RadioListTile(
                        title: Text(option),
                        value: option,
                        groupValue: question['selectedOption'],
                        onChanged: (value) {
                          setState(() {
                            question['selectedOption'] = value;
                          });
                        },
                        activeColor: Colors.teal,
                      );
                    }).toList(),
                  ],
                ),
              ),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _submitQuiz,
        backgroundColor: Colors.teal,
        child: Icon(Icons.check),
      ),
    );
  }
}
