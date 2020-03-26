import 'FilmDevelopmentStatusSummary.dart';

/// A FilmDevelopmentStatus represents a status update of a FilmDevelopmentOrder
class FilmDevelopmentStatus {
  DateTime statusDate;
  DateTime fetchTime;
  FilmDevelopmentStatusSummary statusSummary;
  double price;
  String statusSummaryText;

  // TODO: More fields required?
  FilmDevelopmentStatus(DateTime statusDate,
      FilmDevelopmentStatusSummary statusSummary, double price,
      String statusSummaryText) {
    this.statusDate = statusDate;
    this.statusSummary = statusSummary;
    this.price = price;
    this.statusSummaryText = statusSummaryText;
    fetchTime = DateTime.now();
  }

  ;

  String toString() {
    return "statusDate: $statusDate\nstatusSummary: $statusSummary\nprice: $price\nstatusSummaryText: $statusSummaryText";
  }


}
