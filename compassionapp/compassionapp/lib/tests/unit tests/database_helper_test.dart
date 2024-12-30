import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:compassionapp/backend/database/databaseHelper.dart';
import 'package:compassionapp/features/journal/journalEntry.dart';

class MockDatabaseHelper extends Mock implements DatabaseHelper {}

void main() {
  group('DatabaseHelper Tests', () {
    late MockDatabaseHelper mockDatabaseHelper;

    setUp(() {
      mockDatabaseHelper = MockDatabaseHelper();
    });

    test('insertJournalEntry inserts a journal entry', () async {
      final entry = JournalEntry(
        content: 'Test entry',
        date: DateTime.now(),
        mood: 'Happy',
      );

      // Set up the mock method to return a Future<void>
      when(mockDatabaseHelper.insertOrUpdateJournalEntry(entry)).thenAnswer((_) async => Future.value());

      await mockDatabaseHelper.insertOrUpdateJournalEntry(entry);
      verify(mockDatabaseHelper.insertOrUpdateJournalEntry(entry)).called(1);
    });

    test('getJournalEntries returns a list of journal entries', () async {
      final mockEntries = [
        JournalEntry(
          content: 'Test entry',
          date: DateTime.now(),
          mood: 'Happy',
        ),
      ];

      when(mockDatabaseHelper.getJournalEntries()).thenAnswer((_) async => Future.value(mockEntries));

      final entries = await mockDatabaseHelper.getJournalEntries();

      expect(entries.length, 1);
      expect(entries.first.content, 'Test entry');
    });
  });
}