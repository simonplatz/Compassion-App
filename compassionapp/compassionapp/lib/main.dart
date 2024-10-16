import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'baselayout.dart';
import 'GlobalState/state_component.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => AppState(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Compassion App',
      theme: ThemeData(
        primarySwatch: Colors.teal,
      ),
      home: const BaseLayout(),
    );
  }
}