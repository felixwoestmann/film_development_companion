class StoreModel {
  String get providerId {
    print("Not implemented should be used as an interface");
    return "";
  }

  String get providerName {
    print("Not implemented should be used as an interface");
    return "";
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
}

class RossmannStoreModel extends StoreModel {
  static const PROVIDER_ID = "ROSSMANN_PROVIDER";
  static const PROVIDER_NAME = "Rossmann";

  @override
  String get providerId => PROVIDER_ID;

  @override
  String get providerName => PROVIDER_NAME;
}
