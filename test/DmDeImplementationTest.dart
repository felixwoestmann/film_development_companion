import 'package:filmdevelopmentcompanion/model/DmDeStoreModel.dart';
import 'package:filmdevelopmentcompanion/model/FilmDevelopmentOrder.dart';
import 'package:filmdevelopmentcompanion/model/StoreModel.dart';

void main() async {
  StoreModel dmDeStoreModel = new DmDeStoreModel();
  FilmDevelopmentOrder filmOderOne =
      FilmDevelopmentOrder(dmDeStoreModel, "854447", "538050");
  FilmDevelopmentOrder filmOderTwo =
      FilmDevelopmentOrder(dmDeStoreModel, "854440", "538050");
  await filmOderOne.update();
  await filmOderTwo.update();

  print(filmOderOne.filmDevelopmentStatusUpdates.length);
  print(filmOderTwo.filmDevelopmentStatusUpdates.length);
}
