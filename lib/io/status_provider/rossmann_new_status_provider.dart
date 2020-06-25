import 'package:filmdevelopmentcompanion/io/status_provider/film_order_status_provider.dart';
import 'package:filmdevelopmentcompanion/model/film_development_order.dart';
import 'package:filmdevelopmentcompanion/model/film_development_status.dart';
import 'package:filmdevelopmentcompanion/model/film_development_status_summary.dart';
import 'package:jiffy/jiffy.dart';
import 'package:html/dom.dart';
import 'package:html/parser.dart' show parse;
import 'package:http/http.dart' as http;

///
/// MIT OHNE HT NUMMER
class RossmannNewStatusProvider implements FilmDevelopmentStatusProvider {
  static const String API_ENDPOINT =
      "https://shop.rossmann-fotowelt.de/tracking/orderdetails.jsp";

  //RegEx for Dates in format 01.04.2020 bzw. dd.MM.yyyy
  final RegExp dateRegExp =
      new RegExp(r"\d{2}\.\d{2}\.\d{2}", caseSensitive: false);

  //Defines mapping of contained Text to DevelopmentStatusSummary
  final Map<String, FilmDevelopmentStatusSummary> markerTextToStatusSummary = {
    "in unserem Labor eingegangen und wird derzeit bearbeitet.":
        FilmDevelopmentStatusSummary.PROCESSING,
    "Ihr Auftrag ist fertiggestellt(noch nicht geliefert)":
        FilmDevelopmentStatusSummary.SHIPPING,
    "Ihr Auftrag ist fertiggestellt und hat unser Labor am":
        FilmDevelopmentStatusSummary.SHIPPING,
  };

  @override
  Future<FilmDevelopmentStatus> obtainDevelopmentStatusForFilmOrder(
      FilmDevelopmentOrder film) async {
    //perform request
    http.Response httResponse = await http.post(API_ENDPOINT, body: {
      "bagId": film.orderId,
      "outletId": film.storeId,
    });
    //Evaluate state of Order
    List<Element> stateEvaluationList =
        parse(httResponse.body).querySelectorAll("table tr td");
    String stateEvaluation = stateEvaluationList.last.text
        .trim()
        .replaceAll("\n", " ")
        .replaceAll("\t", "");
    print("stateEval: " + stateEvaluation);
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
        //Initialise
        DateTime statusSummaryDate = DateTime.now();
        if (dateRegExp.hasMatch(stateEvaluation)) {
          statusSummaryDate = Jiffy(
                  dateRegExp.firstMatch(stateEvaluation).group(0), "dd.MM.yyyy")
              .dateTime;
        }

        return new FilmDevelopmentStatus(
            statusSummaryDate, statusSummary, 0.0, stateEvaluation);

      case FilmDevelopmentStatusSummary.DELIVERED:

        /// The Rossmann API using only the StoreId and not the HT-Number is not capable of telling us wether an order has arrived at the local store.
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
    return null;
  }
}
