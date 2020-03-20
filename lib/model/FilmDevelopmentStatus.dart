
import 'FilmDevelopmentStatusSummary.dart';

/// A FilmDevelopmentStatus represents a status update of a FilmDevelopmentOrder
/// time
class FilmDevelopmentStatus {
  DateTime statusDate;
  DateTime fetchTime;
  FilmDevelopmentStatusSummary statusSummary;
  double price;

  // TODO: More fields required?
  FilmDevelopmentStatus(
      {this.statusDate,  this.statusSummary, this.price});


}
