import 'package:filmdevelopmentcompanion/io/status_provider/cewe_status_provider.dart';
import 'package:filmdevelopmentcompanion/model/store_models/store_model.dart';
import 'package:flutter/material.dart';

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
