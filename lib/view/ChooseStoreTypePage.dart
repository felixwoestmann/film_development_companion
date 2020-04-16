import 'package:filmdevelopmentcompanion/Localizations.dart';
import 'package:filmdevelopmentcompanion/model/StoreModels.dart';
import 'package:filmdevelopmentcompanion/view/AddFilmOrderPage.dart';
import 'package:flutter/material.dart';

class ChooseStoreTypePage extends StatefulWidget {
  @override
  _ChooseStoreTypePageState createState() => _ChooseStoreTypePageState();
}

class _ChooseStoreTypePageState extends State<ChooseStoreTypePage> {
  List<StoreModel> storeModelstorePageMap = [
    DmDeStoreModel.instance,
    RossmannStoreModel.instance,
    CeweStoreModel.instance
  ];

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
            title: Text(storeModelstorePageMap[position].providerName,
                style: TextStyle(fontSize: 22.0)),
            onTap: () => Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => new AddFilmOrderPage(
                        storeModelstorePageMap[position]))),
          );
        },
        separatorBuilder: (context, index) => Divider(
          color: Colors.grey[700],
          height: 2.5,
        ),
        itemCount: storeModelstorePageMap.length,
      ),
    );
  }
}
