import 'package:filmdevelopmentcompanion/io/FilmOrderStatusProviders.dart';
import 'package:filmdevelopmentcompanion/model/FilmDevelopmentOrder.dart';
import 'package:filmdevelopmentcompanion/model/FilmDevelopmentStatus.dart';

class StoreModel {
  FilmDevelopmentStatusProvider statusProvider;

  String formatSummaryStateTextForUI(String summaryStateText) {
    return summaryStateText;
  }

  String formatStoreOrderIdForUI(String orderId, String storeId) {
    return "$orderId // $storeId";
  }

  Future<FilmDevelopmentStatus> update(FilmDevelopmentOrder order) async {
    return await statusProvider.obtainDevelopmentStatusForFilmOrder(order);
  }

  String get providerId {
    print("Not implemented should be used as an interface");
    return null;
  }

  String get providerName {
    print("Not implemented should be used as an interface");
    return null;
  }

  String get providerNameUi {
    print("Not implemented should be used as an interface");
    return null;
  }

  static StoreModel storeModelFromId(String id) {
    switch (id) {
      case DmDeStoreModel.PROVIDER_ID:
        return DmDeStoreModel.instance;
      case RossmannStoreModel.PROVIDER_ID:
        return RossmannStoreModel.instance;
    }
    return null;
  }
}

class DmDeStoreModel extends StoreModel {
  static const String PROVIDER_ID = "DM_DE_PROVIDER";
  static const String PROVIDER_NAME = "dm Deutschland";
  static const String PROVIDER_NAME_UI = "dm";
  static final DmDeStoreModel _instance = DmDeStoreModel._internal();

  DmDeStoreModel._internal() {
    statusProvider = new DmDeStatusProvider();
  }

  static DmDeStoreModel get instance => _instance;

  @override
  String formatSummaryStateTextForUI(String summaryStateText) {
    return summaryStateText.split(".")[0];
  }

  @override
  String get providerId => PROVIDER_ID;

  @override
  String get providerName => PROVIDER_NAME;

  @override
  String get providerNameUi => PROVIDER_NAME_UI;
}

class RossmannStoreModel extends StoreModel {
  static const String PROVIDER_ID = "ROSSMANN_PROVIDER";
  static const String PROVIDER_NAME = "Rossmann";
  static const String PROVIDER_NAME_UI = "Rossmann";
  static final RossmannStoreModel _instance = RossmannStoreModel._internal();

  RossmannStoreModel._internal() {
    statusProvider = new RossmannStatusProvider();
  }

  static RossmannStoreModel get instance => _instance;

  @override
  String get providerId => PROVIDER_ID;

  @override
  String get providerName => PROVIDER_NAME;

  @override
  String get providerNameUi => PROVIDER_NAME_UI;
}
