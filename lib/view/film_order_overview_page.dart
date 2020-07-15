import 'package:expandable/expandable.dart';
import 'package:filmdevelopmentcompanion/localizations.dart';
import 'package:filmdevelopmentcompanion/model/film_development_appdata_model.dart';
import 'package:filmdevelopmentcompanion/view/choose_store_type_page.dart';
import 'package:filmdevelopmentcompanion/view/misc/third_party_license_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class FilmOrderOverviewPage extends StatefulWidget {
  final Color secondary = Colors.grey[600];

  @override
  _FilmOrderOverviewPageState createState() => _FilmOrderOverviewPageState();
}

class _FilmOrderOverviewPageState extends State<FilmOrderOverviewPage> {
  @override
  void initState() {
    super.initState();
  }

  Icon getIconForViewType(FilmDevelopmentAppDataModel filmordermodel) {
    if (filmordermodel.showCompactView) {
      return Icon(Icons.view_agenda);
    } else {
      return Icon(Icons.view_compact);
    }
  }

  Widget getExpandableCardForViewType(
      FilmDevelopmentAppDataModel filmordermodel, int position) {
    if (filmordermodel.showCompactView) {
      return ExpandablePanel(
        header: Row(
          children: <Widget>[
            Padding(
              padding: EdgeInsets.fromLTRB(8, 5, 0, 5),
              child: Icon(filmordermodel.filmOrders[position].iconForStatus,
                  color: Theme.of(context).accentColor, size: 55.0),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(8, 0, 0, 0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    filmordermodel.filmOrders[position].insertionDateGui +
                        " // " +
                        filmordermodel.filmOrders[position].storeOrderId,
                    style: TextStyle(
                      fontSize: 20.0,
                    ),
                  ),
                ],
              ),
            )
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
                      AppLocalizations.of(context)
                          .translate('FilmOrderOverviewCardStateLabel'),
                      style: TextStyle(
                          fontSize: 20.0, fontWeight: FontWeight.bold),
                    ),
                  ),
                  Flexible(
                    child: Padding(
                      padding: const EdgeInsets.only(right: 5.0),
                      child: Text(
                        filmordermodel.filmOrders[position]
                            .latestFilmDevelopmentStatusSummaryText,
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
                        AppLocalizations.of(context)
                            .translate('FilmOrderOverviewCardNoteLabel'),
                        style: TextStyle(
                            fontSize: 20.0, fontWeight: FontWeight.bold),
                      ),
                    ),
                    Flexible(
                      child: Text(
                        filmordermodel.filmOrders[position].note,
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
                    Text(filmordermodel.filmOrders[position].price,
                        style: TextStyle(
                          fontSize: 20.0,
                          color: widget.secondary,
                        )),
                    Padding(
                      padding: EdgeInsets.only(left: 3),
                      child: Icon(
                        Icons.euro_symbol,
                        color: widget.secondary,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      );
    } else {
      return ExpandablePanel(
        header: Row(
          children: <Widget>[
            Padding(
              padding: EdgeInsets.fromLTRB(8, 10, 0, 5),
              child: Icon(filmordermodel.filmOrders[position].iconForStatus,
                  color: Theme.of(context).accentColor, size: 55.0),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(8, 0, 0, 0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    filmordermodel.filmOrders[position].insertionDateGui +
                        " @ " +
                        filmordermodel
                            .filmOrders[position].storeModel.providerNameUi,
                    style:
                        TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    filmordermodel.filmOrders[position].storeOrderId,
                    style: TextStyle(
                      fontSize: 20.0,
                      color: widget.secondary,
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
                  filmordermodel.filmOrders[position]
                      .latestFilmDevelopmentStatusSummaryText,
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
                      AppLocalizations.of(context)
                          .translate('FilmOrderOverviewCardStateLabel'),
                      style: TextStyle(
                          fontSize: 20.0, fontWeight: FontWeight.bold),
                    ),
                  ),
                  Flexible(
                    child: Padding(
                      padding: const EdgeInsets.only(right: 5.0),
                      child: Text(
                        filmordermodel.filmOrders[position]
                            .latestFilmDevelopmentStatusSummaryText,
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
                        AppLocalizations.of(context)
                            .translate('FilmOrderOverviewCardNoteLabel'),
                        style: TextStyle(
                            fontSize: 20.0, fontWeight: FontWeight.bold),
                      ),
                    ),
                    Flexible(
                      child: Text(
                        filmordermodel.filmOrders[position].note,
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
                    Text(filmordermodel.filmOrders[position].price,
                        style: TextStyle(
                          fontSize: 20.0,
                          color: widget.secondary,
                        )),
                    Padding(
                      padding: EdgeInsets.only(left: 3),
                      child: Icon(
                        Icons.euro_symbol,
                        color: widget.secondary,
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

  @override
  Widget build(BuildContext context) {
    return Consumer<FilmDevelopmentAppDataModel>(
      builder: (context, filmordermodel, child) {
        return Scaffold(
          appBar: AppBar(
            title: Text(
              AppLocalizations.of(context)
                  .translate('FilmOrderOverviewPageTitle'),
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            actions: <Widget>[
              IconButton(
                icon: getIconForViewType(filmordermodel),
                tooltip: 'Toggle View', //TO i18
                onPressed: () {
                  filmordermodel.toggleCompactView();
                },
              ),
              PopupMenuButton<Widget>(
                onSelected: (value) => Navigator.push(
                    context, MaterialPageRoute(builder: (context) => value)),
                itemBuilder: (context) => [
                  PopupMenuItem(
                    value: LicensePage(),
                    child: Text(AppLocalizations.of(context)
                        .translate('FilmOrderOverviewFlutterLicensesLabel')),
                  ),
                  PopupMenuItem(
                    value: ThirdPartyLicensesPage(),
                    child: Text(AppLocalizations.of(context)
                        .translate('FilmOrderOverviewThirdpartyLicensesLabel')),
                  ),
                ],
              )
            ],
          ),
          body: RefreshIndicator(
              child: ListView.builder(
                itemBuilder: (context, position) {
                  return Dismissible(
                    key: Key(filmordermodel.filmOrders[position].id.toString()),
                    background: Container(
                      alignment: AlignmentDirectional.centerStart,
                      color: Colors.red,
                      child: Padding(
                        padding: EdgeInsets.fromLTRB(12, 10, 8, 10),
                        child: Icon(
                          Icons.delete,
                          color: Colors.white,
                          size: 30,
                        ),
                      ),
                    ),
                    onDismissed: (direction) {
                      filmordermodel.deleteFilmOrder(position);
                    },
                    direction: DismissDirection.startToEnd,
                    child: Card(
                      elevation: 8,
                      margin: EdgeInsets.fromLTRB(8, 10, 8, 10),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(18.0),
                      ),
                      child: getExpandableCardForViewType(
                          filmordermodel, position),
                    ),
                  );
                },
                itemCount: filmordermodel.filmOrders.length,
              ),
              onRefresh: filmordermodel.updateAllOrders),
          floatingActionButton: FloatingActionButton.extended(
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => ChooseStoreTypePage()));
            },
            icon: Icon(Icons.add),
            label: Text(
              AppLocalizations.of(context).translate('FilmOrderOverviewButton'),
              style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
            ),
          ),
        );
      },
    );
  }
}
