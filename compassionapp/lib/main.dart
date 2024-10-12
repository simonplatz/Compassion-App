import 'package:flutter/material.dart';
import 'components/start_screen.dart';
import 'components/home_page.dart';
import 'components/journal_page.dart';
import 'components/courses_page.dart';
import 'components/therapy_page.dart';
import 'components/chat_page.dart';
import 'components/location_page.dart';
import 'components/help_page.dart';


void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: Scaffold(
        body: Center(
          child: Text('Hello World!'),
        ),
      ),
    );
  }
}
