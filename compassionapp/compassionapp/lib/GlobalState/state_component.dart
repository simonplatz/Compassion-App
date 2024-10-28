import 'package:compassionapp/features/courses/courseData.dart';
import 'package:flutter/material.dart';

class AppState extends ChangeNotifier {
  int _selectedIndex = 0;
  Locale _locale = const Locale('en');
  final CourseData _courseData = CourseData();

  int get selectedIndex => _selectedIndex;
  Locale get locale => _locale;
  CourseData get courseData => _courseData;

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
}