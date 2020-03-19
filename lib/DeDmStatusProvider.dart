import 'package:filmdevelopmentcompanion/FilmDevelopmentOrder.dart';
import 'package:filmdevelopmentcompanion/FilmDevelopmentStatus.dart';
import 'package:filmdevelopmentcompanion/FilmDevelopmentStatusProviderInterface.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

/// FilmDevelopmentStatusProvider for German Stores of the DM chain
/// API_ENDPOINT: The URL from which updates can be obtained
/// SUMMARY_KEY: the field in the returned JSON which contains the FilmDevelopmentStatusSummary
/// SUMMARY_DATE_KEY: the field in the returned JSON which contains the Date of the current update
class DeDmStatusProvider implements FilmDevelopmentStatusProviderInterface {
  static const String API_ENDPOINT =
      "https://spot.photoprintit.com/spotapi/orderInfo/forShop";
  static const String SUMMARY_KEY = "summaryStateText";
  static const String SUMMARY_DATE_KEY = "summaryDate";
  static const String CONFIG = "1320";

  @override
  Future<FilmDevelopmentStatus> obtainDevelopmentStatusForFilmOrder(
      FilmDevelopmentOrder film) {
    var orderNumber = film.orderNumber;
    var storeId = film.storeId;
    String queryURL =
        '$API_ENDPOINT?config=$CONFIG&shop=$storeId&order=$orderNumber';
    Future<http.Response> jsonResponse = http.get(queryURL);
    jsonResponse.
    FilmDevelopmentStatus statusFromResponse=new FilmDevelopmentStatus(json)


    return null;
  }
}
