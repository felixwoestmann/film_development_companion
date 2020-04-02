import 'package:filmdevelopmentcompanion/model/FilmDevelopmentOrder.dart';
import 'package:flutter/material.dart';

class FilmOrderDetailPage extends StatelessWidget {
  FilmDevelopmentOrder order;

  FilmOrderDetailPage(this.order);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Order detail",style: TextStyle(fontWeight: FontWeight.bold)),
      ),
      body: Column(
        children: <Widget>[Text(order.storeOrderId)],
      ),
    );
  }
}
