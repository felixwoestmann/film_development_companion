import 'package:filmdevelopmentcompanion/io/RossmannStatusProvider.dart';
import 'package:filmdevelopmentcompanion/model/FilmDevelopmentOrder.dart';
import 'package:filmdevelopmentcompanion/model/StoreModels.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test("Test the queriying of the Rossmann Stores for PLZ", () async {
    RossmannStatusProvider statusProvider = RossmannStatusProvider.instance;
    await statusProvider.obtainDevelopmentStatusForFilmOrder(new FilmDevelopmentOrder(new RossmannStoreModel(), "1234", "03-5678"));
  });
}
