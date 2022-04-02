import 'dart:async';

import 'package:shared_preferences/shared_preferences.dart';

//The class SharedPreferencesHelper saves and loads values from the SharedPreferences of the used device
class SharedPreferencesHelper {
  static final SharedPreferencesHelper _singletoninstance = SharedPreferencesHelper._internal();

  factory SharedPreferencesHelper() {
    return _singletoninstance;
  }

  SharedPreferencesHelper._internal();

  // ComapctView saves the boolean value to indicate if the user wants a compact representation of all his film orders
  final String _compactView = "preferenceCompactView";

  Future<bool> loadCompactViewPreference() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getBool(_compactView) ?? false;
  }

  Future<bool> saveCompactViewPreference(bool value) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.setBool(_compactView, value);
  }
}
