import 'package:filmdevelopmentcompanion/model/DmDeStoreModel.dart';
import 'package:filmdevelopmentcompanion/model/StoreModel.dart';
import 'package:flutter/material.dart';

class DmDeAddFilmOrderPage extends StatefulWidget {
  final String title = "Add Film Order";

  @override
  _DmDeAddFilmOrderPageState createState() => _DmDeAddFilmOrderPageState();
}

class _DmDeAddFilmOrderPageState extends State<DmDeAddFilmOrderPage> {
  //TODO use Form https://api.flutter.dev/flutter/widgets/Form-class.html
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
        ),
        body: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.fromLTRB(12.0, 20.0, 0.0, 10.0),
              child: TextField(
                autocorrect: false,
                decoration: InputDecoration(
                  hintText: "Store ID",
                ),
              ),
            ),
            TextField(
              autocorrect: false,
              decoration: InputDecoration(
                hintText: "Order ID",
              ),
            ),
          ],
        ));
  }
}
