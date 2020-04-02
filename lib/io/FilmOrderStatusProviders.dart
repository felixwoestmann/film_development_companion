import 'package:filmdevelopmentcompanion/model/FilmDevelopmentOrder.dart';
import 'package:filmdevelopmentcompanion/model/FilmDevelopmentStatus.dart';
import 'package:filmdevelopmentcompanion/model/FilmDevelopmentStatusSummary.dart';
import 'package:html/parser.dart' show parse;
import 'package:http/http.dart' as http;
import 'package:jiffy/jiffy.dart';
import 'dart:convert';

/// FilmDevelopmentStatusProvider for German Stores of the DM chain
/// It is implemented as a singleton to facilitate less Memory usage
/// API_ENDPOINT: The URL from which updates can be obtained
/// SUMMARY_KEY: the field in the returned JSON which contains the FilmDevelopmentStatusSummary
/// SUMMARY_DATE_KEY: the field in the returned JSON which contains the Date of the current update

/// The FilmDevelopmentStatusProvider defines the interface for obtaining status updates. Has to be implemented.
/// obtainDevelopmentStatusForFilmOrder: For a given FilmDevelopmentOrder the method returns a new status

class FilmDevelopmentStatusProvider {
  Future<FilmDevelopmentStatus> obtainDevelopmentStatusForFilmOrder(
      FilmDevelopmentOrder film) async {
    print("This method has to be overidden by implementing classes.");
    return null;
  }
}

class RossmannStatusProvider implements FilmDevelopmentStatusProvider {
  static const String API_ENDPOINT =
      "https://service.fujifilm-imaging.eu/a/rossmannb2";

  //RegEx for Dates in format 01.04.2020 bzw. dd.MM.yyyy
  final RegExp dateRegExp =
      new RegExp(r"\d{2}\.\d{2}\.\d{4}", caseSensitive: false);
  static final RossmannStatusProvider _instance =
      RossmannStatusProvider._internal();

  RossmannStatusProvider._internal();

  static RossmannStatusProvider get instance => _instance;

  @override
  Future<FilmDevelopmentStatus> obtainDevelopmentStatusForFilmOrder(
      FilmDevelopmentOrder film) async {
    String orderNumber = film.orderId;
    List<String> splittedStoreId = film.storeId.split("-");
    String firma = splittedStoreId[0];
    String htNumber = splittedStoreId[1];
    http.Response httResponse = await http.post(API_ENDPOINT, body: {
      "AUFNR_A": orderNumber,
      "FIRMA": firma,
      "HDNR": htNumber,
      "x": "0",
      "y": "0"
    });
    String workingData =
        parse(httResponse.body).querySelector("tr td div").text.trim();
    //Use default Summary in case of error
    FilmDevelopmentStatusSummary statusSummary =
        FilmDevelopmentStatusSummary.UNKNOWN_ERROR;
    //Expression to check for PROCESSING state
    //then try to lint the statusSummaryDate out of the String
    if (workingData.contains(
        "in unserem Labor eingegangen und wird derzeit bearbeitet.")) {
      statusSummary = FilmDevelopmentStatusSummary.PROCESSING;
      DateTime statusSummaryDate =
          Jiffy(dateRegExp.firstMatch(workingData).group(0), "dd.MM.yyyy")
              .dateTime;
      return new FilmDevelopmentStatus(
          statusSummaryDate, statusSummary, 0.0, workingData);
    }
    return null;
  }
}

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
    var orderNumber = film.orderId;
    var storeId = film.storeId;
    String queryURL =
        '$API_ENDPOINT?config=$CONFIG&shop=$storeId&order=$orderNumber';
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
