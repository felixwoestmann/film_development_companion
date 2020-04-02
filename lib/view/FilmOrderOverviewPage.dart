import 'package:filmdevelopmentcompanion/model/FilmDevelopmentOrder.dart';
import 'package:filmdevelopmentcompanion/model/FilmDevelopmentAppDataModel.dart';
import 'package:filmdevelopmentcompanion/view/ChooseStoreTypePage.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../model/StoreModels.dart';

class FilmOrderOverviewPage extends StatefulWidget {
  final String title = "Film Development Companion";

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
            title: Text(widget.title),
          ),
          body: RefreshIndicator(
              child: ListView.builder(
                itemBuilder: (context, position) {
                  return Dismissible(
                    key: Key(filmordermodel.filmOrders[position].id.toString()),
                    background: Container(
                      alignment: AlignmentDirectional.centerStart,
                      color: Colors.red,
                      child: Icon(
                        Icons.delete,
                        color: Colors.white,
                      ),
                    ),
                    onDismissed: (direction) {
                      filmordermodel.deleteFilmOrder(position);
                    },
                    direction: DismissDirection.startToEnd,
                    child: Card(
                      elevation: 10,
                      margin: EdgeInsets.fromLTRB(8, 10, 8, 10),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(18.0),
                      ),
                      child: Column(
                        children: <Widget>[
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Padding(
                                padding: EdgeInsets.fromLTRB(8, 10, 0, 10),
                                child: Icon(
                                    filmordermodel
                                        .filmOrders[position].iconforstatus,
                                    color: Colors.deepOrangeAccent,
                                    size: 60.0),
                              ),
                              Container(
                                  height: 80,
                                  child:
                                      VerticalDivider(color: Colors.grey[600])),
                              Flexible(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Padding(
                                      padding: const EdgeInsets.fromLTRB(
                                          5.0, 12.0, 12.0, 0.0),
                                      child: Text(
                                        filmordermodel.filmOrders[position]
                                            .insertionDateGui,
                                        style: TextStyle(
                                            fontSize: 20.0,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.fromLTRB(
                                          5.0, 3.0, 8.0, 0.0),
                                      child: Text(
                                        filmordermodel.filmOrders[position]
                                            .latestFilmDevelopmentStatusSummaryText,
                                        style: TextStyle(fontSize: 20.0),
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                    Padding(
                                        padding: const EdgeInsets.fromLTRB(
                                            5.0, 3.0, 12.0, 12.0),
                                        child: Row(
                                          children: <Widget>[
                                            Text(
                                              filmordermodel
                                                      .filmOrders[position]
                                                      .orderNumber +
                                                  " - " +
                                                  filmordermodel
                                                      .filmOrders[position]
                                                      .storeId,
                                              style: TextStyle(
                                                fontSize: 20.0,
                                                color: Colors.grey[600],
                                              ),
                                            ),
                                            Padding(
                                                padding:
                                                    const EdgeInsets.fromLTRB(
                                                        20.0, 0.0, 0.0, 0.0)),
                                            Text(
                                                filmordermodel
                                                    .filmOrders[position].price,
                                                style: TextStyle(
                                                  fontSize: 20.0,
                                                  color: Colors.grey[600],
                                                ))
                                          ],
                                        )),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ],
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
              style: TextStyle(fontSize: 16.0,fontWeight: FontWeight.bold),
            ),
          ),
        );
      },
    );
  }
}
