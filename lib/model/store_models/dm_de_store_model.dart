import 'package:filmdevelopmentcompanion/io/status_provider/dm_de_status_provider.dart';
import 'package:filmdevelopmentcompanion/model/store_models/store_model.dart';
import 'package:flutter/material.dart';

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
