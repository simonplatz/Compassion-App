import 'package:compassionapp/GlobalState/state_component.dart';
import 'package:compassionapp/features/page/pageItem.dart';
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
      items: pageItems.map((pageItem) {
        return BottomNavigationBarItem(icon: pageItem.icon,label: pageItem.title, backgroundColor: Colors.white,);
      }).toList(),
      selectedItemColor: Colors.teal,
      unselectedItemColor: Colors.blueGrey,
      selectedLabelStyle: const TextStyle(
        color: Colors.teal,
        fontSize: 14.0,
      ),
      unselectedLabelStyle: const TextStyle(
        color: Colors.blueGrey,
        fontSize: 12.0,
      ),
      backgroundColor: Colors.white,
    );
  }
}
