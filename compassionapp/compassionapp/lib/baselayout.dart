import 'package:compassionapp/individual_comps.dart/navigation.dart';
import 'package:flutter/material.dart';
import 'GlobalState/state_component.dart';
import 'components/chat_page.dart';
import 'components/courses_page.dart';
import 'components/help_page.dart';
import 'components/home_page.dart';
import 'components/journal_page.dart';
import 'components/location_page.dart';
import 'individual_comps.dart/custom_drawer.dart';
import 'individual_comps.dart/topbar.dart';
import 'package:provider/provider.dart';

class BaseLayout extends StatelessWidget {
  const BaseLayout({super.key});

  final List<PageItem> _pageItems = const [
    PageItem(page: HomePage(), title: 'Home'),
    PageItem(page: JournalPage(), title: 'Journal'),
    PageItem(page: CoursesPage(), title: 'Courses'),
    PageItem(page: ChatPage(), title: 'Chat'),
    PageItem(page: LocationPage(), title: 'Location'),
    PageItem(page: HelpPage(), title: 'Help'),
  ];

  Widget _getPage(int index) {
    return _pageItems[index].page;
  }

  String _getTitle(int index) {
    return _pageItems[index].title;
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<AppState>( // here the consumer widget uses the appstate to control the overall page state in the project
      builder: (context, appState, child) {
        return Scaffold(
          appBar: TopBar(title: _getTitle(appState.selectedIndex)), // Use TopBar with dynamic title
          body: _getPage(appState.selectedIndex),
          drawer: const CustomDrawer(),
          bottomNavigationBar: BottomNavigation(
          ),
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