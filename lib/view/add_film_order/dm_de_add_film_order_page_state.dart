import 'package:filmdevelopmentcompanion/localizations.dart';
import 'package:filmdevelopmentcompanion/model/film_development_appdata_model.dart';
import 'package:filmdevelopmentcompanion/model/store_models/dm_de_store_model.dart';
import 'package:filmdevelopmentcompanion/view/add_film_order/abstract_add_film_order_page_state.dart';
import 'package:filmdevelopmentcompanion/view/add_film_order/add_film_order_floating_action_button.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DmDeAddFilmOrderPageState extends AddFilmOrderPageState {
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

  onAddFilmOrderButtonPressed() => addFilmOrder(
        orderIdTextController.text,
        storeIdTextController.text,
        noteTextController.text,
      );

  @override
  Widget build(BuildContext context) {
    return Consumer<FilmDevelopmentAppDataModel>(
      builder: (context, cart, child) {
        return Scaffold(
          appBar: AppBar(
            backgroundColor: Theme.of(context).primaryColor,
            title: Text(AppLocalizations.of(context).translate('AddFilmOrderDMPageTitle'),
                style: TextStyle(fontWeight: FontWeight.bold)),
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
                      hintText: AppLocalizations.of(context).translate('AddFilmOrderDMStoreId'),
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
                      hintText: AppLocalizations.of(context).translate('AddFilmOrderDMOrderId'),
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
                          hintText: AppLocalizations.of(context).translate('AddFilmOrderNoteLabel'),
                          hintStyle: TextStyle(fontSize: 18))),
                ),
              ],
            ),
          ),
          floatingActionButton: AddFilmOrderFloatingActionButton(onAddFilmOrderButtonPressed),
        );
      },
    );
  }
}
