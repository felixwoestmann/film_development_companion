import 'package:filmdevelopmentcompanion/view/FilmOrderOverviewPage.dart';
import 'package:flutter/material.dart';

void main() => runApp(FilmDevCompanionApp());

class FilmDevCompanionApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.yellow,
      ),
      home: FilmOrderOverviewPage(title: 'Film Development Companion'),
    );
  }
}


