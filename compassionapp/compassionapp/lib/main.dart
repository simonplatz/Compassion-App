import 'package:compassionapp/features/courses/courseManager.dart';
import 'package:compassionapp/services/visisbility_manager.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'baselayout.dart';
import 'GlobalState/state_component.dart';
import 'backend/database/databaseHelper.dart';
import 'components/localisation/l10n.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

Future<void> main() async {
  await dotenv.load();
  WidgetsFlutterBinding.ensureInitialized();
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => AppState()),
        ChangeNotifierProvider(create: (context) => VisibilityManager()),
        ChangeNotifierProvider(create: (context) => CourseManager()),
        Provider(create: (context) => DatabaseHelper()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final appState = Provider.of<AppState>(context);

    return MaterialApp(
      title: 'Compassion App',
      theme: ThemeData(
        primarySwatch: Colors.teal,
      ),
      locale: appState.locale,
      localizationsDelegates: [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: [
        const Locale('en', ''), // English
        const Locale('dk', ''), // Danish
      ],
      home: BaseLayout(),
    );
  }
}