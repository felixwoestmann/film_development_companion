import 'package:filmdevelopmentcompanion/model/FilmDevelopmentAppDataModel.dart';
import 'package:filmdevelopmentcompanion/model/FilmDevelopmentOrder.dart';
import 'package:filmdevelopmentcompanion/view/add_film_order/AddFilmOrderPage.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

abstract class AddFilmOrderPageState extends State<AddFilmOrderPage> {
  final EdgeInsets fieldInsets = EdgeInsets.fromLTRB(15.0, 30.0, 15.0, 10.0);

  void addFilmOrder(String orderId, String storeId, String note) {
    var order =
        new FilmDevelopmentOrder(widget.storeModel, orderId, storeId, note);
    Provider.of<FilmDevelopmentAppDataModel>(context, listen: false)
        .addFilmOrder(order);
    Navigator.popUntil(context, ModalRoute.withName('/'));
  }
}
