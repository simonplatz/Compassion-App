import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:compassionapp/components/help_page.dart';
import 'package:mocktail/mocktail.dart';
import 'package:url_launcher/url_launcher.dart';

class LaunchMock extends Mock {
  Future<bool> call(
    Uri url, {
    LaunchMode? mode,
    String? inAppBrowserView,
  });
}

void main() {
  setUpAll(() {
    registerFallbackValue(LaunchMode.inAppBrowserView);
  });

  testWidgets('Links are displayed as a list and open in the browser',
      (WidgetTester tester) async {
    // Create the mock
    final mock = LaunchMock();
    when(() => mock(
          any(),
          mode: any(named: 'mode'),
          inAppBrowserView: any(named: 'inAppBrowserView'),
        )).thenAnswer((_) async => true);

    await tester.pumpWidget(
      MaterialApp(
        home: const HelpPage(),
      ),
    );

    // Verify initial state
    expect(find.byType(ListView), findsOneWidget);
    expect(find.text('Vigtige Links hos SDU'), findsOneWidget);
    expect(find.text('Ressourcer på SDU'), findsOneWidget);
    expect(find.text('Psykologisk Hjælp i Odense'), findsOneWidget);
    expect(find.text('Podcasts').first, findsOneWidget);

    await tester.tap(find.text('SDU Ressourcer'));
    // Scroll to the link and tap it
    await tester.scrollUntilVisible(
      find.text('Studievalg Danmark'),
      500.0,
    );
    await tester.tap(find.text('Studievalg Danmark'));
    await tester.pumpAndSettle();

    // Verify the link is opened in the browser
    verify(() => mock(Uri.parse('https://studievalg.dk/?'))).called(1);
  });
}
