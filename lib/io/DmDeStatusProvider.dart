import 'dart:convert';

import 'package:filmdevelopmentcompanion/model/FilmDevelopmentOrder.dart';
import 'package:filmdevelopmentcompanion/model/FilmDevelopmentStatus.dart';
import 'package:filmdevelopmentcompanion/model/FilmDevelopmentStatusSummary.dart';
import 'package:http/http.dart' as http;
import 'FilmDevelopmentStatusProvider.dart';

/// FilmDevelopmentStatusProvider for German Stores of the DM chain
/// It is implemented as a singleton to facilitate less Memory usage
/// API_ENDPOINT: The URL from which updates can be obtained
/// SUMMARY_KEY: the field in the returned JSON which contains the FilmDevelopmentStatusSummary
/// SUMMARY_DATE_KEY: the field in the returned JSON which contains the Date of the current update
class DmDeStatusProvider implements FilmDevelopmentStatusProvider {
  static const String API_ENDPOINT =
      "https://spot.photoprintit.com/spotapi/orderInfo/forShop";
  static const String SUMMARY_KEY = "summaryStateText";
  static const String SUMMARY_DATE_KEY = "summaryDate";
  static const String CONFIG = "1320";
  static final DmDeStatusProvider _instance = DmDeStatusProvider._internal();

  DmDeStatusProvider._internal();

  static DmDeStatusProvider get instance => _instance;

  @override
  Future<FilmDevelopmentStatus> obtainDevelopmentStatusForFilmOrder(
      FilmDevelopmentOrder film) async {
    var orderNumber = film.orderNumber;
    var storeId = film.storeId;
    String queryURL =
        '$API_ENDPOINT?config=$CONFIG&shop=$storeId&order=$orderNumber';
    http.Response httResponse = await http.get(queryURL);
    if (httResponse.statusCode == 200) {
      var jsonResponse = json.decode(httResponse.body);
      FilmDevelopmentStatusSummary statusSummary =
          FilmDevelopmentStatusSummary.UNKNOWN;
      int price = jsonResponse['summaryPrice'];
      print(jsonResponse);
      return FilmDevelopmentStatus(
          price: price.toDouble(),
          statusDate: DateTime.parse(jsonResponse['resultDateTime']),
          statusSummary: statusSummary,
          statusSummaryText: jsonResponse['summaryStateText']);
    } else {
      //TODO something bad happened
      print("The request failed.");
      return null;
    }
  }

  FilmDevelopmentStatusSummary getFilmDevelopmentStatusSummaryFromText(
      String text) {
    switch (text) {
      case "PROCESSING":
        {
          return FilmDevelopmentStatusSummary.PROCESSING;
        }
        break;

      case "DONE":
        {
          return FilmDevelopmentStatusSummary.DONE;
        }
        break;

      default:
        {
          return FilmDevelopmentStatusSummary.UNKNOWN;
        }
        break;
    }
  }
}
