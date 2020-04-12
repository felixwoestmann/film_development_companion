import 'package:filmdevelopmentcompanion/io/FilmOrderStatusProviders.dart';
import 'package:filmdevelopmentcompanion/model/FilmDevelopmentOrder.dart';
import 'package:filmdevelopmentcompanion/model/FilmDevelopmentStatus.dart';
import 'package:flutter/material.dart';

class StoreModel {
  FilmDevelopmentStatusProvider statusProvider;
  final String notImplementedWarning =
      "Not implemented should be used as an interface";

  String formatSummaryStateTextForUI(String summaryStateText) {
    return summaryStateText;
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

class DmDeStoreModel extends StoreModel {
  static const String PROVIDER_ID = "DM_DE_PROVIDER";
  static const String PROVIDER_NAME = "dm Deutschland";
  static const String PROVIDER_NAME_UI = "dm";
  static const AssetImage EXAMPLE_IMAGE = AssetImage('assets/dmExample.png');

  //
  static final DmDeStoreModel _instance = DmDeStoreModel._internal();

  static DmDeStoreModel get instance => _instance;

  DmDeStoreModel._internal() {
    statusProvider = new DmDeStatusProvider();
  }

  //
  @override
  String formatSummaryStateTextForUI(String summaryStateText) {
    return summaryStateText.split(".")[0];
  }

//
  @override
  String get providerId => PROVIDER_ID;

  @override
  AssetImage get exampleImage => EXAMPLE_IMAGE;

  @override
  String get providerName => PROVIDER_NAME;

  @override
  String get providerNameUi => PROVIDER_NAME_UI;
}

class RossmannStoreModel extends StoreModel {
  static const String PROVIDER_ID = "ROSSMANN_PROVIDER";
  static const String PROVIDER_NAME = "Rossmann";
  static const String PROVIDER_NAME_UI = "Rossmann";
  static const AssetImage EXAMPLE_IMAGE =
      AssetImage('assets/RossmannExample.png');

  //
  static final RossmannStoreModel _instance = RossmannStoreModel._internal();

  RossmannStoreModel._internal() {
    statusProvider = new RossmannStatusProvider();
  }

  static RossmannStoreModel get instance => _instance;

  //
  @override
  String get providerId => PROVIDER_ID;

  @override
  String get providerName => PROVIDER_NAME;

  @override
  String get providerNameUi => PROVIDER_NAME_UI;

  @override
  AssetImage get exampleImage => EXAMPLE_IMAGE;
}

class CeweStoreModel extends StoreModel {
  static const String PROVIDER_ID = "CEWE PROVIDER";
  static const String PROVIDER_NAME = "Cewe";
  static const String PROVIDER_NAME_UI = "Cewe";
  static const AssetImage EXAMPLE_IMAGE =
      AssetImage('assets/RossmannExample.png');

  //TODO change asset
  //
  static final CeweStoreModel _instance = CeweStoreModel._internal();

  CeweStoreModel._internal() {
    statusProvider = new CeweStatusProvider();
  }

  static CeweStoreModel get instance => _instance;

  //
  @override
  String get providerId => PROVIDER_ID;

  @override
  String get providerName => PROVIDER_NAME;

  @override
  String get providerNameUi => PROVIDER_NAME_UI;

  @override
  AssetImage get exampleImage => EXAMPLE_IMAGE;
}
