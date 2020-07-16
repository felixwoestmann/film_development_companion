import 'dart:async';

import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesHelper {
  static final String _compactView = "preferenceCompactView";

  static Future<bool> getCompactViewPreference() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    print(prefs.getBool(_compactView));
    return prefs.getBool(_compactView) ?? false;
  }

  static Future<bool> setCompactViewPreference(bool value) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.setBool(_compactView, value);
  }
}
