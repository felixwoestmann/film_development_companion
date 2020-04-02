import 'package:filmdevelopmentcompanion/io/FilmDevelopmentStatusProvider.dart';
import 'package:filmdevelopmentcompanion/model/FilmDevelopmentOrder.dart';
import 'package:filmdevelopmentcompanion/model/FilmDevelopmentStatus.dart';
import 'package:filmdevelopmentcompanion/model/FilmDevelopmentStatusSummary.dart';
import 'package:html/parser.dart' show parse;
import 'package:http/http.dart' as http;
import 'package:jiffy/jiffy.dart';

class RossmannStatusProvider extends FilmDevelopmentStatusProvider {
  static const  String API_ENDPOINT =
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
    String orderNumber = film.orderNumber;
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
