import 'package:filmdevelopmentcompanion/localizations.dart';
import 'package:filmdevelopmentcompanion/model/film_development_appdata_model.dart';
import 'package:filmdevelopmentcompanion/view/misc/third_party_license_page.dart';
import 'package:filmdevelopmentcompanion/view/overview/compact_film_order_card.dart';
import 'package:filmdevelopmentcompanion/view/standard_film_oder_card.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../model/shared_preferences_helper.dart';

class FilmOrderOverviewPage extends StatefulWidget {
  @override
  _FilmOrderOverviewPageState createState() => _FilmOrderOverviewPageState();
}

class _FilmOrderOverviewPageState extends State<FilmOrderOverviewPage> {
  Future<bool> loadCompactViewPreference;
  bool compactView = false;

  @override
  void initState() {
    super.initState();
    // Initialize Future to then wait for it in FutureBuild
    loadCompactViewPreference = loadCompactViewPref();
  }

  Future<bool> loadCompactViewPref() async {
    bool compactViewPref = await SharedPreferencesHelper().loadCompactViewPreference();
    compactView = compactViewPref;
    return compactViewPref;
  }

  void toggleCompactView() {
    setState(() => compactView = !compactView);
    SharedPreferencesHelper().saveCompactViewPreference(compactView);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
        title: Text(
          AppLocalizations.of(context).translate('FilmOrderOverviewPageTitle'),
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        actions: <Widget>[
          IconButton(
            icon: compactView ? Icon(Icons.view_agenda) : Icon(Icons.view_compact),
            onPressed: toggleCompactView,
          ),
          PopupMenuButton<Widget>(
            onSelected: (value) => Navigator.push(context, MaterialPageRoute(builder: (context) => value)),
            itemBuilder: (context) => [
              PopupMenuItem(
                value: LicensePage(),
                child: Text(AppLocalizations.of(context).translate('FilmOrderOverviewFlutterLicensesLabel')),
              ),
              PopupMenuItem(
                value: ThirdPartyLicensesPage(),
                child: Text(AppLocalizations.of(context).translate('FilmOrderOverviewThirdpartyLicensesLabel')),
              ),
            ],
          )
        ],
      ),
      body: Consumer<FilmDevelopmentAppDataModel>(builder: (context, filmOderModel, child) {
        return FutureBuilder(
            future: loadCompactViewPreference,
            builder: (context, AsyncSnapshot<bool> result) {
              if (result.hasData) {
                return RefreshIndicator(
                  onRefresh: filmOderModel.updateAllOrders,
                  child: ListView.builder(
                    itemCount: filmOderModel.filmOrders.length,
                    itemBuilder: (context, position) {
                      return Dismissible(
                        key: Key(filmOderModel.filmOrders[position].id.toString()),
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
                        onDismissed: (direction) => filmOderModel.deleteFilmOrder(position),
                        direction: DismissDirection.startToEnd,
                        child: Card(
                          elevation: 8,
                          margin: EdgeInsets.fromLTRB(8, 10, 8, 10),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(18.0),
                          ),
                          child: compactView
                              ? CompactFilmOrderCard(filmOderModel.filmOrders[position])
                              : StandardFilmOderCard(filmOderModel.filmOrders[position]),
                        ),
                      );
                    },
                  ),
                );
              } else {
                return Center(
                  child: CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation<Color>(Theme.of(context).colorScheme.secondary),
                  ),
                );
              }
            });
      }),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => Navigator.pushNamed(context, '/chooseStore'),
        icon: Icon(Icons.add),
        label: Text(
          AppLocalizations.of(context).translate('FilmOrderOverviewButton'),
          style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
