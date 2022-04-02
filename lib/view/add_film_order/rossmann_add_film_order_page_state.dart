import 'package:filmdevelopmentcompanion/localizations.dart';
import 'package:filmdevelopmentcompanion/model/film_development_appdata_model.dart';
import 'package:filmdevelopmentcompanion/model/store_models/rossmann_store_model.dart';
import 'package:filmdevelopmentcompanion/view/add_film_order/abstract_add_film_order_page_state.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'add_film_order_floating_action_button.dart';

class RossmannOldAddFilmOrderPageState extends AddFilmOrderPageState {
  final orderIdTextController = TextEditingController();
  final htNumberTextController = TextEditingController();
  final noteTextController = TextEditingController();
  String newTextInhtNumber = '';

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    orderIdTextController.dispose();
    htNumberTextController.dispose();
    noteTextController.dispose();
    super.dispose();
  }

  onAddFilmOrderButtonPressed() => addFilmOrder(
        orderIdTextController.text,
        htNumberTextController.text,
        noteTextController.text,
      );

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
        htNumberTextController.selection =
            new TextSelection(baseOffset: newTextInhtNumber.length, extentOffset: newTextInhtNumber.length);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<FilmDevelopmentAppDataModel>(
      builder: (context, cart, child) {
        return Scaffold(
          appBar: AppBar(
            backgroundColor: Theme.of(context).primaryColor,
            title: Text(AppLocalizations.of(context).translate('AddFilmOrderRossmannPageTitle'),
                style: TextStyle(fontWeight: FontWeight.bold)),
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
                      hintText: AppLocalizations.of(context).translate('AddFilmOrderRossmannOrderId'),
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
                      hintText: AppLocalizations.of(context).translate('AddFilmOrderRossmannStoreId'),
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
