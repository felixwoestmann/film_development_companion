import 'package:expandable/expandable.dart';
import 'package:filmdevelopmentcompanion/model/FilmDevelopmentAppDataModel.dart';
import 'package:filmdevelopmentcompanion/view/ChooseStoreTypePage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class FilmOrderOverviewPage extends StatefulWidget {
  final String title = "Overview";
  final Color secondary = Colors.grey[600];

  @override
  _FilmOrderOverviewPageState createState() => _FilmOrderOverviewPageState();
}

class _FilmOrderOverviewPageState extends State<FilmOrderOverviewPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<FilmDevelopmentAppDataModel>(
      builder: (context, filmordermodel, child) {
        return Scaffold(
          appBar: AppBar(
            title: Text(
              widget.title,
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
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
                      child: ExpandablePanel(
                        header: Row(
                          children: <Widget>[
                            Padding(
                              padding: EdgeInsets.fromLTRB(8, 10, 0, 10),
                              child: Icon(
                                  filmordermodel
                                      .filmOrders[position].iconForStatus,
                                  color: Colors.deepOrangeAccent,
                                  size: 55.0),
                            ),
                            Padding(
                              padding: EdgeInsets.fromLTRB(8, 0, 0, 0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Text(
                                    filmordermodel.filmOrders[position]
                                            .insertionDateGui +
                                        " @ " +
                                        filmordermodel.filmOrders[position]
                                            .storeModel.providerNameUi,
                                    style: TextStyle(
                                        fontSize: 20.0,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Text(
                                    filmordermodel
                                        .filmOrders[position].storeOrderId,
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
                                children: <Widget>[
                                  Flexible(
                                    child: Text(
                                      filmordermodel.filmOrders[position]
                                          .latestFilmDevelopmentStatusSummaryText,
                                      style: TextStyle(fontSize: 20.0),
                                      overflow: TextOverflow.ellipsis,
                                      maxLines: 8,
                                    ),
                                  ),
                                ],
                              ),
                              Padding(
                                padding: EdgeInsets.fromLTRB(0, 15, 20, 0),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: <Widget>[
                                    Text(
                                        filmordermodel
                                            .filmOrders[position].price,
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
                      ),
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
              'Add Order',
              style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
            ),
          ),
        );
      },
    );
  }
}
