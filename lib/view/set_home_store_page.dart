import 'package:filmdevelopmentcompanion/localizations.dart';
import 'package:filmdevelopmentcompanion/model/film_development_appdata_model.dart';
import 'package:filmdevelopmentcompanion/model/store_models/dm_de_store_model.dart';
import 'package:filmdevelopmentcompanion/model/store_models/store_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SetHomeStorePage extends StatefulWidget {
  final StoreModel storeModel;

  SetHomeStorePage(this.storeModel);

  @override
  _SetHomeStorePageState createState() => _SetHomeStorePageState(storeModel);
}

class _SetHomeStorePageState extends State<SetHomeStorePage> {
  final storeIdTextController = TextEditingController();
  final StoreModel storeModel;

  _SetHomeStorePageState(this.storeModel);

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    storeIdTextController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
  }

  void saveHomeStore(String homeStore) {
    Provider.of<FilmDevelopmentAppDataModel>(context, listen: false)
        .saveHomeStoreForStoreModel(storeModel, homeStore);
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<FilmDevelopmentAppDataModel>(
      builder: (context, cart, child) {
        return Scaffold(
          appBar: AppBar(
            title:
                Text("Set HomeStore for " + storeModel.providerName, //TODO i18
                    style: TextStyle(fontWeight: FontWeight.bold)),
          ),
          body: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                Image(image: storeModel.exampleImage),
                Padding(
                  padding: const EdgeInsets.fromLTRB(15.0, 30.0, 15.0, 10.0),
                  child: TextField(
                    autocorrect: false,
                    controller: storeIdTextController,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      hintText: AppLocalizations.of(context)
                          .translate('AddFilmOrderDMStoreId'), //TODO i18
                      hintStyle: TextStyle(fontSize: 18),
                    ),
                  ),
                ),
              ],
            ),
          ),
          floatingActionButton: FloatingActionButton.extended(
            onPressed: () => saveHomeStore(storeIdTextController.text),
            icon: Icon(Icons.check),
            label: Text("Save HomeStore", //TODO i18
                style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold)),
          ),
        );
      },
    );
  }
}
