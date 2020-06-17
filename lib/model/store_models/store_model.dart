import 'package:filmdevelopmentcompanion/io/status_provider/film_order_status_provider.dart';
import 'package:filmdevelopmentcompanion/model/film_development_order.dart';
import 'package:filmdevelopmentcompanion/model/film_development_status.dart';
import 'package:filmdevelopmentcompanion/model/store_models/cewe_store_model.dart';
import 'package:filmdevelopmentcompanion/model/store_models/dm_de_store_model.dart';
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

  String formatStoreOrderIdForUI(String orderId, String storeId) {
    return "$orderId // $storeId";
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
    }
    return null;
  }
}
