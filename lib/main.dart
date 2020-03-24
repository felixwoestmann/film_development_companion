import 'package:filmdevelopmentcompanion/model/FilmDevelopmentOrder.dart';
import 'package:flutter/material.dart';
import 'model/DmDeStoreModel.dart';
import 'model/StoreModel.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.yellow,
      ),
      home: MyHomePage(title: 'Film Development Companion'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();



}

class _MyHomePageState extends State<MyHomePage> {
  List<FilmDevelopmentOrder> filmOrders = new List();

  @override
  void initState() {
    super.initState();
    loadFilmOrders();
    updateAllOrders().then((_) => setState(() {}));
  }


  void _addItemToList(FilmDevelopmentOrder filmOrder) {
    setState(() {
      // This call to setState tells the Flutter framework that something has
      // changed in this State, which causes it to rerun the build method below
      // so that the display can reflect the updated values. If we changed
      // _counter without calling setState(), then the build method would not be
      // called again, and so nothing would appear to happen.
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
    for (var value in filmOrders) {
      await value.update();
    }
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: ListView.builder(
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
                        padding:
                            const EdgeInsets.fromLTRB(12.0, 12.0, 12.0, 6.0),
                        child: Text(
                          filmOrders[position].insertionDate.toIso8601String(),
                          style: TextStyle(fontSize: 15.0),
                        ),
                      ),
                      Padding(
                        padding:
                            const EdgeInsets.fromLTRB(12.0, 12.0, 12.0, 6.0),
                        child: Text(
                          filmOrders[position]
                              .latestFilmDevelopmentStatusSummaryText,
                          style: TextStyle(fontSize: 22.0),
                        ),
                      ),
                      Padding(
                          padding:
                              const EdgeInsets.fromLTRB(12.0, 6.0, 12.0, 12.0),
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
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Add your onPressed code here!
        },
        child: Icon(Icons.add),
        backgroundColor: Colors.yellowAccent,
      ),
    );
  }
}
