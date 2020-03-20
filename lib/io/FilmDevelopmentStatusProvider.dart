import 'package:filmdevelopmentcompanion/model/FilmDevelopmentOrder.dart';
import 'package:filmdevelopmentcompanion/model/FilmDevelopmentStatus.dart';
/// The FilmDevelopmentStatusProvider defines the interface for obtaining status updates. Has to be implemented.
/// obtainDevelopmentStatusForFilmOrder: For a given FilmDevelopmentOrder the method returns a new status
class FilmDevelopmentStatusProvider {
  Future<FilmDevelopmentStatus>  obtainDevelopmentStatusForFilmOrder(FilmDevelopmentOrder film) async {
    print("This method has to be overidden by implementing classes.");
    return null;
  }
}