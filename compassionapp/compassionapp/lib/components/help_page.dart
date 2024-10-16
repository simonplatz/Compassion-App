// components/help_page.dart
import 'package:flutter/material.dart';

class HelpPage extends StatelessWidget {
  const HelpPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Help'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('Important links at SDU'),
            const Text('Psychology pages'),
            const Text('Contact a psychology professional'),
            ElevatedButton(
              onPressed: () {
                // Navigate to emergency help content if necessary
              },
              child: const Text('Emergency Help'),
            ),
          ],
        ),
      ),
    );
  }
}