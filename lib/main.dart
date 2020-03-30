import 'package:filmdevelopmentcompanion/model/FilmDevelopmentAppDataModel.dart';
import 'package:filmdevelopmentcompanion/view/ChooseStoreTypePage.dart';
import 'package:filmdevelopmentcompanion/view/DmDeAddFilmOrderPage.dart';
import 'package:filmdevelopmentcompanion/view/FilmOrderOverviewPage.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(ChangeNotifierProvider(
    create: (context) => FilmDevelopmentAppDataModel(),
    child: FilmDevCompanionApp(),
  ));
}

class FilmDevCompanionApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Film Development Companion App',
        theme: ThemeData(
          brightness: Brightness.light,
          primaryColor: Color.fromARGB(255, 40, 40, 40),
          accentColor: Colors.deepOrangeAccent,
          textTheme: GoogleFonts.nunitoSansTextTheme(
            Theme.of(context).textTheme,
          ),
        ),
        initialRoute: '/',
        routes: {
          '/': (context) => FilmOrderOverviewPage(),
          'chooseStore': (context) => ChooseStoreTypePage(),
          '/dmDeAddFilm': (context) => DmDeAddFilmOrderPage(),
        });
  }
}
