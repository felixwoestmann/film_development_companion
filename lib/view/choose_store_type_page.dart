import 'package:filmdevelopmentcompanion/localizations.dart';
import 'package:filmdevelopmentcompanion/model/store_models/cewe_store_model.dart';
import 'package:filmdevelopmentcompanion/model/store_models/dm_de_store_model.dart';
import 'package:filmdevelopmentcompanion/model/store_models/mueller_store_model.dart';
import 'package:filmdevelopmentcompanion/model/store_models/rossmann_store_model.dart';
import 'package:filmdevelopmentcompanion/model/store_models/store_model.dart';
import 'package:filmdevelopmentcompanion/view/add_film_order/add_film_order_page.dart';
import 'package:flutter/material.dart';

class ChooseStoreTypePage extends StatefulWidget {
  @override
  _ChooseStoreTypePageState createState() => _ChooseStoreTypePageState();
}

class _ChooseStoreTypePageState extends State<ChooseStoreTypePage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
            AppLocalizations.of(context).translate('ChooseStoreTypePageTitle'),
            style: TextStyle(fontWeight: FontWeight.bold)),
      ),
      body: ListView.separated(
        itemBuilder: (context, position) {
          return ListTile(
            title: Text(StoreModel.getStoreModels()[position].providerName,
                style: TextStyle(fontSize: 22.0)),
            onTap: () => Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => new AddFilmOrderPage(
                        StoreModel.getStoreModels()[position]))),
          );
        },
        separatorBuilder: (context, index) => Divider(
          color: Colors.grey[700],
          height: 2.5,
        ),
        itemCount: StoreModel.getStoreModels().length,
      ),
    );
  }
}
