import 'package:filmdevelopmentcompanion/model/FilmDevelopmentOrder.dart';
import 'package:filmdevelopmentcompanion/model/FilmDevelopmentStatus.dart';
import 'package:filmdevelopmentcompanion/model/FilmDevelopmentStatusSummary.dart';
import 'package:html/dom.dart';
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
  final RegExp priceRegExp = new RegExp(r"\d+\,\d{1,2}", caseSensitive: false);

  //Defines mapping of contained Text to DevelopmentStatusSummary
  final Map<String, FilmDevelopmentStatusSummary> markerTextToStatusSummary = {
    "Ihr Auftrag ist fertiggestellt(noch nicht geliefert)":
        FilmDevelopmentStatusSummary.SHIPPING,
    "Ihr Auftrag ist fertiggestellt und hat unser Labor am":
        FilmDevelopmentStatusSummary.SHIPPING,
    "in unserem Labor eingegangen und wird derzeit bearbeitet.":
        FilmDevelopmentStatusSummary.PROCESSING
  };

  @override
  Future<FilmDevelopmentStatus> obtainDevelopmentStatusForFilmOrder(
      FilmDevelopmentOrder film) async {
    //Format Data for a request to the Rossmann API
    String orderNumber = film.orderId;
    List<String> splittedStoreId = film.storeId.split("-");
    String firma = splittedStoreId[0];
    String htNumber = splittedStoreId[1];
    //perform request
    http.Response httResponse = await http.post(API_ENDPOINT, body: {
      "AUFNR_A": orderNumber,
      "FIRMA": firma,
      "HDNR": htNumber,
      "x": "0",
      "y": "0"
    });
    //Evaluate state of Order
    String stateEvaluation =
        parse(httResponse.body).querySelector("tr td div").text.trim();
    //Obtain StatusSummary to decide which path to follow
    FilmDevelopmentStatusSummary statusSummary =
        getFilmDevelopmentStatusSummaryFromText(stateEvaluation);

    switch (statusSummary) {
      case FilmDevelopmentStatusSummary.UNKNOWN_ERROR:
        String errorCaseData =
            parse(httResponse.body).querySelector("tr td div").text.trim();
        return new FilmDevelopmentStatus(
            DateTime.now(), statusSummary, 0.0, errorCaseData);

      case FilmDevelopmentStatusSummary.PROCESSING:
        String processingCaseData =
            parse(httResponse.body).querySelector("tr td div").text.trim();
        DateTime statusSummaryDate = Jiffy(
                dateRegExp.firstMatch(processingCaseData).group(0),
                "dd.MM.yyyy")
            .dateTime;
        return new FilmDevelopmentStatus(
            statusSummaryDate, statusSummary, 0.0, processingCaseData);

      case FilmDevelopmentStatusSummary.SHIPPING:
        //init
        double price = 0.0;
        DateTime statusSummaryDate = DateTime.now();
        //obtain ShippingStatusLine and lint it
        String shippingCaseStatusLine =
            parse(httResponse.body).querySelector("tr td div").text.trim();
        shippingCaseStatusLine = shippingCaseStatusLine.replaceAll("\n", "");
        //obtainPrice
        if (priceRegExp.hasMatch(shippingCaseStatusLine)) {
          String priceAsString =
              priceRegExp.firstMatch(shippingCaseStatusLine).group(0);
          //parse Method expects 1.44 not 1,44
          price = double.parse(priceAsString.replaceAll(",", "."));
        }
        //obtain Data in Table to get statusSummaryDate
        List<Element> shippingTable =
            parse(httResponse.body).querySelectorAll("tr td");
        //Traverse Table until our RegEx matches
        for (Element el in shippingTable) {
          String contentOfTableRow = el.text.trim();
          if (dateRegExp.hasMatch(contentOfTableRow)) {
            statusSummaryDate = Jiffy(
                    dateRegExp.firstMatch(contentOfTableRow).group(0),
                    "dd.MM.yyyy")
                .dateTime;
          }
        }
        return new FilmDevelopmentStatus(
            statusSummaryDate, statusSummary, price, shippingCaseStatusLine);

      case FilmDevelopmentStatusSummary.DELIVERED:
        // TODO: Handle this case.
        break;
    }
    return null;
  }

  FilmDevelopmentStatusSummary getFilmDevelopmentStatusSummaryFromText(
      String text) {
    for (String markerText in markerTextToStatusSummary.keys) {
      if (text.contains(markerText)) {
        return markerTextToStatusSummary[markerText];
      }
    }
  }
}

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


class CeweStatusProvider implements FilmDevelopmentStatusProvider {
  static const String API_ENDPOINT =
      "https://spot.photoprintit.com/spotapi/orderInfo/forShop";
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
