import 'file:///C:/Users/Felix/Documents/GitHub/film_development_companion/lib/io/statusprovider/FilmOrderStatusProvider.dart';
import 'package:filmdevelopmentcompanion/model/FilmDevelopmentOrder.dart';
import 'package:filmdevelopmentcompanion/model/FilmDevelopmentStatus.dart';
import 'package:filmdevelopmentcompanion/model/FilmDevelopmentStatusSummary.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class DmDeStatusProvider implements FilmDevelopmentStatusProvider {
  static const String API_ENDPOINT =
      "https://spot.photoprintit.com/spotapi/orderInfo/forShop";
  static const String SUMMARY_KEY = "summaryStateText";
  static const String SUMMARY_DATE_KEY = "summaryDate";
  static const String CONFIG = "1320";

  @override
  Future<FilmDevelopmentStatus> obtainDevelopmentStatusForFilmOrder(
      FilmDevelopmentOrder film) async {
    var orderNumber = film.orderId;
    var storeId = film.storeId;
    String queryURL =
        '$API_ENDPOINT?config=$CONFIG&shop=$storeId&order=$orderNumber';
    print(queryURL);
    http.Response httResponse = await http.get(queryURL);
    if (httResponse.statusCode == 200) {
      var jsonResponse = json.decode(httResponse.body);
      FilmDevelopmentStatusSummary statusSummary =
          getFilmDevelopmentStatusSummaryFromText(
              jsonResponse['summaryStateCode']);
      int price = jsonResponse['summaryPrice'];
      //print(jsonResponse);
      return FilmDevelopmentStatus(
          DateTime.parse(jsonResponse['resultDateTime']),
          statusSummary,
          price.toDouble() / 100,
          jsonResponse['summaryStateText']);
    } else {
      //TODO something bad happened
      print("The request failed.");
      return null;
    }
  }

  FilmDevelopmentStatusSummary getFilmDevelopmentStatusSummaryFromText(
      String text) {
    switch (text) {
      case "ERROR":
        return FilmDevelopmentStatusSummary.UNKNOWN_ERROR;
      case "PROCESSING":
        return FilmDevelopmentStatusSummary.PROCESSING;
      case "SHIPPED":
        return FilmDevelopmentStatusSummary.SHIPPING;
      case "DELIVERED":
        return FilmDevelopmentStatusSummary.DELIVERED;
      default:
        return FilmDevelopmentStatusSummary.UNKNOWN_ERROR;
    }
  }
}
