import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:compassionapp/features/courses/CourseData/MindfulnessCourse.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

void main() {
  group('MindfulnessCourseContent Widget Tests', () {
    testWidgets('PageView is present', (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: MindfulnessCourseContent(),
        ),
      );

      expect(find.byType(PageView), findsOneWidget);
    });

    testWidgets('SmoothPageIndicator is present', (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: MindfulnessCourseContent(),
        ),
      );

      expect(find.byType(SmoothPageIndicator), findsOneWidget);
    });

    testWidgets('Navigation buttons are present', (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: MindfulnessCourseContent(),
        ),
      );

      expect(find.byIcon(Icons.arrow_back), findsNothing);
      expect(find.byIcon(Icons.arrow_forward), findsOneWidget);

      // Navigate to the second page
      await tester.drag(find.byType(PageView), const Offset(-400, 0));
      await tester.pumpAndSettle();

      expect(find.byIcon(Icons.arrow_back), findsOneWidget);
      expect(find.byIcon(Icons.arrow_forward), findsOneWidget);
    });

    testWidgets('Page 1 content is correct', (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: MindfulnessCourseContent(),
        ),
      );

      expect(find.text('Lær omkring mindfulness.'), findsOneWidget);
      expect(find.text('Hvad er mindfulness?'), findsOneWidget);
      expect(find.text('Mindfulness er en praksis, hvor man er opmærksom på nuet uden at dømme. Det hjælper med at reducere stress og forbedre mental klarhed.'), findsOneWidget);
    });

    testWidgets('Page 2 content is correct', (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: MindfulnessCourseContent(),
        ),
      );

      // Navigate to the second page
      await tester.drag(find.byType(PageView), const Offset(-400, 0));
      await tester.pumpAndSettle();

      expect(find.text('Mindfulness teknikker inkluderer:'), findsOneWidget);
      expect(find.text('1. Åndedrætsøvelser: Fokus på vejrtrækningen for at bringe opmærksomheden til nuet.'), findsOneWidget);
      expect(find.text('2. Kropsscanning: En teknik, hvor man systematisk fokuserer på forskellige dele af kroppen for at blive opmærksom på spændinger og afslapning.'), findsOneWidget);
      expect(find.text('3. Mindful gåtur: At gå langsomt og bevidst, mens man er opmærksom på hvert skridt og omgivelserne.'), findsOneWidget);
    });

    testWidgets('Page 3 content is correct', (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: MindfulnessCourseContent(),
        ),
      );

      // Navigate to the third page
      await tester.drag(find.byType(PageView), const Offset(-800, 0));
      await tester.pumpAndSettle();

      expect(find.text('Fordele ved mindfulness:'), findsOneWidget);
      expect(find.text('Mindfulness kan hjælpe med at reducere stress, forbedre koncentration og øge følelsesmæssig regulering.'), findsOneWidget);
      expect(find.text('Ved at praktisere mindfulness regelmæssigt kan man opleve en større følelse af ro og velvære.'), findsOneWidget);
    });

    testWidgets('Wrapping up page content is correct', (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: MindfulnessCourseContent(),
        ),
      );

      // Navigate to the fourth page
      await tester.drag(find.byType(PageView), const Offset(-1200, 0));
      await tester.pumpAndSettle();

      expect(find.text('Afslutning'), findsOneWidget);
      expect(find.text('Tak fordi du deltog i mindfulness kurset. Vi håber, at du har lært noget værdifuldt og kan anvende teknikkerne i din dagligdag.'), findsOneWidget);
      expect(find.text('Tilbage til kurssiden'), findsOneWidget);
    });
  });
}