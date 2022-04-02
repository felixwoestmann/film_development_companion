import 'package:filmdevelopmentcompanion/localizations.dart';
import 'package:filmdevelopmentcompanion/model/film_development_appdata_model.dart';
import 'package:filmdevelopmentcompanion/model/store_models/store_model.dart';
import 'package:filmdevelopmentcompanion/view/set_home_store_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SettingsPage extends StatefulWidget {
  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<FilmDevelopmentAppDataModel>(
      builder: (context, filmordermodel, child) {
        return Scaffold(
          appBar: AppBar(
            title:
                Text(AppLocalizations.of(context).translate('Settings'), style: TextStyle(fontWeight: FontWeight.bold)),
          ),
          body: Column(
            children: <Widget>[
              ListTile(
                leading: Icon(
                  Icons.home,
                  color: Theme.of(context).colorScheme.secondary,
                ),
                title: Text(AppLocalizations.of(context).translate('SetHomeStores')),
              ),
              Expanded(
                  child: ListView.separated(
                itemBuilder: (context, position) {
                  return Padding(
                    padding: const EdgeInsets.fromLTRB(70, 0, 0, 0),
                    child: ListTile(
                      title: Text(StoreModel.getStoreModels()[position].providerName),
                      subtitle: Text(AppLocalizations.of(context).translate('AddFilmOrderDMStoreId') +
                          filmordermodel.getHomeStoreForStoreModel(StoreModel.getStoreModels()[position])),
                      onTap: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => new SetHomeStorePage(StoreModel.getStoreModels()[position]))),
                      trailing: Icon(Icons.keyboard_arrow_right),
                    ),
                  );
                },
                separatorBuilder: (context, index) => Divider(
                  color: Colors.white,
                  height: 0.1,
                ),
                itemCount: StoreModel.getStoreModels().length,
              )),
            ],
          ),
        );
      },
    );
  }
}
