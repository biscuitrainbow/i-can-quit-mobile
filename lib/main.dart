import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:i_can_quit/constant/color-palette.dart';
import 'package:i_can_quit/ui/screen/smoking_entry_form.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

void main() async {
  await DotEnv().load('.env');
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primaryColor: ColorPalette.primary,
        accentColor: ColorPalette.primary,
        fontFamily: 'Kanit',
        textTheme: Theme.of(context).textTheme.copyWith(
              title: TextStyle(fontSize: 20.0, fontWeight: FontWeight.w500),
            ),
      ),
      localizationsDelegates: [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        DefaultCupertinoLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      locale: Locale('th', 'TH'), // Current locale
      supportedLocales: [
        const Locale('en', 'US'), // English
        const Locale('th', 'TH'), // Thai
      ],
      home: SmokingEntryFormScreen(),
    );
  }
}
