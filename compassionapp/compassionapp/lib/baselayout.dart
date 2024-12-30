import 'package:compassionapp/features/page/pageItem.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'GlobalState/state_component.dart';
import 'individual_comps.dart/custom_drawer.dart';
import 'individual_comps.dart/topbar.dart';
import 'individual_comps.dart/navigation.dart';

class BaseLayout extends StatelessWidget {
  const BaseLayout({super.key});

  Widget _getPage(int index) {
    return pageItems[index].page;
  }

  String _getTitle(int index) {
    return pageItems[index].title;
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<AppState>(
      builder: (context, appState, child) {
        return Scaffold(
          appBar: TopBar(title: _getTitle(appState.selectedIndex)),
          body: _getPage(appState.selectedIndex),
          drawer: const CustomDrawer(),
          bottomNavigationBar: const BottomNavigation(),
        );
      },
    );
  }
}
