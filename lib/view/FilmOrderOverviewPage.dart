import 'package:filmdevelopmentcompanion/model/FilmDevelopmentOrder.dart';
import 'package:filmdevelopmentcompanion/model/FilmDevelopmentAppDataModel.dart';
import 'package:filmdevelopmentcompanion/view/ChooseStoreTypePage.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../model/DmDeStoreModel.dart';
import '../model/StoreModel.dart';

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
                  return Column(
                    children: <Widget>[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Flexible(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Padding(
                                  padding: const EdgeInsets.fromLTRB(
                                      12.0, 12.0, 12.0, 0.0),
                                  child: Text(
                                    "[ "+filmordermodel
                                        .filmOrders[position].insertionDateGui+" ]",
                                    style: TextStyle(fontSize: 15.0),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.fromLTRB(
                                      12.0, 6.0, 12.0, 0.0),
                                  child: Text(
                                    filmordermodel.filmOrders[position]
                                        .latestFilmDevelopmentStatusSummaryText,
                                    style: TextStyle(fontSize: 22.0),
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                                Padding(
                                    padding: const EdgeInsets.fromLTRB(
                                        12.0, 6.0, 12.0, 12.0),
                                    child: Row(
                                      children: <Widget>[
                                        Text(
                                          filmordermodel
                                              .filmOrders[position].orderNumber,
                                          style: TextStyle(
                                              fontSize: 22.0,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        Padding(
                                            padding: const EdgeInsets.fromLTRB(
                                                8.0, 0.0, 0.0, 0.0)),
                                        Text(
                                            filmordermodel
                                                .filmOrders[position].storeId,
                                            style: TextStyle(fontSize: 18.0))
                                      ],
                                    )),
                              ],
                            ),
                          ),
                        ],
                      ),
                      Divider(
                        height: 2.0,
                        color: Colors.grey[200],
                      )
                    ],
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
            label: Text('Add Order'),
          ),
        );
      },
    );
  }
}
