import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../GlobalState/state_component.dart';
import 'package:compassionapp/features/page/pageItem.dart';

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
                ...pageItems.asMap().entries.map((entry) {
                  int index = entry.key;
                  PageItem pageItem = entry.value;
                  return ListTile(
                    leading: pageItem.icon,
                    title: Text(pageItem.title),
                    onTap: () {
                      appState.setSelectedIndex(index);
                      Navigator.pop(context);
                    },
                  );
                })
              ],
            ),
          ),
        );
      },
    );
  }
}