import 'package:filmdevelopmentcompanion/model/DmDeStoreModel.dart';
import 'package:filmdevelopmentcompanion/model/FilmDevelopmentOrder.dart';
import 'package:filmdevelopmentcompanion/model/FilmDevelopmentOrderDataHolder.dart';
import 'package:filmdevelopmentcompanion/model/StoreModel.dart';
import 'package:flutter/material.dart';

class DmDeAddFilmOrderPage extends StatefulWidget {
  final String title = "Add Film Order";

  @override
  _DmDeAddFilmOrderPageState createState() => _DmDeAddFilmOrderPageState();
}

class _DmDeAddFilmOrderPageState extends State<DmDeAddFilmOrderPage> {
  //TODO use Form https://api.flutter.dev/flutter/widgets/Form-class.html

  final orderIdTextController = TextEditingController();
  final storeIdTextController = TextEditingController();

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    orderIdTextController.dispose();
    storeIdTextController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
  }

  void addFilmOrder() {
    FilmDevelopmentDataHolder.instance.addFilmOrder(new FilmDevelopmentOrder(
        new DmDeStoreModel(),
        orderIdTextController.text,
        storeIdTextController.text));
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
            padding: const EdgeInsets.fromLTRB(15.0, 30.0, 15.0, 10.0),
            child: TextField(
              autocorrect: false,
              controller: storeIdTextController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                hintText: "Store ID",
                hintStyle: TextStyle(fontSize: 18),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(15.0, 30.0, 15.0, 10.0),
            child: TextField(
              autocorrect: false,
              controller: orderIdTextController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                hintText: "Order ID",
                hintStyle: TextStyle(fontSize: 18),
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: addFilmOrder,
        child: Icon(Icons.check),
      ),
    );
  }
}
