import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';

import '../localizations.dart';
import '../model/film_development_order.dart';

class StandardFilmOderCard extends StatelessWidget {
  final FilmDevelopmentOrder order;

  const StandardFilmOderCard(this.order, {Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ExpandablePanel(
      header: Row(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.fromLTRB(8, 10, 0, 5),
            child: Icon(
              order.iconForStatus,
              color: Theme.of(context).colorScheme.secondary,
              size: 55.0,
            ),
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(8, 0, 0, 0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  "${order.insertionDateGui} @ ${order.storeModel.providerNameUi}",
                  style: TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  "${order.storeId} // ${order.orderId}",
                  style: TextStyle(
                    fontSize: 20.0,
                    color: Colors.grey[600],
                  ),
                ),
              ],
            ),
          )
        ],
      ),
      collapsed: Row(
        children: <Widget>[
          Flexible(
            child: Padding(
              padding: EdgeInsets.fromLTRB(15, 0, 0, 10),
              child: Text(
                order.latestFilmDevelopmentStatusSummaryText,
                style: TextStyle(fontSize: 20.0),
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ),
        ],
      ),
      expanded: Padding(
        padding: EdgeInsets.fromLTRB(15, 0, 0, 10),
        child: Column(
          children: <Widget>[
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(right: 5.0),
                  child: Text(
                    AppLocalizations.of(context).translate('FilmOrderOverviewCardStateLabel'),
                    style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
                  ),
                ),
                Flexible(
                  child: Padding(
                    padding: const EdgeInsets.only(right: 5.0),
                    child: Text(
                      order.latestFilmDevelopmentStatusSummaryText,
                      style: TextStyle(fontSize: 20.0),
                      overflow: TextOverflow.ellipsis,
                      maxLines: 5,
                    ),
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(top: 8),
              child: Row(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(right: 5.0),
                    child: Text(
                      AppLocalizations.of(context).translate('FilmOrderOverviewCardNoteLabel'),
                      style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
                    ),
                  ),
                  Flexible(
                    child: Text(
                      order.note,
                      style: TextStyle(fontSize: 20.0),
                      overflow: TextOverflow.ellipsis,
                      maxLines: 8,
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(0, 15, 20, 0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  Text(order.price,
                      style: TextStyle(
                        fontSize: 20.0,
                        color: Colors.grey[600],
                      )),
                  Padding(
                    padding: EdgeInsets.only(left: 3),
                    child: Icon(
                      Icons.euro_symbol,
                      color: Colors.grey[600],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
