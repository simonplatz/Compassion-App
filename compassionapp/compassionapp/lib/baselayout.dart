import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'GlobalState/state_component.dart';
import 'components/chat_page.dart';
import 'components/courses_page.dart';
import 'components/help_page.dart';
import 'components/home_page.dart';
import 'components/journal_page.dart';
import 'components/location_page.dart';
import 'individual_comps.dart/custom_drawer.dart';
import 'individual_comps.dart/topbar.dart';
import 'individual_comps.dart/navigation.dart';

class BaseLayout extends StatelessWidget {
  BaseLayout({super.key});

  final List<PageItem> _pageItems = [
    const PageItem(page: HomePage(), title: 'Hjem'),
    const PageItem(page: JournalPage(), title: 'Journal'),
    const PageItem(page: CoursesPage(), title: 'Kurser'),
    const PageItem(page: ChatPage(), title: 'Chat'),
    const PageItem(page: LocationPage(), title: 'Lokation'),
    const PageItem(page: HelpPage(), title: 'Hjælp'),
  ];

  Widget _getPage(int index) {
    return _pageItems[index].page;
  }

  String _getTitle(int index) {
    return _pageItems[index].title;
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<AppState>(
      builder: (context, appState, child) {
        return Scaffold(
          appBar: TopBar(title: _getTitle(appState.selectedIndex)), // Use TopBar with dynamic title
          body: _getPage(appState.selectedIndex),
          drawer: const CustomDrawer(),
          bottomNavigationBar: const BottomNavigation(),
        );
      },
    );
  }
}

class PageItem {
  final Widget page;
  final String title;

  const PageItem({required this.page, required this.title});
}