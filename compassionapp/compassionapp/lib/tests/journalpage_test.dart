import 'package:compassionapp/features/journal/journalEntry.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:compassionapp/components/journal_page.dart';
import 'package:compassionapp/backend/database/databaseHelper.dart';
import 'package:mockito/annotations.dart';

class MockDatabaseHelper extends Mock implements DatabaseHelper {}

@GenerateMocks([DatabaseHelper])
void main() {
  group('JournalPage Widget Tests', () {
    late MockDatabaseHelper mockDatabaseHelper;

    setUp(() {
      mockDatabaseHelper = MockDatabaseHelper();
    });

    testWidgets('The user can write in the journal and save their data and mood', (WidgetTester tester) async {
      JournalEntry entry = JournalEntry(
        content: 'Today I practiced mindfulness and felt calm.',
        date: DateTime.now(),
        mood: 'Happy',
      );
      when(mockDatabaseHelper.insertOrUpdateJournalEntry(entry)).thenAnswer((_) async => Future.value());
      await tester.pumpWidget(JournalPage());

      // Write in the journal
      await tester.enterText(find.byType(TextField), 'Today I practiced mindfulness and felt calm.');

      // Select a mood
      await tester.tap(find.byType(DropdownButton<String>));
      await tester.pumpAndSettle();
      await tester.tap(find.text('Happy').last);
      await tester.pumpAndSettle();

      // Save the data
      await tester.tap(find.text('Save'));
      await tester.pumpAndSettle();

      // Verify that the data is saved in the database
      verify(mockDatabaseHelper.insertOrUpdateJournalEntry(entry)).called(1);
    });
  });
}