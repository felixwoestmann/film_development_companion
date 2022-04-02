import 'package:flutter/material.dart';

import '../../localizations.dart';
import '../../model/film_development_order.dart';

class ExpandedFilmOrderCard extends StatelessWidget {
  final FilmDevelopmentOrder order;

  const ExpandedFilmOrderCard(this.order, {Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
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
    );
  }
}
