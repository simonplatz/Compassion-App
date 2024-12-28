// import 'package:compassionapp/features/journal/journalEntry.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_test/flutter_test.dart';
// import 'package:mockito/mockito.dart';
// import 'package:provider/provider.dart';
// import 'package:compassionapp/components/journal_page.dart';
// import 'package:compassionapp/backend/database/databaseHelper.dart';

// class MockDatabaseHelper extends Mock implements DatabaseHelper {}

// void main() {
//   group('JournalPage Widget Tests', () {
//     late MockDatabaseHelper mockDatabaseHelper;

//     setUp(() {
//       mockDatabaseHelper = MockDatabaseHelper();
//     });

//     testWidgets('User can write in the journal and save their data and mood', (WidgetTester tester) async {
//       await tester.pumpWidget(
//         ChangeNotifierProvider<DatabaseHelper>.value(
//           value: mockDatabaseHelper,
//           child: MaterialApp(
//             home: const JournalPage(),
//           ),
//         ),
//       );

//       // Write in the journal
//       await tester.enterText(find.byType(TextField), 'Today I practiced mindfulness and felt calm.');

//       // Select a mood
//       await tester.tap(find.byType(DropdownButton<String>));
//       await tester.pumpAndSettle();
//       await tester.tap(find.text('Happy').last);
//       await tester.pumpAndSettle();

//       // Save the data
//       await tester.tap(find.text('Save'));
//       await tester.pumpAndSettle();

//       // Verify that the data is saved in the database
//       verify(mockDatabaseHelper.insertJournalEntry(
//         argThat(
//           isA<JournalEntry>()
//               .having((entry) => entry.content, 'content', 'Today I practiced mindfulness and felt calm.')
//               .having((entry) => entry.mood, 'mood', 'Happy')
//               .having((entry) => entry.date, 'date', isNotNull),
//           named: 'entry',
//         ),
//       )).called(1);
//     });
//   });
// }