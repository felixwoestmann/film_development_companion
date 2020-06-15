import 'package:filmdevelopmentcompanion/io/status_provider/FilmOrderStatusProvider.dart';
import 'package:filmdevelopmentcompanion/model/FilmDevelopmentOrder.dart';
import 'package:filmdevelopmentcompanion/model/FilmDevelopmentStatus.dart';
import 'package:filmdevelopmentcompanion/model/FilmDevelopmentStatusSummary.dart';
import 'package:jiffy/jiffy.dart';
import 'package:html/dom.dart';
import 'package:html/parser.dart' show parse;
import 'package:http/http.dart' as http;

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
    return null;
  }
}
