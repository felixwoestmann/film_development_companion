import 'package:filmdevelopmentcompanion/view/FilmOrderOverviewPage.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

void main() => runApp(FilmDevCompanionApp());

class FilmDevCompanionApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        brightness: Brightness.dark,
        accentColor: Color.fromARGB(255, 255, 235, 59),
        primaryColor: Color.fromARGB(255, 0, 0, 1),
        textTheme: GoogleFonts.robotoTextTheme(
          Theme.of(context).textTheme,
        ).apply(bodyColor: Color.fromARGB(255, 255, 255, 255)),
      ),
      home: FilmOrderOverviewPage(title: 'Film Development Companion'),
    );
  }
}
