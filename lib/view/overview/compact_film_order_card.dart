import 'package:expandable/expandable.dart';
import 'package:filmdevelopmentcompanion/model/film_development_order.dart';
import 'package:filmdevelopmentcompanion/view/overview/expanded_film_order_card.dart';
import 'package:flutter/material.dart';

class CompactFilmOrderCard extends StatelessWidget {
  final FilmDevelopmentOrder order;

  const CompactFilmOrderCard(this.order, {Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ExpandablePanel(
      header: Row(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.fromLTRB(8, 5, 0, 5),
            child: Icon(order.iconForStatus, color: Theme.of(context).colorScheme.secondary, size: 55.0),
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(8, 0, 0, 0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  "${order.insertionDateGui} // ${order.storeId} - ${order.orderId}",
                  style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
                ),
              ],
            ),
          )
        ],
      ),
      expanded: ExpandedFilmOrderCard(order),
    );
  }
}
