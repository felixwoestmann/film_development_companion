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
      body: ListView.builder(
        itemBuilder: (context, position) {
          return GestureDetector(
            child: Column(
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Padding(
                          padding:
                              const EdgeInsets.fromLTRB(12.0, 20.0, 0.0, 10.0),
                          child: Text(
                            storeModelstorePageMap.keys
                                .toList()[position]
                                .providerName,
                            style: TextStyle(fontSize: 22.0),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                Divider(
                  height: 2.0,
                  color: Colors.grey,
                )
              ],
            ),
            onTap: () => Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) =>
                        storeModelstorePageMap.values.toList()[position])),
          );
        },
        itemCount: storeModelstorePageMap.length,
      ),
    );
  }
}
