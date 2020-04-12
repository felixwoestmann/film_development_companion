import 'package:filmdevelopmentcompanion/model/FilmDevelopmentOrder.dart';
import 'package:filmdevelopmentcompanion/model/FilmDevelopmentAppDataModel.dart';
import 'package:filmdevelopmentcompanion/model/StoreModels.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AddFilmOrderPage extends StatefulWidget {
  final StoreModel storeModel;

  AddFilmOrderPage(this.storeModel);

  @override
  State createState() {
    switch (storeModel.providerId) {
      case RossmannStoreModel.PROVIDER_ID:
        return _RossmannAddFilmOrderPageState();
      case DmDeStoreModel.PROVIDER_ID:
        return _DmDeAddFilmOrderPageState();
      case CeweStoreModel.PROVIDER_ID:
        return _CeweAddFilmOrderPageState();
    }
    return null;
  }
}

abstract class _AddFilmOrderPageState extends State<AddFilmOrderPage> {
  final EdgeInsets fieldInsets = EdgeInsets.fromLTRB(15.0, 30.0, 15.0, 10.0);

  void addFilmOrder(String orderId, String storeId) {
    var order = new FilmDevelopmentOrder(widget.storeModel, orderId, storeId);
    Provider.of<FilmDevelopmentAppDataModel>(context, listen: false)
        .addFilmOrder(order);
    Navigator.popUntil(context, ModalRoute.withName('/'));
  }
}

class _RossmannAddFilmOrderPageState extends _AddFilmOrderPageState {
  //TODO use Form https://api.flutter.dev/flutter/widgets/Form-class.html
  String title = "Add Rossmann film order";
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
            title: Text(title, style: TextStyle(fontWeight: FontWeight.bold)),
          ),
          body: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                Image(image: RossmannStoreModel.instance.exampleImage),
                Padding(
                  padding: fieldInsets,
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
                  padding: fieldInsets,
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
          ),
          floatingActionButton: FloatingActionButton.extended(
            onPressed: () => addFilmOrder(
                orderIdTextController.text, htNumberTextController.text),
            icon: Icon(Icons.check),
            label: Text('Save Order',
                style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold)),
          ),
        );
      },
    );
  }
}

class _DmDeAddFilmOrderPageState extends _AddFilmOrderPageState {
  //TODO use Form https://api.flutter.dev/flutter/widgets/Form-class.html
  final String title = "Add dm film order";
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

  @override
  Widget build(BuildContext context) {
    return Consumer<FilmDevelopmentAppDataModel>(
      builder: (context, cart, child) {
        return Scaffold(
          appBar: AppBar(
            title: Text(title, style: TextStyle(fontWeight: FontWeight.bold)),
          ),
          body: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                Image(image: DmDeStoreModel.instance.exampleImage),
                Padding(
                  padding: fieldInsets,
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
                  padding: fieldInsets,
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
                  padding: fieldInsets,
                  child: TextField(
                      maxLines: 5,
                      decoration: InputDecoration(
                          hintText: "Notizen",
                          hintStyle: TextStyle(fontSize: 18))),
                ),
              ],
            ),
          ),
          floatingActionButton: FloatingActionButton.extended(
            onPressed: () => addFilmOrder(
                orderIdTextController.text, storeIdTextController.text),
            icon: Icon(Icons.check),
            label: Text('Save Order',
                style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold)),
          ),
        );
      },
    );
  }
}

class _CeweAddFilmOrderPageState extends _AddFilmOrderPageState {
  //TODO use Form https://api.flutter.dev/flutter/widgets/Form-class.html
  final String title = "Add Cewe film order";
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

  @override
  Widget build(BuildContext context) {
    return Consumer<FilmDevelopmentAppDataModel>(
      builder: (context, cart, child) {
        return Scaffold(
          appBar: AppBar(
            title: Text(title, style: TextStyle(fontWeight: FontWeight.bold)),
          ),
          body: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                Image(image: DmDeStoreModel.instance.exampleImage),
                Padding(
                  padding: fieldInsets,
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
                  padding: fieldInsets,
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
          ),
          floatingActionButton: FloatingActionButton.extended(
            onPressed: () => addFilmOrder(
                orderIdTextController.text, storeIdTextController.text),
            icon: Icon(Icons.check),
            label: Text('Save Order',
                style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold)),
          ),
        );
      },
    );
  }
}
