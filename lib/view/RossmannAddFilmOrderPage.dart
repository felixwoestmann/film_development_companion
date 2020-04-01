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
  final storePLZTextController = TextEditingController();
  List<Map<String, String>> listOfRossmannStores = new List();

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    orderIdTextController.dispose();
    storeIdTextController.dispose();
    storePLZTextController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    storePLZTextController.addListener(_storePlzTextControllerHasChanged);
  }

  _storePlzTextControllerHasChanged() async {
    String plz = storePLZTextController.text;
    listOfRossmannStores =
        await RossmannStatusProvider.instance.loadStoresForPLZ(plz);
    setState(() {});
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
              Padding(
                padding: const EdgeInsets.fromLTRB(15.0, 30.0, 15.0, 10.0),
                child: TextField(
                  autocorrect: false,
                  controller: storePLZTextController,
                  keyboardType: TextInputType.number,
                  maxLength: 5,
                  decoration: InputDecoration(
                    hintText: "PLZ des Stores",
                    hintStyle: TextStyle(fontSize: 18),
                  ),
                ),
              ),
              Container(
                height: 300,
                child: ListView.builder(
                    itemBuilder: (context, position) {
                      return ListTile(
                          title: Text(listOfRossmannStores[position]['street']),
                          subtitle: Text(
                              "${listOfRossmannStores[position]['zip']} ${listOfRossmannStores[position]['city']}"));
                    },
                    itemCount: listOfRossmannStores.length),
              )
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
