import 'package:filmdevelopmentcompanion/io/DmDeStatusProvider.dart';

import '../model/StoreModels.dart';

class StatusProviderFactory {
  static DmDeStatusProvider createStatusProviderForStoreModel(
      StoreModel storeModel) {
    switch (storeModel.providerId) {
      case DmDeStoreModel.PROVIDER_ID:
        {
          return DmDeStatusProvider.instance;
        }
      default:
        {
          print("StoreModel couldn't be recognized");
          return null;
        }
    }
  }
}
