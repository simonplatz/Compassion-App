import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:compassionapp/styling_component/styling_comp.dart';
import '../components_modules/journalEntryBox.dart'; // Import the StyledCard widget

class JournalPage extends StatefulWidget {
  const JournalPage({super.key});

  @override
  _JournalPageState createState() => _JournalPageState();
}

class _JournalPageState extends State<JournalPage> {
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          StyledCard(
            child: TableCalendar(
              firstDay: DateTime.utc(2000, 1, 1),
              lastDay: DateTime.utc(2100, 12, 31),
              calendarStyle: CalendarStyle(
                selectedDecoration: BoxDecoration(
                  color: Colors.teal,
                  shape: BoxShape.circle,
                ),
                todayDecoration: BoxDecoration(
                  color: Colors.teal.shade100,
                  shape: BoxShape.circle,
                ),
                markersMaxCount: 1,
              ),
              focusedDay: _focusedDay,
              selectedDayPredicate: (day) {
                return isSameDay(_selectedDay, day);
              },
              onDaySelected: (selectedDay, focusedDay) {
                setState(() {
                  if (isSameDay(_selectedDay, selectedDay)) {
                    _selectedDay = null;
                  } else {
                    _selectedDay = selectedDay;
                  }
                  _focusedDay = focusedDay;
                });
              },
              calendarFormat: CalendarFormat.month,
              onPageChanged: (focusedDay) {
                _focusedDay = focusedDay;
              },
              headerStyle: HeaderStyle(
                formatButtonVisible: false,
                titleCentered: true,
              ),
            ),
          ),
          if (_selectedDay != null)
            Expanded(
              child: StyledCard(
                child: SingleChildScrollView(
                  child: JournalEntryBox(date: _selectedDay!),
                ),
              ),
            ),
        ],
      ),
    );
  }
}