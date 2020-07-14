import 'dart:async';
import 'dart:collection';
import 'package:filmdevelopmentcompanion/io/database_helpers.dart';
import 'package:flutter/foundation.dart';
import 'film_development_order.dart';

class FilmDevelopmentAppDataModel extends ChangeNotifier {
  List<FilmDevelopmentOrder> filmOrders = new List();
  DatabaseHelper dbHelper;
  bool showCompactView=false;

  FilmDevelopmentAppDataModel() {
    //TODO dateformatting depends on country
    //initializeDateFormatting("de_DE", null);
    dbHelper = DatabaseHelper.instance;
    initFilmDevelopmentAppDataModel();
  }

  void initFilmDevelopmentAppDataModel() async {
    filmOrders = await dbHelper.loadAllFilmDevelopmentOrders();
    notifyListeners();
    updateAllOrders();
  }

  void addFilmOrder(FilmDevelopmentOrder order) async {
    await order.update();
    order.id = await dbHelper.insert(order);
    filmOrders.insert(0, order);
    notifyListeners();
  }

  void deleteFilmOrder(int index) async {
    await dbHelper.delete(filmOrders[index]);
    filmOrders.removeAt(index);
    notifyListeners();
  }

  UnmodifiableListView<FilmDevelopmentOrder> get filmDevelopmentOrders =>
      UnmodifiableListView(filmOrders);

  Future<void> updateAllOrders() async {
    List<Future> futures = <Future>[];
    for (var order in filmOrders) {
      futures.add(order.update().then((value) => dbHelper.update(order)));
    }
    await Future.wait(futures);
    notifyListeners();
  }

  void toggleCompacView() {
    if (showCompactView) {
      showCompactView = false;
    } else {
      showCompactView = true;
    }
    print("Val state is $showCompactView"); //TODO
    notifyListeners();
  }
}
