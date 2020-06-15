import 'package:filmdevelopmentcompanion/Localizations.dart';
import 'package:filmdevelopmentcompanion/model/FilmDevelopmentAppDataModel.dart';
import 'package:filmdevelopmentcompanion/model/store_models/CeweStoreModel.dart';
import 'package:filmdevelopmentcompanion/model/store_models/DmDeStoreModel.dart';
import 'package:filmdevelopmentcompanion/model/store_models/RossmannStoreModel.dart';
import 'package:filmdevelopmentcompanion/model/store_models/StoreModel.dart';
import 'package:filmdevelopmentcompanion/view/add_film_order/CeweAddFilmOrderPageState.dart';
import 'package:filmdevelopmentcompanion/view/add_film_order/DmDeAddFilmOrderPageState.dart';
import 'package:filmdevelopmentcompanion/view/add_film_order/RossmannAddFilmOrderPageState.dart';
import 'package:flutter/material.dart';


class AddFilmOrderPage extends StatefulWidget {
  final StoreModel storeModel;

  AddFilmOrderPage(this.storeModel);

  @override
  State createState() {
    switch (storeModel.providerId) {
      case RossmannStoreModel.PROVIDER_ID:
        return RossmannAddFilmOrderPageState();
      case DmDeStoreModel.PROVIDER_ID:
        return DmDeAddFilmOrderPageState();
      case CeweStoreModel.PROVIDER_ID:
        return CeweAddFilmOrderPageState();
    }
    return null;
  }
}
