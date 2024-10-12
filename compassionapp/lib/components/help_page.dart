// components/help_page.dart
import 'package:flutter/material.dart';

class HelpPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Help Page'),
      ),
      body: Center(
        child: Column(
          children: [
            Text('Important links at SDU'),
            Text('Psychology pages'),
            Text('Contact a psychology professional'),
            ElevatedButton(
              onPressed: () {
                // Navigate to emergency help content if necessary
              },
              child: Text('Emergency Help'),
            ),
          ],
        ),
      ),
    );
  }
}
