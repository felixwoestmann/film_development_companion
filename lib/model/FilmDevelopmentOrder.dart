import 'dart:async';

import 'package:filmdevelopmentcompanion/io/DatabaseHelpers.dart';
import 'package:filmdevelopmentcompanion/model/FilmDevelopmentStatus.dart';
import 'package:filmdevelopmentcompanion/io/FilmDevelopmentStatusProvider.dart';
import 'package:filmdevelopmentcompanion/io/StatusProviderFactory.dart';
import 'package:filmdevelopmentcompanion/model/StoreModel.dart';
import 'package:intl/intl.dart';

/// A FilmDevelopmentOrder represents an order to develop a film at a lab.
/// id: the unique id of this film order
/// orderNumber: the number given by the store to identify the order
/// storeId: the identifier for a specific store location used by the film lab
/// providerId: the type of store, for example the chain where the specific store belongs to
/// insertionDate: the date when the order has been added to the app
/// filmDevelopmentStatusUpdates: a list with all the status updates for this specific order
class FilmDevelopmentOrder {
  int id;
  String orderNumber;
  String storeId;
  DateTime insertionDate;
  List<FilmDevelopmentStatus> filmDevelopmentStatusUpdates;
  StoreModel storeModel;

  FilmDevelopmentOrder(
      StoreModel storeModel, String orderNumber, String storeId) {
    this.orderNumber = orderNumber;
    this.storeModel = storeModel;
    this.storeId = storeId;
    filmDevelopmentStatusUpdates = new List<FilmDevelopmentStatus>();
    insertionDate = DateTime.now();
  }

  Future<void> update() async {
    FilmDevelopmentStatusProvider statusProvider =
        StatusProviderFactory.createStatusProviderForStoreModel(storeModel);
    FilmDevelopmentStatus statusUpdate =
        await statusProvider.obtainDevelopmentStatusForFilmOrder(this);
    filmDevelopmentStatusUpdates.add(statusUpdate);
  }

  String get insertionDateGui {
    return new DateFormat.MMMd("de_DE").format(insertionDate);
  }

  String get latestFilmDevelopmentStatusSummaryText {
    if (filmDevelopmentStatusUpdates.isEmpty) {
      return "";
    } else {
      return filmDevelopmentStatusUpdates.last.statusSummaryText.split(".")[0];
    }
  }

  FilmDevelopmentOrder.fromMap(Map<String, dynamic> map) {
    id = map[DatabaseHelper.columnId];
    orderNumber = map[DatabaseHelper.columnOrderNumber];
    storeId = map[DatabaseHelper.columnStoreId];
    insertionDate = DateTime.parse(map[DatabaseHelper.columnInsertionDate]);
    filmDevelopmentStatusUpdates = new List();
    storeModel =
        StoreModel.storeModelFromId(map[DatabaseHelper.columnStoreModel]);
  }

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      DatabaseHelper.columnOrderNumber: orderNumber,
      DatabaseHelper.columnStoreId: storeId,
      DatabaseHelper.columnInsertionDate: insertionDate.toIso8601String(),
      DatabaseHelper.columnStoreModel: storeModel.providerId,
    };
    if (id != null) {
      map[DatabaseHelper.columnId] = id;
    }
    return map;
  }
}
