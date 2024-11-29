import 'package:compassionapp/components/chat_page.dart';
import 'package:compassionapp/components/courses_page.dart';
import 'package:compassionapp/components/help_page.dart';
import 'package:compassionapp/components/home_page.dart';
import 'package:compassionapp/components/journal_page.dart';
import 'package:compassionapp/components/location_page.dart';
import 'package:flutter/material.dart';

class PageItem {
  final Widget page;
  final String title;
  final Icon icon;

  const PageItem({required this.page, required this.title, required this.icon});
}

const List<PageItem> pageItems = [
  PageItem(page: HomePage(), title: 'Hjem', icon: Icon(Icons.home)),
  PageItem(page: JournalPage(), title: 'Journal', icon: Icon(Icons.book)),
  PageItem(page: CoursesPage(), title: 'Kurser', icon: Icon(Icons.school)),
  PageItem(page: ChatPage(), title: 'Chat', icon: Icon(Icons.chat)),
  PageItem(page: LocationPage(), title: 'Lokation', icon: Icon(Icons.location_on)),
  PageItem(page: HelpPage(), title: 'Hjælp', icon: Icon(Icons.help)),
];