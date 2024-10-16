import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../GlobalState/state_component.dart';

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<AppState>(
      builder: (context, appState, child) {
        return SizedBox(
          width: 230, // Set the width of the drawer
          child: Drawer(
            child: ListView(
              padding: EdgeInsets.zero,
              children: <Widget>[
                const SizedBox(
                  height: 100, // Set the height of the DrawerHeader
                  child: DrawerHeader(
                    decoration: BoxDecoration(
                      color: Colors.teal,
                    ),
                    child: Text(
                      'Compassion App',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 24,
                      ),
                    ),
                  ),
                ),
                ListTile(
                  leading: const Icon(Icons.home),
                  title: const Text('Home'),
                  onTap: () {
                    appState.setSelectedIndex(0);
                    Navigator.pop(context);
                  },
                ),
                ListTile(
                  leading: const Icon(Icons.book),
                  title: const Text('Journal'),
                  onTap: () {
                    appState.setSelectedIndex(1);
                    Navigator.pop(context);
                  },
                ),
                ListTile(
                  leading: const Icon(Icons.school),
                  title: const Text('Courses'),
                  onTap: () {
                    appState.setSelectedIndex(2);
                    Navigator.pop(context);
                  },
                ),
                ListTile(
                  leading: const Icon(Icons.chat),
                  title: const Text('Chat'),
                  onTap: () {
                    appState.setSelectedIndex(3);
                    Navigator.pop(context);
                  },
                ),
                ListTile(
                  leading: const Icon(Icons.location_on),
                  title: const Text('Location'),
                  onTap: () {
                    appState.setSelectedIndex(4);
                    Navigator.pop(context);
                  },
                ),
                ListTile(
                  leading: const Icon(Icons.help),
                  title: const Text('Help'),
                  onTap: () {
                    appState.setSelectedIndex(5);
                    Navigator.pop(context);
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}