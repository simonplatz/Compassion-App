import 'package:compassionapp/GlobalState/state_component.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class BottomNavigation extends StatelessWidget {
  const BottomNavigation({super.key});
  @override
  Widget build(BuildContext context) {
    final AppState appState = Provider.of<AppState>(context);

    return BottomNavigationBar(
      currentIndex: appState.selectedIndex,
      onTap: (index) {
        appState.setSelectedIndex(index);
      },
      type: BottomNavigationBarType.fixed,
      iconSize: 30.0,
      items: const <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          label: 'Hjem',
          backgroundColor: Colors.white,
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.book),
          label: 'Journal',
          backgroundColor: Colors.white,
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.school),
          label: 'Kurser',
          backgroundColor: Colors.white,
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.chat),
          label: 'Chat',
          backgroundColor: Colors.white,
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.location_on),
          label: 'Lokation',
          backgroundColor: Colors.white,
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.help),
          label: 'Hjælp',
          backgroundColor: Colors.white,
        ),
      ],
      selectedItemColor: Colors.teal,
      unselectedItemColor: Colors.blueGrey,
      selectedLabelStyle: const TextStyle(
        color: Colors.teal,
        fontSize: 14.0,
      ), // Set color for selected label
      unselectedLabelStyle: const TextStyle(
        color: Colors.blueGrey,
        fontSize: 12.0,
      ),
      backgroundColor: Colors.white,
    );
  }
}
