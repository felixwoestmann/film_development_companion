import 'package:filmdevelopmentcompanion/io/status_provider/mueller_status_provider.dart';
import 'package:filmdevelopmentcompanion/model/store_models/store_model.dart';
import 'package:flutter/material.dart';

class MuellerStoreModel extends StoreModel {
  static const String PROVIDER_ID = "MUELLER PROVIDER";
  static const String PROVIDER_NAME = "Müller";
  static const String PROVIDER_NAME_UI = "Mueller";
  static const AssetImage EXAMPLE_IMAGE =
      AssetImage('assets/RossmannExample.png'); //TODO change asset

  static final MuellerStoreModel _instance = MuellerStoreModel._internal();

  MuellerStoreModel._internal() {
    statusProvider = new MuellerStatusProvider();
  }

  static MuellerStoreModel get instance => _instance;

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
