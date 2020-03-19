import 'package:filmdevelopmentcompanion/FilmDevelopmentOrder.dart';
import 'package:filmdevelopmentcompanion/FilmDevelopmentStatus.dart';
/// The FilmDevelopmentStatusProviderInterface defines the interface for obtaining status updates. Has to be implemented.
/// obtainDevelopmentStatusForFilmOrder: For a given FilmDevelopmentOrder the method returns a new status
class FilmDevelopmentStatusProviderInterface {
  Future<FilmDevelopmentStatus>  obtainDevelopmentStatusForFilmOrder(FilmDevelopmentOrder film) async {
    print("This method has to be overidden by implementing classes.");
    return null;
  }
}