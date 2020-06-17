import 'package:filmdevelopmentcompanion/model/store_models/cewe_store_model.dart';
import 'package:filmdevelopmentcompanion/model/store_models/dm_de_store_model.dart';
import 'package:filmdevelopmentcompanion/model/store_models/rossmann_store_model.dart';
import 'package:filmdevelopmentcompanion/model/store_models/store_model.dart';
import 'package:filmdevelopmentcompanion/view/add_film_order/cewe_add_film_order_page_state.dart';
import 'package:filmdevelopmentcompanion/view/add_film_order/dm_de_add_film_order_page_state.dart';
import 'package:filmdevelopmentcompanion/view/add_film_order/rossmann_add_film_order_page_state.dart';
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
