import 'package:filmdevelopmentcompanion/model/DmDeStoreModel.dart';

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
        {
          return new DmDeStoreModel();
        }
        break;
    }
  }
}
