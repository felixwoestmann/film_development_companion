import 'package:filmdevelopmentcompanion/FilmDevelopmentStatus.dart';

/// A FilmDevelopmentOrder represents an order to develop a film at a lab.
/// id: the unique id of this film order
/// orderNumber: the number given by the store to identify the order
/// storeId: the identifier for a specific store location used by the film lab
/// providerId: the type of store, for example the chain where the specific store belongs to
/// insertionDate: the date when the order has been made
/// filmDevelopmentStatusUpdates: a list with all the status updates for this specific order
class FilmDevelopmentOrder {
  int id;
  String orderNumber;
  String storeId;
  String providerId;
  DateTime insertionDate;
  List<FilmDevelopmentStatus> filmDevelopmentStatusUpdates;
}