import 'dart:async';
import 'dart:collection';
import 'package:filmdevelopmentcompanion/io/DatabaseHelpers.dart';
import 'package:flutter/foundation.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'FilmDevelopmentOrder.dart';

class FilmDevelopmentAppDataModel extends ChangeNotifier {
  List<FilmDevelopmentOrder> filmOrders=new List();
  DatabaseHelper dbHelper;

  FilmDevelopmentAppDataModel() {
    initializeDateFormatting("de_DE", null);
    dbHelper = DatabaseHelper.instance;
    //StoreModel dmDeStoreModel = new DmDeStoreModel();
    // addFilmOrder(FilmDevelopmentOrder(dmDeStoreModel, "854440", "1618"));
    // addFilmOrder(FilmDevelopmentOrder(dmDeStoreModel, "854447", "1618"));
    //addFilmOrder(FilmDevelopmentOrder(dmDeStoreModel, "567539", "1618"));
    initFilmDevelopmentAppDataModel();
  }

  void initFilmDevelopmentAppDataModel() async {
    filmOrders = await dbHelper.loadAllFilmDevelopmentOrders();
    notifyListeners();
    updateAllOrders();
  }

  void addFilmOrder(FilmDevelopmentOrder order) async {
    filmOrders.insert(0, order);
    await order.update();
    notifyListeners();
    dbHelper.insert(order);
  }

  UnmodifiableListView<FilmDevelopmentOrder> get filmDevelopmentOrders =>
      UnmodifiableListView(filmOrders);

  Future<void> updateAllOrders() async {
    List<Future> futures = <Future>[];
    for (var order in filmOrders) {
      futures.add(order.update());
    }
    await Future.wait(futures);
    notifyListeners();
  }
}
