import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../GlobalState/state_component.dart';

class TopBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  const TopBar({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    final appState = Provider.of<AppState>(context);

    return AppBar(
      backgroundColor: Colors.teal,
      leading: Builder(
        builder: (context) {
          return IconButton(
            icon: const Icon(Icons.menu),
            onPressed: () {
              Scaffold.of(context).openDrawer();
            },
          );
        },
      ),
      title: Text(title, textAlign: TextAlign.center),
      centerTitle: true,
      actions: [
        IconButton(
          icon: Icon(
            appState.locale.languageCode == 'en' ? Icons.flag : Icons.flag_circle, 
          ),
          onPressed: () {
            appState.toggleLanguage();
          },
        ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}