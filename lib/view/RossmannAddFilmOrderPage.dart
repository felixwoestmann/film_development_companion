import 'package:filmdevelopmentcompanion/io/RossmannStatusProvider.dart';
import 'package:filmdevelopmentcompanion/model/FilmDevelopmentOrder.dart';
import 'package:filmdevelopmentcompanion/model/FilmDevelopmentAppDataModel.dart';
import 'package:filmdevelopmentcompanion/model/StoreModels.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class RossmannAddFilmOrderPage extends StatefulWidget {
  final String title = "Add Rossmann Film Order";

  @override
  _RossmannAddFilmOrderPage createState() => _RossmannAddFilmOrderPage();
}

class _RossmannAddFilmOrderPage extends State<RossmannAddFilmOrderPage> {
  //TODO use Form https://api.flutter.dev/flutter/widgets/Form-class.html

  final orderIdTextController = TextEditingController();
  final storeIdTextController = TextEditingController();
  List<Map<String, String>> listOfRossmannStores = new List();

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
    var order = new FilmDevelopmentOrder(new RossmannStoreModel(),
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
                  controller: orderIdTextController,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    hintText: "Order ID",
                    hintStyle: TextStyle(fontSize: 18),
                  ),
                ),
              ),
              Row(
                children: <Widget>[
                  Flexible(
                    child: Padding(
                      padding:
                          const EdgeInsets.fromLTRB(15.0, 30.0, 20.0, 10.0),
                      child: TextField(
                        autocorrect: false,
                        keyboardType: TextInputType.number,
                        maxLength: 2,
                        decoration: InputDecoration(
                          hintText: "FIRMA",
                          hintStyle: TextStyle(fontSize: 18),
                        ),
                      ),
                    ),
                  ),
                  Text("-",
                      style: TextStyle(
                        fontSize: 50.0,
                      )),
                  Flexible(
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(20.0, 30.0, 15.0, 10.0),
                      child: TextField(
                        autocorrect: false,
                        controller: storeIdTextController,
                        keyboardType: TextInputType.number,
                        maxLength: 6,
                        decoration: InputDecoration(
                          hintText: "HTNUMBER",
                          hintStyle: TextStyle(fontSize: 18),
                        ),
                      ),
                    ),
                  ),
                ],
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
