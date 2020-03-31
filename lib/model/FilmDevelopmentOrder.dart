import 'dart:async';

import 'package:filmdevelopmentcompanion/io/DatabaseHelpers.dart';
import 'package:filmdevelopmentcompanion/model/FilmDevelopmentStatus.dart';
import 'package:filmdevelopmentcompanion/io/FilmDevelopmentStatusProvider.dart';
import 'package:filmdevelopmentcompanion/io/StatusProviderFactory.dart';
import 'package:filmdevelopmentcompanion/model/StoreModel.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'FilmDevelopmentStatusSummary.dart';

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
  FilmDevelopmentStatus latestFilmDevelopmentStatusUpdate;
  StoreModel storeModel;

  FilmDevelopmentOrder(
      StoreModel storeModel, String orderNumber, String storeId) {
    this.orderNumber = orderNumber;
    this.storeModel = storeModel;
    this.storeId = storeId;
    insertionDate = DateTime.now();
  }

  Future<void> update() async {
    FilmDevelopmentStatusProvider statusProvider =
        StatusProviderFactory.createStatusProviderForStoreModel(storeModel);
    FilmDevelopmentStatus statusUpdate =
        await statusProvider.obtainDevelopmentStatusForFilmOrder(this);
    latestFilmDevelopmentStatusUpdate = statusUpdate;
  }

  String get insertionDateGui {
    return new DateFormat.MMMd("de_DE").format(insertionDate);
  }

  String get price {
    if (latestFilmDevelopmentStatusUpdate != null) {
      if (latestFilmDevelopmentStatusUpdate.price != 0.0) {
        return "${latestFilmDevelopmentStatusUpdate.price} €";
      }
    }
    return "";
  }

  String get latestFilmDevelopmentStatusSummaryText {
    if (latestFilmDevelopmentStatusUpdate != null) {
      return latestFilmDevelopmentStatusUpdate.statusSummaryText.split(".")[0];
    } else {
      return "";
    }
  }

  IconData get iconforstatus {
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
        case FilmDevelopmentStatusSummary.DONE:
          return Icons.store_mall_directory;
        default:
          return Icons.not_listed_location;
      }
    }
  }

  FilmDevelopmentOrder.fromMap(Map<String, dynamic> map) {
    id = map[DatabaseHelper.columnId];
    orderNumber = map[DatabaseHelper.columnOrderNumber];
    storeId = map[DatabaseHelper.columnStoreId];
    insertionDate = DateTime.fromMillisecondsSinceEpoch(
        map[DatabaseHelper.columnInsertionDate]);
    storeModel =
        StoreModel.storeModelFromId(map[DatabaseHelper.columnStoreModel]);
    //Check if there was a persistet FilmDev Order
    if (map[DatabaseHelper.columnStatusFetchTime] != null) {
      latestFilmDevelopmentStatusUpdate = FilmDevelopmentStatus.fromMap(map);
    }
  }

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      DatabaseHelper.columnOrderNumber: orderNumber,
      DatabaseHelper.columnStoreId: storeId,
      DatabaseHelper.columnInsertionDate: insertionDate.millisecondsSinceEpoch,
      DatabaseHelper.columnStoreModel: storeModel.providerId,
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
