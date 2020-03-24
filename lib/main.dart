import 'package:filmdevelopmentcompanion/model/FilmDevelopmentOrder.dart';
import 'package:flutter/material.dart';
import 'model/DmDeStoreModel.dart';
import 'model/StoreModel.dart';

void main() => runApp(FilmDevCompanionApp());

class FilmDevCompanionApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.yellow,
      ),
      home: FilmOrderOverviewPage(title: 'Film Development Companion'),
    );
  }
}

class FilmOrderOverviewPage extends StatefulWidget {
  FilmOrderOverviewPage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _FilmOrderOverviewPageState createState() => _FilmOrderOverviewPageState();
}

class _FilmOrderOverviewPageState extends State<FilmOrderOverviewPage> {
  List<FilmDevelopmentOrder> filmOrders = new List();

  @override
  void initState() {
    super.initState();
    loadFilmOrders();
    updateAllOrders();
  }

  void _addItemToList(FilmDevelopmentOrder filmOrder) {
    setState(() {
      filmOrders.add(filmOrder);
    });
  }

  void loadFilmOrders() {
    StoreModel dmDeStoreModel = new DmDeStoreModel();
    FilmDevelopmentOrder filmOrderOne =
        FilmDevelopmentOrder(dmDeStoreModel, "854447", "1618");
    FilmDevelopmentOrder filmOrderTwo =
        FilmDevelopmentOrder(dmDeStoreModel, "854440", "1618");
    _addItemToList(filmOrderOne);
    _addItemToList(filmOrderTwo);
  }

  Future<void> updateAllOrders() async {
    List<Future> futures = <Future>[];
    for (var order in filmOrders) {
      futures.add(order.update());
    }
    await Future.wait(futures);
    setState(() {});
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
                                filmOrders[position]
                                    .insertionDate
                                    .toIso8601String(),
                                style: TextStyle(fontSize: 15.0),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.fromLTRB(
                                  12.0, 12.0, 12.0, 6.0),
                              child: Text(
                                filmOrders[position]
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
                                      filmOrders[position].orderNumber,
                                      style: TextStyle(
                                          fontSize: 22.0,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Padding(
                                        padding: const EdgeInsets.fromLTRB(
                                            8.0, 0.0, 0.0, 0.0)),
                                    Text(filmOrders[position].storeId,
                                        style: TextStyle(fontSize: 18.0))
                                  ],
                                )),
                          ],
                        ),
                      ],
                    ),
                    Divider(
                      height: 2.0,
                      color: Colors.grey,
                    )
                  ],
                );
              },
              itemCount: filmOrders.length,
            ),
            onRefresh: updateAllOrders));
  }
}
