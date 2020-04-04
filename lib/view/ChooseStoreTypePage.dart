import 'package:filmdevelopmentcompanion/model/StoreModels.dart';
import 'package:filmdevelopmentcompanion/view/RossmannAddFilmOrderPage.dart';
import 'package:flutter/material.dart';
import 'DmDeAddFilmOrderPage.dart';

class ChooseStoreTypePage extends StatefulWidget {
  final String title = "Choose store type";

  @override
  _ChooseStoreTypePageState createState() => _ChooseStoreTypePageState();
}

class _ChooseStoreTypePageState extends State<ChooseStoreTypePage> {
  Map<StoreModel, Widget> storeModelstorePageMap = {
    new DmDeStoreModel(): new DmDeAddFilmOrderPage(),
    new RossmannStoreModel(): new RossmannAddFilmOrderPage()
  };

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:
            Text(widget.title, style: TextStyle(fontWeight: FontWeight.bold)),
      ),
      body: ListView.separated(
        itemBuilder: (context, position) {
          return ListTile(
            title: Text(
                storeModelstorePageMap.keys.toList()[position].providerName,
                style: TextStyle(fontSize: 22.0)),
            onTap: () => Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) =>
                        storeModelstorePageMap.values.toList()[position])),
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
