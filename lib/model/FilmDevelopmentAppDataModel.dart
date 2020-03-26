import 'dart:async';
import 'dart:collection';
import 'package:flutter/foundation.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import 'DmDeStoreModel.dart';
import 'FilmDevelopmentOrder.dart';
import 'StoreModel.dart';

class FilmDevelopmentAppDataModel extends ChangeNotifier {
  List<FilmDevelopmentOrder> filmOrders = new List();

  FilmDevelopmentAppDataModel() {
    StoreModel dmDeStoreModel = new DmDeStoreModel();
    addFilmOrder(FilmDevelopmentOrder(dmDeStoreModel, "854440", "1618"));
   // addFilmOrder(FilmDevelopmentOrder(dmDeStoreModel, "854447", "1618"));
    addFilmOrder(FilmDevelopmentOrder(dmDeStoreModel, "567539", "1618"));
    updateAllOrders();
  }

  void addFilmOrder(FilmDevelopmentOrder order) {
    filmOrders.add(order);
    notifyListeners();
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
