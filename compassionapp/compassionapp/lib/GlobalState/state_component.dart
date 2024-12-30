import 'package:compassionapp/features/courses/courseManager.dart';
import 'package:flutter/material.dart';

class AppState extends ChangeNotifier {
  int _selectedIndex = 0;
  Locale _locale = const Locale('en');
  final CourseManager _courseManager = CourseManager();
  DateTime? _selectedJournalDate;

  int get selectedIndex => _selectedIndex;
  Locale get locale => _locale;
  CourseManager get courseManager => _courseManager;
  DateTime? get selectedJournalDate => _selectedJournalDate;

  void setSelectedIndex(int index) {
    _selectedIndex = index;
    notifyListeners();
  }

  void toggleLanguage() {
    if (_locale.languageCode == 'en') {
      _locale = const Locale('dk');
    } else {
      _locale = const Locale('en');
    }
    notifyListeners();
  }

  void navigateToJournal(DateTime date) {
    _selectedJournalDate = date;
    _selectedIndex = 1; // this is the index for journal
    notifyListeners();
  }

  void setSelectedJournalDate(DateTime date) {
    _selectedJournalDate = date;
    notifyListeners();
  }
}
