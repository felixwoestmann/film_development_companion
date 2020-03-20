import 'package:filmdevelopmentcompanion/model/StoreModel.dart';

class DmDeStoreModel implements StoreModel{
  static const PROVIDER_ID="DM_DE_PROVIDER";
  static const PROVIDER_NAME="DM Deutschland";

  @override
  String get providerId => PROVIDER_ID;

  @override
  String get providerName => PROVIDER_NAME;



}