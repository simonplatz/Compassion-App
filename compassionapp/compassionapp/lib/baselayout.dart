import 'package:compassionapp/features/page/pageItem.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'GlobalState/state_component.dart';
import 'components/journal_page.dart';
import 'individual_comps.dart/custom_drawer.dart';
import 'individual_comps.dart/topbar.dart';
import 'individual_comps.dart/navigation.dart';

class BaseLayout extends StatelessWidget {
  BaseLayout({super.key});

  Widget _getPage(int index, DateTime? selectedJournalDate) {
    if (index == 1 && selectedJournalDate != null) {
      return JournalPage(selectedDate: selectedJournalDate);
    }
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
          body: _getPage(appState.selectedIndex, appState.selectedJournalDate),
          drawer: const CustomDrawer(),
          bottomNavigationBar: const BottomNavigation(),
        );
      },
    );
  }
}
