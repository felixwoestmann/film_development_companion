import 'dart:async';
import 'dart:collection';

import 'package:filmdevelopmentcompanion/io/database_helpers.dart';
import 'package:filmdevelopmentcompanion/model/shared_preferences_helper.dart';
import 'package:filmdevelopmentcompanion/model/store_models/store_model.dart';
import 'package:flutter/foundation.dart';

import 'film_development_order.dart';

class FilmDevelopmentAppDataModel extends ChangeNotifier {
  List<FilmDevelopmentOrder> filmOrders = [];
  Map<String, String> homeStoresForStoreModel = {};
  DatabaseHelper dbHelper;
  bool showCompactView = false;

  FilmDevelopmentAppDataModel() {
    SharedPreferencesHelper()
        .loadCompactViewPreference()
        .then((v) => showCompactView = v)
        .whenComplete(() => notifyListeners());
    //Load HomeStores for all StoreModels
    for (StoreModel storeModel in StoreModel.getStoreModels()) {
      SharedPreferencesHelper()
          .loadHomeStoreForStoreModel(storeModel)
          .then((value) => homeStoresForStoreModel.putIfAbsent(storeModel.providerId, () => value))
          .whenComplete(() => notifyListeners());
    }
    dbHelper = DatabaseHelper.instance;
    initFilmDevelopmentAppDataModel();
  }

  void initFilmDevelopmentAppDataModel() async {
    filmOrders = await dbHelper.loadAllFilmDevelopmentOrders();
    notifyListeners();
    updateAllOrders();
  }

  /*Adds a film order and saves the storeId for the SotreModel to the SharedPreferences*/
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

  UnmodifiableListView<FilmDevelopmentOrder> get filmDevelopmentOrders => UnmodifiableListView(filmOrders);

  Future<void> updateAllOrders() async {
    List<Future> futures = <Future>[];
    for (var order in filmOrders) {
      futures.add(order.update().then((value) => dbHelper.update(order)));
    }
    await Future.wait(futures);
    notifyListeners();
  }

  void toggleCompactView() {
    if (showCompactView) {
      showCompactView = false;
    } else {
      showCompactView = true;
    }
    SharedPreferencesHelper().saveCompactViewPreference(showCompactView);
    notifyListeners();
  }

  String getHomeStoreForStoreModel(StoreModel storeModel) {
    if (homeStoresForStoreModel.containsKey(storeModel.providerId) &&
        !identical(homeStoresForStoreModel.containsKey(storeModel.providerId), "")) {
      return homeStoresForStoreModel[storeModel.providerId];
    }
    return "No home store is present"; //TODO i18
  }

  void saveHomeStoreForStoreModel(StoreModel storeModel, String newHomeStore) {
    homeStoresForStoreModel[storeModel.providerId] = newHomeStore;
    SharedPreferencesHelper().saveHomeStoreForStoreModel(storeModel, newHomeStore);
    notifyListeners();
  }
}
