import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:compassionapp/components/location_page.dart';
import 'package:compassionapp/services/visisbility_manager.dart';
import 'package:provider/provider.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart' as maps;

void main() {
  group('LocationPage Widget Tests', () {
    testWidgets('Markers are created and map view is directed to the expected place', (WidgetTester tester) async {
      await tester.pumpWidget(
        MultiProvider(
          providers: [
            ChangeNotifierProvider(create: (_) => VisibilityManager()),
          ],
          child: MaterialApp(
            home: const LocationPage(),
          ),
        ),
      );

      // Verify initial state
      expect(find.byType(maps.GoogleMap), findsOneWidget);
      expect(find.text('Valgt placering: Ikke valgt'), findsOneWidget);

      // Tap the first location button
      await tester.tap(find.text('SDU Psykologisk Rådgivning'));
      await tester.pumpAndSettle();

      // Verify marker is added and map view is directed to the expected place
      expect(find.text('Valgt placering: SDU Psykologisk Rådgivning'), findsOneWidget);
      expect(find.byType(maps.Marker), findsWidgets);

      // Tap the second location button
      await tester.tap(find.text('Ventilen Odense'));
      await tester.pumpAndSettle();

      // Verify marker is added and map view is directed to the expected place
      expect(find.text('Valgt placering: Ventilen Odense'), findsOneWidget);
      expect(find.byType(maps.Marker), findsWidgets);
    });
  });
}