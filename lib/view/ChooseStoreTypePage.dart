import 'package:filmdevelopmentcompanion/model/DmDeStoreModel.dart';
import 'package:filmdevelopmentcompanion/model/StoreModel.dart';
import 'package:flutter/material.dart';

class ChooseStoreTypePage extends StatefulWidget {

  final String title="Add Film";

  @override
  _ChooseStoreTypePageState createState() => _ChooseStoreTypePageState();
}

class _ChooseStoreTypePageState extends State<ChooseStoreTypePage> {
  List<StoreModel> storeModels = new List();

  @override
  void initState() {
    super.initState();
    storeModels.add(new DmDeStoreModel());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: ListView.builder(
        itemBuilder: (context, position) {
          return Column(
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
                          storeModels[position].providerName,
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
          );
        },
        itemCount: storeModels.length,
      ),
    );
  }
}
