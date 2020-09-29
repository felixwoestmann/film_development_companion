import 'package:filmdevelopmentcompanion/io/status_provider/rossmann_status_provider.dart';
import 'package:filmdevelopmentcompanion/model/store_models/store_model.dart';
import 'package:flutter/material.dart';

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
