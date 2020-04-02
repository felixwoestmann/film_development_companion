import 'package:filmdevelopmentcompanion/io/DmDeStatusProvider.dart';
import 'package:filmdevelopmentcompanion/io/FilmDevelopmentStatusProvider.dart';
import 'package:filmdevelopmentcompanion/io/RossmannStatusProvider.dart';

import '../model/StoreModels.dart';

class StatusProviderFactory {
  static FilmDevelopmentStatusProvider createStatusProviderForStoreModel(
      StoreModel storeModel) {
    switch (storeModel.providerId) {
      case DmDeStoreModel.PROVIDER_ID:
        return DmDeStatusProvider.instance;
      case RossmannStoreModel.PROVIDER_ID:
        return RossmannStatusProvider.instance;
      default:
        {
          print("StoreModel couldn't be recognized");
          return null;
        }
    }
  }
}
