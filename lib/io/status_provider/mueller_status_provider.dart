import 'package:filmdevelopmentcompanion/io/status_provider/film_order_status_provider.dart';
import 'package:filmdevelopmentcompanion/model/film_development_order.dart';
import 'package:filmdevelopmentcompanion/model/film_development_status.dart';
import 'package:filmdevelopmentcompanion/model/film_development_status_summary.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class MuellerStatusProvider implements FilmDevelopmentStatusProvider {
  static const String API_ENDPOINT =
      "https://spot.photoprintit.com/spotapi/orderInfo/order";
  static const String SUMMARY_KEY = "summaryStateText";
  static const String SUMMARY_DATE_KEY = "summaryDate";
  static const String CONFIG = "ceweAll";

  @override
  Future<FilmDevelopmentStatus> obtainDevelopmentStatusForFilmOrder(
      FilmDevelopmentOrder film) async {
    var orderNumber = film.orderId;
    var storeId = film.storeId;
    String queryURL =
        '$API_ENDPOINT?config=$CONFIG&fullOrderId=$storeId-$orderNumber';
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
