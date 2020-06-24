import 'package:filmdevelopmentcompanion/io/status_provider/rossmann_new_status_provider.dart';
import 'package:filmdevelopmentcompanion/io/status_provider/rossmann_old_status_provider.dart';
import 'package:filmdevelopmentcompanion/model/store_models/store_model.dart';
import 'package:flutter/material.dart';

class RossmannNewStoreModel extends StoreModel {
  static const String PROVIDER_ID = "ROSSMANN_PROVIDER_NEW";
  static const String PROVIDER_NAME = "Rossmann Neu";
  static const String PROVIDER_NAME_UI = "Rossmann Neu";
  static const AssetImage EXAMPLE_IMAGE =
      AssetImage('assets/RossmannExample.png');

  //
  static final RossmannNewStoreModel _instance = RossmannNewStoreModel._internal();

  RossmannNewStoreModel._internal() {
    statusProvider = new RossmannNewStatusProvider();
  }

  static RossmannNewStoreModel get instance => _instance;

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
