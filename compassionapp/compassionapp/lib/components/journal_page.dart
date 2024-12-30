import 'package:compassionapp/GlobalState/state_component.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:compassionapp/styling_component/styling_comp.dart';
import '../features/journal/journalEntryBox.dart';

class JournalPage extends StatelessWidget {
  const JournalPage({super.key});

  @override
  Widget build(BuildContext context) {
    final appState = Provider.of<AppState>(context);
    final DateTime focusedDay = appState.selectedJournalDate ?? DateTime.now();

    return Scaffold(
      body: Column(
        children: [
          StyledCard(
            child: TableCalendar(
              firstDay: DateTime.utc(2000, 1, 1),
              lastDay: DateTime.utc(2100, 12, 31),
              focusedDay: focusedDay,
              availableCalendarFormats: const {
                CalendarFormat.month: 'Month',
              },
              selectedDayPredicate: (day) {
                return isSameDay(appState.selectedJournalDate, day);
              },
              onDaySelected: (selectedDay, focusedDay) {
                appState.setSelectedJournalDate(selectedDay);
              },
              calendarStyle: CalendarStyle(
                selectedDecoration: BoxDecoration(
                  color: Colors.teal,
                  shape: BoxShape.circle,
                ),
                todayDecoration: BoxDecoration(
                  color: Colors.teal[100],
                  shape: BoxShape.circle,
                ),
              ),
            ),
          ),
          if (appState.selectedJournalDate != null)
            JournalEntryBox(
              key: ValueKey(appState.selectedJournalDate),
              date: appState.selectedJournalDate!,
            ),
        ],
      ),
    );
  }
}
