import 'package:filmdevelopmentcompanion/io/status_provider/film_order_status_provider.dart';
import 'package:filmdevelopmentcompanion/model/film_development_order.dart';
import 'package:filmdevelopmentcompanion/model/film_development_status.dart';
import 'package:filmdevelopmentcompanion/model/store_models/cewe_store_model.dart';
import 'package:filmdevelopmentcompanion/model/store_models/dm_de_store_model.dart';
import 'package:filmdevelopmentcompanion/model/store_models/mueller_store_model.dart';
import 'package:filmdevelopmentcompanion/model/store_models/rossmann_store_model.dart';
import 'package:flutter/material.dart';

class StoreModel {
  FilmDevelopmentStatusProvider statusProvider;
  final String notImplementedWarning =
      "Not implemented should be used as an interface";

  String formatSummaryStateTextForUI(String summaryStateText) {
    //Replace more than two Whitespaces with one
    return summaryStateText.replaceAll(new RegExp(r"\s{2,}"), " ");
  }

  Future<FilmDevelopmentStatus> update(FilmDevelopmentOrder order) async {
    return await statusProvider.obtainDevelopmentStatusForFilmOrder(order);
  }

  String get providerId {
    print(notImplementedWarning);
    return null;
  }

  String get providerName {
    print(notImplementedWarning);
    return null;
  }

  String get providerNameUi {
    print(notImplementedWarning);
    return null;
  }

  AssetImage get exampleImage {
    print(notImplementedWarning);
    return null;
  }

  static StoreModel storeModelFromId(String id) {
    switch (id) {
      case DmDeStoreModel.PROVIDER_ID:
        return DmDeStoreModel.instance;
      case RossmannStoreModel.PROVIDER_ID:
        return RossmannStoreModel.instance;
      case CeweStoreModel.PROVIDER_ID:
        return CeweStoreModel.instance;
      case MuellerStoreModel.PROVIDER_ID:
        return MuellerStoreModel.instance;
    }
    return null;
  }

  static List<StoreModel> getStoreModels() {
    List<StoreModel> storeModelstorePageMap = [
      DmDeStoreModel.instance,
      RossmannStoreModel.instance,
      CeweStoreModel.instance,
      MuellerStoreModel.instance
    ];
    return storeModelstorePageMap;
  }
}
