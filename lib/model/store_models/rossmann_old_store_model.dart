import 'package:filmdevelopmentcompanion/io/status_provider/rossmann_old_status_provider.dart';
import 'package:filmdevelopmentcompanion/model/store_models/store_model.dart';
import 'package:flutter/material.dart';

class RossmannOldStoreModel extends StoreModel {
  static const String PROVIDER_ID = "ROSSMANN_PROVIDER_OLD";
  static const String PROVIDER_NAME = "Rossmann Alt";
  static const String PROVIDER_NAME_UI = "Rossmann Alt";
  static const AssetImage EXAMPLE_IMAGE =
      AssetImage('assets/RossmannExample.png');

  //
  static final RossmannOldStoreModel _instance = RossmannOldStoreModel._internal();

  RossmannOldStoreModel._internal() {
    statusProvider = new RossmannOldStatusProvider();
  }

  static RossmannOldStoreModel get instance => _instance;

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
