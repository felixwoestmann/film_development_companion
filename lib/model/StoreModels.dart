class StoreModel {
  String get providerId {
    print("Not implemented should be used as an interface");
    return "";
  }

  String get providerName {
    print("Not implemented should be used as an interface");
    return "";
  }

  String formatSummaryStateTextForUI(String summaryStateText) {
    return "Has to be implemented in implementing types";
  }

  String formatStoreOrderIdForUI(String orderId, String storeId) {
    return "Has to be implemented in implementing types";
  }

  static StoreModel storeModelFromId(String id) {
    switch (id) {
      case DmDeStoreModel.PROVIDER_ID:
        return new DmDeStoreModel();
      case RossmannStoreModel.PROVIDER_ID:
        return new RossmannStoreModel();
    }
    return null;
  }
}

class DmDeStoreModel implements StoreModel {
  static const PROVIDER_ID = "DM_DE_PROVIDER";
  static const PROVIDER_NAME = "dm Deutschland";

  @override
  String get providerId => PROVIDER_ID;

  @override
  String get providerName => PROVIDER_NAME;

  @override
  String formatSummaryStateTextForUI(String summaryStateText) {
    return summaryStateText.split(".")[0];
  }

  @override
  String formatStoreOrderIdForUI(String orderId, String storeId) {
    return "$orderId - $storeId";
  }
}

class RossmannStoreModel implements StoreModel {
  static const PROVIDER_ID = "ROSSMANN_PROVIDER";
  static const PROVIDER_NAME = "Rossmann";

  @override
  String get providerId => PROVIDER_ID;

  @override
  String get providerName => PROVIDER_NAME;

  @override
  String formatSummaryStateTextForUI(String summaryStateText) {
    return summaryStateText;
  }

  @override
  String formatStoreOrderIdForUI(String orderId, String storeId) {
    return "$orderId - $storeId";
  }
}
