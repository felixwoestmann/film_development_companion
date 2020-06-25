import 'package:filmdevelopmentcompanion/io/status_provider/film_order_status_provider.dart';
import 'package:filmdevelopmentcompanion/model/film_development_order.dart';
import 'package:filmdevelopmentcompanion/model/film_development_status.dart';
import 'package:filmdevelopmentcompanion/model/film_development_status_summary.dart';
import 'package:jiffy/jiffy.dart';
import 'package:html/dom.dart';
import 'package:html/parser.dart' show parse;
import 'package:http/http.dart' as http;

/// The Rossmann NEW Status Provider handles Orders from Rossmann where no HT-Number is present and the StoreId is used to identify the order.
class RossmannNewStatusProvider implements FilmDevelopmentStatusProvider {
  static const String API_ENDPOINT =
      "https://shop.rossmann-fotowelt.de/tracking/orderdetails.jsp";
  //RegEx for Dates in format 01.04.2020 bzw. dd.MM.yyyy
  final RegExp dateRegExp =
      new RegExp(r"\d{2}\.\d{2}\.\d{2}", caseSensitive: false);

  //Defines mapping of Text from the API to a DevelopmentStatusSummary
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
    //Perform the API Request
    http.Response httResponse = await http.post(API_ENDPOINT, body: {
      "bagId": film.orderId,
      "outletId": film.storeId,
    });
    //Evaluate the StatusSummary of the order
    //Obtain the Status Line and lint it with removing TABS and LINEBREAKS
    List<Element> stateEvaluationList =
        parse(httResponse.body).querySelectorAll("table tr td");
    String statusLineFromApi = stateEvaluationList.last.text
        .trim()
        .replaceAll("\n", " ")
        .replaceAll("\t", "");
    //Use the linted StatusLine to decide the StatusSummary and base the further processing on that state
    FilmDevelopmentStatusSummary statusSummary =
        getFilmDevelopmentStatusSummaryFromText(statusLineFromApi);

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
        //Obtain the StatusSummaryDate from the Status Line
        DateTime statusSummaryDate = DateTime.now();
        if (dateRegExp.hasMatch(statusLineFromApi)) {
          statusSummaryDate = Jiffy(
                  dateRegExp.firstMatch(statusLineFromApi).group(0), "dd.MM.yyyy")
              .dateTime;
        }

        return new FilmDevelopmentStatus(
            statusSummaryDate, statusSummary, 0.0, statusLineFromApi);

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
