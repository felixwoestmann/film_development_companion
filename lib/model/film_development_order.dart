import 'dart:async';
import 'package:filmdevelopmentcompanion/io/database_helpers.dart';
import 'package:filmdevelopmentcompanion/model/film_development_status.dart';
import 'package:filmdevelopmentcompanion/model/store_models/store_model.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'film_development_status_summary.dart';

/// A FilmDevelopmentOrder represents an order to develop a film at a lab.
/// id: the unique id of this film order
/// orderNumber: the number given by the store to identify the order
/// storeId: the identifier for a specific store location used by the film lab
/// providerId: the type of store, for example the chain where the specific store belongs to
/// insertionDate: the date when the order has been added to the app
/// filmDevelopmentStatusUpdates: a list with all the status updates for this specific order
class FilmDevelopmentOrder {
  int id;
  String orderId;
  String storeId;
  String note;
  DateTime insertionDate;
  FilmDevelopmentStatus latestFilmDevelopmentStatusUpdate;
  StoreModel storeModel;

  FilmDevelopmentOrder(
      StoreModel storeModel, String orderId, String storeId, String note) {
    this.orderId = orderId;
    this.storeModel = storeModel;
    this.storeId = storeId;
    this.note = note;
    this.insertionDate = DateTime.now();
  }

  Future<void> update() async {
    FilmDevelopmentStatus statusUpdate = await storeModel.update(this);
    //If the order has no update than store the current one
    if (latestFilmDevelopmentStatusUpdate == null) {
      latestFilmDevelopmentStatusUpdate = statusUpdate;
    } else {
      //If the order already has a status, than only store the newly fetched one if they differ
      if (statusUpdate.statusSummary.index >=
          latestFilmDevelopmentStatusUpdate.statusSummary.index) {
        latestFilmDevelopmentStatusUpdate = statusUpdate;
      }
    }
  }

  String get insertionDateGui =>
      new DateFormat.MMMd("de_DE").format(insertionDate);

  String get price {
    if (latestFilmDevelopmentStatusUpdate != null) {
      if (latestFilmDevelopmentStatusUpdate.price != 0.0) {
        NumberFormat numFormat = new NumberFormat("####.00", "de_DE");
        return numFormat.format(latestFilmDevelopmentStatusUpdate.price);
      }
    }
    return "-";
  }

  String get storeOrderId =>
      storeModel.formatStoreOrderIdForUI(orderId, storeId);

  String get latestFilmDevelopmentStatusSummaryText {
    if (latestFilmDevelopmentStatusUpdate != null) {
      return storeModel.formatSummaryStateTextForUI(
          latestFilmDevelopmentStatusUpdate.statusSummaryText);
    } else {
      return "";
    }
  }

  IconData get iconForStatus {
    if (latestFilmDevelopmentStatusUpdate == null) {
      return Icons.not_listed_location;
    } else {
      switch (latestFilmDevelopmentStatusUpdate.statusSummary) {
        case FilmDevelopmentStatusSummary.UNKNOWN_ERROR:
          return Icons.not_listed_location;
        case FilmDevelopmentStatusSummary.PROCESSING:
          return Icons.loop;
          break;
        case FilmDevelopmentStatusSummary.SHIPPING:
          return Icons.local_shipping;
        case FilmDevelopmentStatusSummary.DELIVERED:
          return Icons.store_mall_directory;
        default:
          return Icons.not_listed_location;
      }
    }
  }

  FilmDevelopmentOrder.fromMap(Map<String, dynamic> map) {
    id = map[DatabaseHelper.columnId];
    orderId = map[DatabaseHelper.columnOrderNumber];
    storeId = map[DatabaseHelper.columnStoreId];
    insertionDate = DateTime.fromMillisecondsSinceEpoch(
        map[DatabaseHelper.columnInsertionDate]);
    storeModel =
        StoreModel.storeModelFromId(map[DatabaseHelper.columnStoreModel]);
    note = map[DatabaseHelper.columnNote];
    //Check if there was a persistet FilmDev Order
    if (map[DatabaseHelper.columnStatusFetchTime] != null) {
      latestFilmDevelopmentStatusUpdate = FilmDevelopmentStatus.fromMap(map);
    }
  }

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      DatabaseHelper.columnOrderNumber: orderId,
      DatabaseHelper.columnStoreId: storeId,
      DatabaseHelper.columnInsertionDate: insertionDate.millisecondsSinceEpoch,
      DatabaseHelper.columnStoreModel: storeModel.providerId,
      DatabaseHelper.columnNote: note,
      //FilmDevStatus
    };

    if (latestFilmDevelopmentStatusUpdate != null) {
      map.addAll(latestFilmDevelopmentStatusUpdate.toMap());
    }

    if (id != null) {
      map[DatabaseHelper.columnId] = id;
    }
    return map;
  }
}
