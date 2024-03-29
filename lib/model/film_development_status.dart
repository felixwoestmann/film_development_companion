import 'package:filmdevelopmentcompanion/io/database_helpers.dart';

/// A FilmDevelopmentStatus represents a status update of a FilmDevelopmentOrder
class FilmDevelopmentStatus {
  DateTime statusDate;
  DateTime fetchTime;
  FilmDevelopmentStatusSummary statusSummary;
  double price;
  String statusSummaryText;

  FilmDevelopmentStatus(
      DateTime statusDate, FilmDevelopmentStatusSummary statusSummary, double price, String statusSummaryText) {
    this.statusDate = statusDate;
    this.statusSummary = statusSummary;
    this.price = price;
    this.statusSummaryText = statusSummaryText;
    fetchTime = DateTime.now();
  }

  FilmDevelopmentStatus.fromMap(Map<String, dynamic> map) {
    statusDate = DateTime.fromMillisecondsSinceEpoch(map[DatabaseHelper.columnStatusStatusDate]);
    price = map[DatabaseHelper.columnStatusPrice];
    statusSummaryText = map[DatabaseHelper.columnStatusStatusSummaryText];
    fetchTime = DateTime.fromMillisecondsSinceEpoch(map[DatabaseHelper.columnStatusFetchTime]);
    statusSummary = FilmDevelopmentStatusSummary.values[map[DatabaseHelper.columnStatusStatusSummary]];
  }

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      DatabaseHelper.columnStatusStatusSummary: statusSummary.index,
      DatabaseHelper.columnStatusStatusSummaryText: statusSummaryText,
      DatabaseHelper.columnStatusPrice: price,
      DatabaseHelper.columnStatusFetchTime: fetchTime.millisecondsSinceEpoch,
      DatabaseHelper.columnStatusStatusDate: statusDate.millisecondsSinceEpoch,
    };

    return map;
  }

  String toString() {
    return "statusDate: $statusDate\nstatusSummary: $statusSummary\nprice: $price\nstatusSummaryText: $statusSummaryText";
  }
}

/// Enumeration to describe the actual STATE of the order
/// UNKNOWN: Status is UNKNOWN
/// PROCESSING: Order shows up in the FilmLab Backend
/// Done: Order is processed and will be shipped
enum FilmDevelopmentStatusSummary { UNKNOWN_ERROR, PROCESSING, SHIPPING, DELIVERED }
