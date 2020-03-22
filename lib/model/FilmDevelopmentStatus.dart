import 'FilmDevelopmentStatusSummary.dart';

/// A FilmDevelopmentStatus represents a status update of a FilmDevelopmentOrder
class FilmDevelopmentStatus {
  DateTime statusDate;
  DateTime fetchTime;
  FilmDevelopmentStatusSummary statusSummary;
  double price;

  // TODO: More fields required?
  FilmDevelopmentStatus({this.statusDate, this.statusSummary, this.price});

  String toString() {
    return "statusDate: $statusDate\nstatusSummary: $statusSummary\nprice: $price";
  }
}
