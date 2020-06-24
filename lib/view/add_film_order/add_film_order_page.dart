import 'package:filmdevelopmentcompanion/model/store_models/cewe_store_model.dart';
import 'package:filmdevelopmentcompanion/model/store_models/dm_de_store_model.dart';
import 'package:filmdevelopmentcompanion/model/store_models/rossmann_new_store_model.dart';
import 'package:filmdevelopmentcompanion/model/store_models/rossmann_old_store_model.dart';
import 'package:filmdevelopmentcompanion/model/store_models/store_model.dart';
import 'package:filmdevelopmentcompanion/view/add_film_order/cewe_add_film_order_page_state.dart';
import 'package:filmdevelopmentcompanion/view/add_film_order/dm_de_add_film_order_page_state.dart';
import 'package:filmdevelopmentcompanion/view/add_film_order/rossmann_new_add_film_order_page_state.dart';
import 'package:filmdevelopmentcompanion/view/add_film_order/rossmann_old_add_film_order_page_state.dart';
import 'package:flutter/material.dart';

class AddFilmOrderPage extends StatefulWidget {
  final StoreModel storeModel;

  AddFilmOrderPage(this.storeModel);

  @override
  State createState() {
    switch (storeModel.providerId) {
      case RossmannOldStoreModel.PROVIDER_ID:
        return RossmannOldAddFilmOrderPageState();
      case RossmannNewStoreModel.PROVIDER_ID:
        return RossmannNewAddFilmOrderPageState();
      case DmDeStoreModel.PROVIDER_ID:
        return DmDeAddFilmOrderPageState();
      case CeweStoreModel.PROVIDER_ID:
        return CeweAddFilmOrderPageState();
    }
    return null;
  }
}
