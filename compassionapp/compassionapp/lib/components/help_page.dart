import 'package:flutter/material.dart';
import 'package:compassionapp/features/help/help_data.dart';

class HelpPage extends StatelessWidget {
  const HelpPage({super.key});

  @override
  Widget build(BuildContext context) {
    final helpService = HelpData();

    return Scaffold(
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: helpService.getHelpSections(),
      ),
    );
  }
}