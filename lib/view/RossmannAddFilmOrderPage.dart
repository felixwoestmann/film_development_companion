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
  final htNumberTextController = TextEditingController();
  String newTextInhtNumber = '';

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    orderIdTextController.dispose();
    htNumberTextController.dispose();

    super.dispose();
  }

  @override
  void initState() {
    super.initState();
  }

  void addFilmOrder() {
    var order = new FilmDevelopmentOrder(new RossmannStoreModel(),
        orderIdTextController.text, htNumberTextController.text);
    Provider.of<FilmDevelopmentAppDataModel>(context, listen: false)
        .addFilmOrder(order);
    Navigator.popUntil(context, ModalRoute.withName('/'));
  }

  //Method is called when HTNUMBER field has changed.
  //Inserts dash ('-') after the first two characters
  void htNumberOnChange(String param) {
    String text = htNumberTextController.text;
    if (text.length < newTextInhtNumber.length) {
      // handling backspace in keyboard
      newTextInhtNumber = text;
    } else if (text.isNotEmpty && text != newTextInhtNumber) {
      // handling typing new characters.
      String tempText = text.replaceAll("-", "");
      if (tempText.length == 2) {
        //do your text transforming
        newTextInhtNumber = '$text-';
        htNumberTextController.text = newTextInhtNumber;
        htNumberTextController.selection = new TextSelection(
            baseOffset: newTextInhtNumber.length,
            extentOffset: newTextInhtNumber.length);
      }
    }
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
              Padding(
                padding: const EdgeInsets.fromLTRB(15.0, 30.0, 15.0, 10.0),
                child: TextField(
                  autocorrect: false,
                  keyboardType: TextInputType.number,
                  controller: htNumberTextController,
                  onChanged: htNumberOnChange,
                  decoration: InputDecoration(
                    hintText: "HT NUMBER",
                    hintStyle: TextStyle(fontSize: 18),
                  ),
                ),
              ),
            ],
          ),
          floatingActionButton: FloatingActionButton.extended(
            onPressed: addFilmOrder,
            icon: Icon(Icons.check),
            label: Text('Save Order',
                style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold)),
          ),
        );
      },
    );
  }
}
