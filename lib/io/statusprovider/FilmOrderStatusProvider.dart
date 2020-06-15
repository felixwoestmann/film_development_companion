import 'package:filmdevelopmentcompanion/model/FilmDevelopmentOrder.dart';
import 'package:filmdevelopmentcompanion/model/FilmDevelopmentStatus.dart';

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



