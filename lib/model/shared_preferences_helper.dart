import 'dart:async';
import 'package:filmdevelopmentcompanion/model/store_models/cewe_store_model.dart';
import 'package:filmdevelopmentcompanion/model/store_models/dm_de_store_model.dart';
import 'package:filmdevelopmentcompanion/model/store_models/rossmann_old_store_model.dart';
import 'package:filmdevelopmentcompanion/model/store_models/store_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

//The class SharedPreferencesHelper saves and loads values from the SharedPreferences of the used device
class SharedPreferencesHelper {
  Map<String, List<String>> _mapOfrecentStoresForStoreModel;

  static final SharedPreferencesHelper _singletoninstance =
      SharedPreferencesHelper._internal();

  factory SharedPreferencesHelper() {
    return _singletoninstance;
  }

  SharedPreferencesHelper._internal() {
    //Init recentStoresForModelMap
    //Because Reflection isn't enabled in Flutter i am going to explicitly state every StoreModel

    List<StoreModel> listOfStoreModels = new List();
    listOfStoreModels.add(DmDeStoreModel.instance);
    listOfStoreModels.add(RossmannOldStoreModel.instance);
    listOfStoreModels.add(CeweStoreModel.instance);
    //Load the recently used Stores for every StoreModel
    for (StoreModel storeModel in listOfStoreModels) {
      _loadRecentStoresForStoreModel(storeModel).then((value) =>
          _mapOfrecentStoresForStoreModel.putIfAbsent(
              storeModel.providerId, () => value));
    }
  }

  List<String> getRecentStoresForStoreModel(StoreModel storeModel) {
    return _mapOfrecentStoresForStoreModel[storeModel.providerId];
  }

  void updateRecentStoresForStoreModel(
      StoreModel storeModel, String recentlyUsedStore) {
    _mapOfrecentStoresForStoreModel[storeModel.providerId].removeAt(0);
    _mapOfrecentStoresForStoreModel[storeModel.providerId]
        .add(recentlyUsedStore);
    saveRecentStoresForStoreModel(
        _mapOfrecentStoresForStoreModel[storeModel.providerId], storeModel);
  }

  // ComapctView saves the boolean value to indicate if the user wants a compact representation of all his film orders
  static final String _compactView = "preferenceCompactView";

  static Future<bool> loadCompactViewPreference() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    print(prefs.getBool(_compactView));
    return prefs.getBool(_compactView) ?? false;
  }

//TODO REMOCE STATIC
  static Future<bool> saveCompactViewPreference(bool value) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.setBool(_compactView, value);
  }

  Future<bool> saveRecentStoresForStoreModel(
      List<String> recentStores, StoreModel storeModel) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return await prefs.setStringList(storeModel.providerId, recentStores);
  }

  Future<List<String>> _loadRecentStoresForStoreModel(
      StoreModel storeModel) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getStringList(storeModel.providerId);
  }
}
