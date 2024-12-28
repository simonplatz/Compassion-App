import 'package:flutter_test/flutter_test.dart';
import 'package:compassionapp/GlobalState/state_component.dart';

void main() {
  group('AppState Tests', () {
    late AppState appState;

    setUp(() {
      appState = AppState();
    });

    test('Initial selectedIndex is 0', () {
      expect(appState.selectedIndex, 0);
    });

    test('setSelectedIndex updates selectedIndex', () {
      appState.setSelectedIndex(2);
      expect(appState.selectedIndex, 2);
    });


    test('navigateToJournal updates selectedJournalDate and selectedIndex', () {
      final date = DateTime.now();
      appState.navigateToJournal(date);
      expect(appState.selectedJournalDate, date);
      expect(appState.selectedIndex, 1);
    });
  });
}