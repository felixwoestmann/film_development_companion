import 'package:filmdevelopmentcompanion/model/FilmDevelopmentOrder.dart';
import 'package:filmdevelopmentcompanion/model/FilmDevelopmentOrderDataHolder.dart';
import 'package:filmdevelopmentcompanion/view/ChooseStoreTypePage.dart';
import 'package:flutter/material.dart';
import '../model/DmDeStoreModel.dart';
import '../model/StoreModel.dart';

class FilmOrderOverviewPage extends StatefulWidget {
  FilmOrderOverviewPage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _FilmOrderOverviewPageState createState() => _FilmOrderOverviewPageState();
}

class _FilmOrderOverviewPageState extends State<FilmOrderOverviewPage> {
  @override
  void initState() {
    super.initState();
    updateOrdersAndDisplay();
  }

  Future<void> doStuff() {
    print("invoked");
  }

  void updateOrdersAndDisplay() {
    FilmDevelopmentDataHolder.instance
        .updateAllOrders()
        .then((_) => setState(() {}));
  }

  @override
  Widget build(BuildContext context) {
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
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.fromLTRB(
                                12.0, 12.0, 12.0, 6.0),
                            child: Text(
                              FilmDevelopmentDataHolder
                                  .instance.filmOrders[position].insertionDate
                                  .toIso8601String(),
                              style: TextStyle(fontSize: 15.0),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(
                                12.0, 12.0, 12.0, 6.0),
                            child: Text(
                              FilmDevelopmentDataHolder
                                  .instance
                                  .filmOrders[position]
                                  .latestFilmDevelopmentStatusSummaryText,
                              style: TextStyle(fontSize: 22.0),
                            ),
                          ),
                          Padding(
                              padding: const EdgeInsets.fromLTRB(
                                  12.0, 6.0, 12.0, 12.0),
                              child: Row(
                                children: <Widget>[
                                  Text(
                                    FilmDevelopmentDataHolder.instance
                                        .filmOrders[position].orderNumber,
                                    style: TextStyle(
                                        fontSize: 22.0,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Padding(
                                      padding: const EdgeInsets.fromLTRB(
                                          8.0, 0.0, 0.0, 0.0)),
                                  Text(
                                      FilmDevelopmentDataHolder.instance
                                          .filmOrders[position].storeId,
                                      style: TextStyle(fontSize: 18.0))
                                ],
                              )),
                        ],
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
            itemCount: FilmDevelopmentDataHolder.instance.filmOrders.length,
          ),
          onRefresh: doStuff),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => ChooseStoreTypePage()));
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
