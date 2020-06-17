import 'package:filmdevelopmentcompanion/localizations.dart';
import 'package:filmdevelopmentcompanion/model/film_development_appdata_model.dart';
import 'package:filmdevelopmentcompanion/view/add_film_order/abstract_add_film_order_page_state.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CeweAddFilmOrderPageState extends AddFilmOrderPageState {
  //TODO use Form https://api.flutter.dev/flutter/widgets/Form-class.html
  final orderIdTextController = TextEditingController();
  final storeIdTextController = TextEditingController();
  final noteTextController = TextEditingController();

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    orderIdTextController.dispose();
    storeIdTextController.dispose();
    noteTextController.dispose();
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
            title: Text(
                AppLocalizations.of(context)
                    .translate('AddFilmOrderCewePageTitle'),
                style: TextStyle(fontWeight: FontWeight.bold)),
          ),
          body: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                Padding(
                  padding: fieldInsets,
                  child: TextField(
                    autocorrect: false,
                    controller: storeIdTextController,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      hintText: AppLocalizations.of(context)
                          .translate('AddFilmOrderCeweStoreId'),
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
                      hintText: AppLocalizations.of(context)
                          .translate('AddFilmOrderCeweOrderId'),
                      hintStyle: TextStyle(fontSize: 18),
                    ),
                  ),
                ),
                Padding(
                  padding: fieldInsets,
                  child: TextField(
                      maxLines: 5,
                      controller: noteTextController,
                      decoration: InputDecoration(
                          hintText: AppLocalizations.of(context)
                              .translate('AddFilmOrderNoteLabel'),
                          hintStyle: TextStyle(fontSize: 18))),
                ),
              ],
            ),
          ),
          floatingActionButton: FloatingActionButton.extended(
            onPressed: () => addFilmOrder(orderIdTextController.text,
                storeIdTextController.text, noteTextController.text),
            icon: Icon(Icons.check),
            label: Text(
                AppLocalizations.of(context)
                    .translate('AddFilmOrderSaveOrderLabel'),
                style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold)),
          ),
        );
      },
    );
  }
}
