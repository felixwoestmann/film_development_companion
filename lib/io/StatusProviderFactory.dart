import 'package:filmdevelopmentcompanion/io/DmDeStatusProvider.dart';
import 'package:filmdevelopmentcompanion/model/DmDeStoreModel.dart';

import '../model/StoreModel.dart';

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
