import 'package:filmdevelopmentcompanion/model/FilmDevelopmentOrder.dart';
import 'package:filmdevelopmentcompanion/model/FilmDevelopmentAppDataModel.dart';
import 'package:filmdevelopmentcompanion/model/StoreModels.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DmDeAddFilmOrderPage extends StatefulWidget {
  final String title = "Add DM Film Order";

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
    var order = new FilmDevelopmentOrder(new DmDeStoreModel(),
        orderIdTextController.text, storeIdTextController.text);
    Provider.of<FilmDevelopmentAppDataModel>(context, listen: false)
        .addFilmOrder(order);
    Navigator.popUntil(context, ModalRoute.withName('/'));
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<FilmDevelopmentAppDataModel>(
      builder: (context, cart, child) {
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
          floatingActionButton: FloatingActionButton.extended(
            onPressed: addFilmOrder,
            icon: Icon(Icons.check),
            label: Text('Save Order'),
          ),
        );
      },
    );
  }
}
